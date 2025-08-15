
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/greet.dart';
import './team/create_team.dart';
import './team/manage_team.dart';
import '../widgets/gathering.dart';
// import '../service/handle_teams.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Map<String, String>> _teams = []; // Store teamId and name as strings

  @override
  void initState() {
    super.initState();
    _fetchTeamIds();
  }

  Future<void> _fetchTeamIds() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('current_teams')
          .get();
      final teams = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'teamId': doc.id as String,
          'name': data['name'] as String,
        };
      }).toList();
      print('Fetched teams: $teams');
      setState(() {
        _teams = teams.cast<Map<String, String>>(); // Update teams state
      });
    } catch (e) {
      print('Error fetching team IDs: $e');
    }
  }

  Future<void> _showLeaveTeamDialog(String teamId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Leave Gathering'),
          content: Text('Are you sure you want to leave this gathering?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
                    final memberRef = teamRef.collection('members').doc(user.uid);
                    final userTeamRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('current_teams')
                        .doc(teamId);

                    await FirebaseFirestore.instance.runTransaction((transaction) async {
                      final teamDoc = await transaction.get(teamRef);
                      if (teamDoc.exists && !teamDoc.data()!['isSelf']) {
                        transaction.update(memberRef, {'status': 'left'});
                        transaction.delete(userTeamRef);
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Left gathering')),
                    );
                    await _fetchTeamIds();
                  }
                } catch (e) {
                  print('Error leaving gathering: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error leaving gathering: $e')),
                  );
                }
                Navigator.pop(context);
              },
              child: Text('Leave'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              GreetWidget(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CreateTeamPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.blue[600]),
                      SizedBox(width: 10),
                      Text(
                        'Create Gathering',
                        style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _teams.isNotEmpty
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .collection('current_teams')
                          .snapshots()
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('Error loading teams: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting && _teams.isNotEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final teams = snapshot.data?.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return {
                        'teamId': doc.id as String,
                        'name': data['name'] as String,
                      };
                    }).toList() ?? [];
                    print('Teams loaded: ${teams.map((t) => t['teamId']).toList()}');
                    if (teams.isEmpty) {
                      return Center(child: Text('No gatherings yet'));
                    }
                    return ListView.builder(
                      itemCount: teams.length,
                      itemBuilder: (context, index) {
                        final team = teams[index];
                        final teamId = team['teamId']!;
                        final teamName = team['name']!;
                        final isAdmin = false; // Placeholder, should retrieve from Firebase
                        return GestureDetector(
                          onLongPress: () {
                            // Assuming !isSelf check is handled by Firestore or app logic
                            _showLeaveTeamDialog(teamId);
                          },
                          child: GatheringWidget(
                            teamId: teamId,
                            teamName: teamName,
                            isAdmin: isAdmin,
                            onTap: isAdmin
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ManageTeamPage(
                                          teamId: teamId,
                                          teamName: teamName,
                                          isAdmin: isAdmin,
                                        ),
                                      ),
                                    );
                                  }
                                : () {},
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}