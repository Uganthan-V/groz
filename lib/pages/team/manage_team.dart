import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class ManageTeamPage extends StatefulWidget {
  final String teamId;
  final String teamName;
  final bool isAdmin;

  const ManageTeamPage({
    super.key,
    required this.teamId,
    required this.teamName,
    required this.isAdmin,
  });

  @override
  _ManageTeamPageState createState() => _ManageTeamPageState();
}

class _ManageTeamPageState extends State<ManageTeamPage> {
  final _passwordController = TextEditingController();
  final _addMemberController = TextEditingController();
  bool _isPasswordVerified = false;
  final List<String> _confirmedEmails = [];
  List<String> _emailSuggestions = [];

  @override
  void dispose() {
    _passwordController.dispose();
    _addMemberController.dispose();
    super.dispose();
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  void _verifyPassword() async {
    try {
      final teamSnapshot = await FirebaseFirestore.instance.collection('teams').doc(widget.teamId).get();
      final passwordHash = _hashPassword(_passwordController.text);
      if (teamSnapshot.data()!['passwordHash'] == passwordHash) {
        setState(() {
          _isPasswordVerified = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password verified')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect password')),
        );
      }
    } catch (e) {
      print('Error verifying password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error verifying password: $e')),
      );
    }
  }

  void _addMember() async {
    final email = _addMemberController.text.trim();
    if (email.isNotEmpty) {
      try {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();
        if (userSnapshot.docs.isNotEmpty) {
          setState(() {
            _confirmedEmails.add(email);
            _addMemberController.clear();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email not found in registered users')),
          );
        }
      } catch (e) {
        print('Error validating email: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error validating email: $e')),
        );
      }
    }
  }

  void _sendJoinRequests() async {
    try {
      for (String email in _confirmedEmails) {
        if (email.isNotEmpty) {
          final userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();
          if (userSnapshot.docs.isNotEmpty) {
            final targetUserId = userSnapshot.docs.first.id;
            await FirebaseFirestore.instance.collection('team_requests').add({
              'teamId': widget.teamId,
              'userId': targetUserId,
              'teamName': widget.teamName,
              'status': 'pending',
              'createdAt': Timestamp.now(),
            });
          }
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Join requests sent')),
      );
      setState(() {
        _confirmedEmails.clear();
      });
    } catch (e) {
      print('Error sending join requests: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending join requests: $e')),
      );
    }
  }

  void _deleteTeam() async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(widget.teamId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Team deleted')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error deleting team: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting team: $e')),
      );
    }
  }

  void _leaveTeam() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final teamRef = FirebaseFirestore.instance.collection('teams').doc(widget.teamId);
        final memberRef = teamRef.collection('members').doc(user.uid);
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final teamDoc = await transaction.get(teamRef);
          if (teamDoc.exists) {
            transaction.delete(memberRef);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Left team')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error leaving team: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error leaving team: $e')),
      );
    }
  }

  void _fetchEmailSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _emailSuggestions = [];
      });
      return;
    }
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThanOrEqualTo: '$query\uf8ff')
          .limit(5)
          .get();
      setState(() {
        _emailSuggestions = snapshot.docs.map((doc) => doc['email'] as String).toList();
      });
    } catch (e) {
      print('Error fetching email suggestions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: Text('Manage Team: ${widget.teamName}')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are not the admin of this team.'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _leaveTeam,
                child: Text('Leave Team'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Manage Team: ${widget.teamName}')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_isPasswordVerified) ...[
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Enter Team Password'),
                validator: (value) => value == null || value.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _verifyPassword,
                child: Text('Verify Password'),
              ),
            ] else ...[
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  _fetchEmailSuggestions(textEditingValue.text);
                  return _emailSuggestions;
                },
                onSelected: (String selection) {
                  _addMemberController.text = selection;
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  _addMemberController.addListener(() {
                    _fetchEmailSuggestions(_addMemberController.text);
                  });
                  return TextFormField(
                    controller: _addMemberController,
                    focusNode: focusNode,
                    decoration: InputDecoration(labelText: 'Add Member Email'),
                    onFieldSubmitted: (value) => _addMember(),
                  );
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _addMember,
                child: Text('+ Add Member'),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _confirmedEmails
                    .map((email) => Chip(
                          label: Text(email),
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () {
                            setState(() {
                              _confirmedEmails.remove(email);
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _confirmedEmails.isNotEmpty ? _sendJoinRequests : null,
                child: Text('Send Join Requests'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _deleteTeam,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete Team'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}