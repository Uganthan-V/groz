

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../widgets/greet.dart';

// class NotifyPage extends StatefulWidget {
//   const NotifyPage({super.key});

//   @override
//   _NotifyPageState createState() => _NotifyPageState();
// }

// class _NotifyPageState extends State<NotifyPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   void _handleRequest(String requestId, String teamId, String action) async {
//     if (!mounted) return; // Check if widget is still mounted
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;

//       print('Handling request: $requestId, $teamId, $action'); // Debug log
//       final batch = FirebaseFirestore.instance.batch();
//       final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
//       final requestRef = FirebaseFirestore.instance.collection('team_requests').doc(requestId);

//       // Check if the team exists and the user is authorized to handle the request
//       final teamSnap = await teamRef.get();
//       if (!teamSnap.exists) {
//         print('Team does not exist.');
//         return;
//       }

//       final requestSnapshot = await requestRef.get();
//       if (!requestSnapshot.exists || requestSnapshot.data()?['userId'] != user.uid) {
//         print('Request does not exist or unauthorized.');
//         return;
//       }
//       if (requestSnapshot.data()?['status'] != 'pending') {
//         print('Request has already been processed.');
//         return;
//       }

//       final memberRef = teamRef.collection('members').doc(user.uid);

//       if (action == 'accept') {
//         batch.set(
//           memberRef,
//           {
//             'userId': user.uid,
//             'name': user.displayName ?? user.email!.split('@')[0], // Fallback to email username
//             'role': 'member',
//             'status': 'joined',
//             'joined_at': FieldValue.serverTimestamp(),
//           },
//           SetOptions(merge: true),
//         );
//         batch.update(requestRef, {'status': 'accepted'});

//         // Add team to current_teams in user's document
//         final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
//         batch.set(
//           userRef.collection('current_teams').doc(teamId),
//           {
//             'teamId': teamId,
//             'name': teamSnap.data()?['name'] ?? 'Unnamed Team',
//             'joined_at': FieldValue.serverTimestamp(),
//           },
//           SetOptions(merge: true),
//         );
//       } else if (action == 'decline') {
//         batch.update(requestRef, {'status': 'declined'});
//       }

//       await batch.commit();

//       if (mounted) {
//         scaffoldMessenger.showSnackBar(
//           SnackBar(content: Text('Request $action successfully')),
//         );
//       }
//     } catch (e) {
//       print('Error handling request: $e');
//       if (mounted) {
//         scaffoldMessenger.showSnackBar(
//           SnackBar(content: Text('Error handling request: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               GreetWidget(),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Gathering Requests',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey[300]!),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('team_requests')
//                               .where('userId', isEqualTo: user?.uid ?? '')
//                               .where('status', isEqualTo: 'pending')
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasError) {
//                               print(
//                                 'Error loading requests: ${snapshot.error}',
//                               );
//                               return Center(
//                                 child: Text('Error: ${snapshot.error}'),
//                               );
//                             }
//                             if (!snapshot.hasData) {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                             final requests = snapshot.data!.docs;
//                             if (requests.isEmpty) {
//                               return Center(
//                                 child: Text('No pending team requests'),
//                               );
//                             }
//                             return ListView.builder(
//                               padding: EdgeInsets.all(8.0),
//                               itemCount: requests.length,
//                               itemBuilder: (context, index) {
//                                 if (index >= 3) return SizedBox.shrink();
//                                 final requestData =
//                                     requests[index].data() as Map<String, dynamic>;
//                                 final requestId = requests[index].id;
//                                 final teamName =
//                                     requestData['teamName'] ?? 'Unnamed Team';
//                                 return Container(
//                                   margin: EdgeInsets.only(bottom: 8),
//                                   padding: EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue[100],
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         '$teamName',
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                       Row(
//                                         children: [
//                                           TextButton(
//                                             onPressed: () => _handleRequest(
//                                               requestId,
//                                               requestData['teamId'],
//                                               'accept',
//                                             ),
//                                             child: Text(
//                                               'Accept',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.green[600],
//                                               ),
//                                             ),
//                                           ),
//                                           TextButton(
//                                             onPressed: () => _handleRequest(
//                                               requestId,
//                                               requestData['teamId'],
//                                               'decline',
//                                             ),
//                                             child: Text(
//                                               'Decline',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.red[600],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'Other Notifications',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey[300]!),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: ListView(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           padding: EdgeInsets.all(8.0),
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(bottom: 8),
//                               padding: EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 'Notification 1: Sample notification',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(bottom: 8),
//                               padding: EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 'Notification 2: Another sample',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/greet.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleRequest(String requestId, String teamId, String action) async {
    if (!mounted) return; // Check if widget is still mounted
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      print('Handling request: $requestId, $teamId, $action'); // Debug log
      final batch = FirebaseFirestore.instance.batch();
      final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
      final requestRef = FirebaseFirestore.instance.collection('team_requests').doc(requestId);

      // Check if the team exists and the user is authorized to handle the request
      final teamSnap = await teamRef.get();
      if (!teamSnap.exists) {
        print('Team does not exist.');
        return;
      }

      final requestSnapshot = await requestRef.get();
      if (!requestSnapshot.exists || requestSnapshot.data()?['userId'] != user.uid) {
        print('Request does not exist or unauthorized.');
        return;
      }
      if (requestSnapshot.data()?['status'] != 'pending') {
        print('Request has already been processed.');
        return;
      }

      final memberRef = teamRef.collection('members').doc(user.uid);

      if (action == 'accept') {
        batch.set(
          memberRef,
          {
            'userId': user.uid,
            'name': user.displayName ?? user.email!.split('@')[0], // Fallback to email username
            'role': 'member',
            'status': 'joined',
            'joined_at': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
        batch.update(requestRef, {'status': 'accepted'});

        // Add team to current_teams in user's document
        final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        batch.set(
          userRef.collection('current_teams').doc(teamId),
          {
            'teamId': teamId,
            'name': teamSnap.data()?['name'] ?? 'Unnamed Team',
            'joined_at': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      } else if (action == 'decline') {
        batch.update(requestRef, {'status': 'declined'});
      }

      await batch.commit();

      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Request $action successfully')),
        );
      }
    } catch (e) {
      print('Error handling request: $e');
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error handling request: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      key: _scaffoldKey,
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
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gathering Requests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('team_requests')
                              .where('userId', isEqualTo: user?.uid ?? '')
                              .where('status', isEqualTo: 'pending')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(
                                'Error loading requests: ${snapshot.error}',
                              );
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final requests = snapshot.data!.docs;
                            if (requests.isEmpty) {
                              return Center(
                                child: Text('No pending team requests'),
                              );
                            }
                            return ListView.builder(
                              padding: EdgeInsets.all(8.0),
                              itemCount: requests.length,
                              itemBuilder: (context, index) {
                                if (index >= 3) return SizedBox.shrink();
                                final requestData =
                                    requests[index].data() as Map<String, dynamic>;
                                final requestId = requests[index].id;
                                final teamName =
                                    requestData['teamName'] ?? 'Unnamed Team';
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$teamName',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () => _handleRequest(
                                              requestId,
                                              requestData['teamId'],
                                              'accept',
                                            ),
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green[600],
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => _handleRequest(
                                              requestId,
                                              requestData['teamId'],
                                              'decline',
                                            ),
                                            child: Text(
                                              'Decline',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Other Notifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user?.uid)
                            .collection('notifications')
                            .orderBy('timestamp', descending: true)
                            .limit(10)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          final notifications = snapshot.data!.docs;
                          if (notifications.isEmpty) {
                            return Text('No new notifications');
                          }
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(8.0),
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final data = notifications[index].data() as Map<String, dynamic>;
                                final message = data['message'] ?? 'Unknown notification';
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    message,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}