// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:crypto/crypto.dart';
// // // // // import 'dart:convert';

// // // // // class CreateTeamPage extends StatefulWidget {
// // // // //   const CreateTeamPage({super.key});

// // // // //   @override
// // // // //   _CreateTeamPageState createState() => _CreateTeamPageState();
// // // // // }

// // // // // class _CreateTeamPageState extends State<CreateTeamPage> {
// // // // //   final _formKey = GlobalKey<FormState>();
// // // // //   final _teamNameController = TextEditingController();
// // // // //   final _emailController = TextEditingController();
// // // // //   final _passwordController = TextEditingController();
// // // // //   final _confirmPasswordController = TextEditingController();
// // // // //   List<String> _confirmedEmails = [];
// // // // //   List<String> _emailSuggestions = [];

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _teamNameController.dispose();
// // // // //     _emailController.dispose();
// // // // //     _passwordController.dispose();
// // // // //     _confirmPasswordController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   String _hashPassword(String password) {
// // // // //     return sha256.convert(utf8.encode(password)).toString();
// // // // //   }

// // // // //   void _addEmail() async {
// // // // //     final email = _emailController.text.trim();
// // // // //     if (email.isNotEmpty) {
// // // // //       try {
// // // // //         final userSnapshot = await FirebaseFirestore.instance
// // // // //             .collection('users')
// // // // //             .where('email', isEqualTo: email)
// // // // //             .get();
// // // // //         if (userSnapshot.docs.isNotEmpty) {
// // // // //           setState(() {
// // // // //             _confirmedEmails.add(email);
// // // // //             _emailController.clear();
// // // // //           });
// // // // //         } else {
// // // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // // //             SnackBar(content: Text('Email not found in registered users')),
// // // // //           );
// // // // //         }
// // // // //       } catch (e) {
// // // // //         print('Error validating email: $e');
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           SnackBar(content: Text('Error validating email: $e')),
// // // // //         );
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   void _fetchEmailSuggestions(String query) async {
// // // // //     if (query.isEmpty) {
// // // // //       setState(() {
// // // // //         _emailSuggestions = [];
// // // // //       });
// // // // //       return;
// // // // //     }
// // // // //     try {
// // // // //       final snapshot = await FirebaseFirestore.instance
// // // // //           .collection('users')
// // // // //           .where('email', isGreaterThanOrEqualTo: query)
// // // // //           .where('email', isLessThanOrEqualTo: query + '\uf8ff')
// // // // //           .limit(5)
// // // // //           .get();
// // // // //       setState(() {
// // // // //         _emailSuggestions = snapshot.docs.map((doc) => doc['email'] as String).toList();
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error fetching email suggestions: $e');
// // // // //     }
// // // // //   }

// // // // //   void _createTeam() async {
// // // // //     if (_formKey.currentState!.validate()) {
// // // // //       try {
// // // // //         final user = FirebaseAuth.instance.currentUser;
// // // // //         if (user == null) {
// // // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // // //             SnackBar(content: Text('No user logged in')),
// // // // //           );
// // // // //           return;
// // // // //         }
// // // // //         final teamName = _teamNameController.text.trim();
// // // // //         final passwordHash = _hashPassword(_passwordController.text);

// // // // //         final teamRef = await FirebaseFirestore.instance.collection('teams').add({
// // // // //           'name': teamName,
// // // // //           'admin': user.uid,
// // // // //           'passwordHash': passwordHash,
// // // // //           'members': [user.uid],
// // // // //         });

// // // // //         for (String email in _confirmedEmails) {
// // // // //           if (email.isNotEmpty && email != user.email) {
// // // // //             final userSnapshot = await FirebaseFirestore.instance
// // // // //                 .collection('users')
// // // // //                 .where('email', isEqualTo: email)
// // // // //                 .get();
// // // // //             if (userSnapshot.docs.isNotEmpty) {
// // // // //               final targetUserId = userSnapshot.docs.first.id;
// // // // //               await FirebaseFirestore.instance.collection('team_requests').add({
// // // // //                 'teamId': teamRef.id,
// // // // //                 'userId': targetUserId,
// // // // //                 'teamName': teamName,
// // // // //                 'status': 'pending',
// // // // //                 'createdAt': Timestamp.now(),
// // // // //               });
// // // // //             }
// // // // //           }
// // // // //         }

// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           SnackBar(content: Text('Team created, requests sent')),
// // // // //         );
// // // // //         Navigator.pop(context);
// // // // //       } catch (e) {
// // // // //         print('Error creating team: $e');
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           SnackBar(content: Text('Error creating team: $e')),
// // // // //         );
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: Text('Create New Team')),
// // // // //       body: Padding(
// // // // //         padding: EdgeInsets.all(16.0),
// // // // //         child: Form(
// // // // //           key: _formKey,
// // // // //           child: Column(
// // // // //             children: [
// // // // //               TextFormField(
// // // // //                 controller: _teamNameController,
// // // // //                 decoration: InputDecoration(labelText: 'Team Name'),
// // // // //                 validator: (value) => value == null || value.isEmpty ? 'Enter team name' : null,
// // // // //               ),
// // // // //               SizedBox(height: 16),
// // // // //               Autocomplete<String>(
// // // // //                 optionsBuilder: (TextEditingValue textEditingValue) {
// // // // //                   _fetchEmailSuggestions(textEditingValue.text);
// // // // //                   return _emailSuggestions;
// // // // //                 },
// // // // //                 onSelected: (String selection) {
// // // // //                   _emailController.text = selection;
// // // // //                 },
// // // // //                 fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
// // // // //                   _emailController.addListener(() {
// // // // //                     _fetchEmailSuggestions(_emailController.text);
// // // // //                   });
// // // // //                   return TextFormField(
// // // // //                     controller: _emailController,
// // // // //                     focusNode: focusNode,
// // // // //                     decoration: InputDecoration(labelText: 'Member Email'),
// // // // //                     onFieldSubmitted: (value) => _addEmail(),
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //               SizedBox(height: 8),
// // // // //               ElevatedButton(
// // // // //                 onPressed: _addEmail,
// // // // //                 child: Text('+ Add Member'),
// // // // //               ),
// // // // //               SizedBox(height: 8),
// // // // //               Wrap(
// // // // //                 spacing: 8,
// // // // //                 children: _confirmedEmails
// // // // //                     .map((email) => Chip(
// // // // //                           label: Text(email),
// // // // //                           deleteIcon: Icon(Icons.close),
// // // // //                           onDeleted: () {
// // // // //                             setState(() {
// // // // //                               _confirmedEmails.remove(email);
// // // // //                             });
// // // // //                           },
// // // // //                         ))
// // // // //                     .toList(),
// // // // //               ),
// // // // //               SizedBox(height: 16),
// // // // //               TextFormField(
// // // // //                 controller: _passwordController,
// // // // //                 obscureText: true,
// // // // //                 decoration: InputDecoration(labelText: 'Team Password'),
// // // // //                 validator: (value) => value == null || value.length < 6 ? 'Min 6 chars' : null,
// // // // //               ),
// // // // //               TextFormField(
// // // // //                 controller: _confirmPasswordController,
// // // // //                 obscureText: true,
// // // // //                 decoration: InputDecoration(labelText: 'Confirm Password'),
// // // // //                 validator: (value) =>
// // // // //                     value != _passwordController.text ? 'Passwords do not match' : null,
// // // // //               ),
// // // // //               SizedBox(height: 16),
// // // // //               ElevatedButton(
// // // // //                 onPressed: _createTeam,
// // // // //                 child: Text('Create Team'),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:crypto/crypto.dart';
// // // // import 'dart:convert';

// // // // class CreateTeamPage extends StatefulWidget {
// // // //   const CreateTeamPage({super.key});

// // // //   @override
// // // //   _CreateTeamPageState createState() => _CreateTeamPageState();
// // // // }

// // // // class _CreateTeamPageState extends State<CreateTeamPage> {
// // // //   final _formKey = GlobalKey<FormState>();
// // // //   final _teamNameController = TextEditingController();
// // // //   final _emailController = TextEditingController();
// // // //   final _passwordController = TextEditingController();
// // // //   final _confirmPasswordController = TextEditingController();
// // // //   List<String> _confirmedEmails = [];
// // // //   List<String> _emailSuggestions = [];

// // // //   @override
// // // //   void dispose() {
// // // //     _teamNameController.dispose();
// // // //     _emailController.dispose();
// // // //     _passwordController.dispose();
// // // //     _confirmPasswordController.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   String _hashPassword(String password) {
// // // //     return sha256.convert(utf8.encode(password)).toString();
// // // //   }

// // // //   void _addEmail() async {
// // // //     final email = _emailController.text.trim();
// // // //     if (email.isNotEmpty) {
// // // //       try {
// // // //         final userSnapshot = await FirebaseFirestore.instance
// // // //             .collection('users')
// // // //             .where('email', isEqualTo: email)
// // // //             .get();
// // // //         if (userSnapshot.docs.isNotEmpty) {
// // // //           setState(() {
// // // //             _confirmedEmails.add(email);
// // // //             _emailController.clear();
// // // //           });
// // // //         } else {
// // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // //             SnackBar(content: Text('Email not found in registered users')),
// // // //           );
// // // //         }
// // // //       } catch (e) {
// // // //         print('Error validating email: $e');
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Error validating email: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   void _fetchEmailSuggestions(String query) async {
// // // //     if (query.isEmpty) {
// // // //       setState(() {
// // // //         _emailSuggestions = [];
// // // //       });
// // // //       return;
// // // //     }
// // // //     try {
// // // //       final snapshot = await FirebaseFirestore.instance
// // // //           .collection('users')
// // // //           .where('email', isGreaterThanOrEqualTo: query)
// // // //           .where('email', isLessThanOrEqualTo: query + '\uf8ff')
// // // //           .limit(5)
// // // //           .get();
// // // //       setState(() {
// // // //         _emailSuggestions = snapshot.docs.map((doc) => doc['email'] as String).toList();
// // // //       });
// // // //     } catch (e) {
// // // //       print('Error fetching email suggestions: $e');
// // // //     }
// // // //   }

// // // //   void _createTeam() async {
// // // //     if (_formKey.currentState!.validate()) {
// // // //       try {
// // // //         final user = FirebaseAuth.instance.currentUser;
// // // //         if (user == null) {
// // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // //             SnackBar(content: Text('No user logged in')),
// // // //           );
// // // //           return;
// // // //         }
// // // //         final teamName = _teamNameController.text.trim();
// // // //         final passwordHash = _hashPassword(_passwordController.text);

// // // //         // Create team document
// // // //         final teamRef = await FirebaseFirestore.instance.collection('teams').add({
// // // //           'name': teamName,
// // // //           'admin': user.uid,
// // // //           'passwordHash': passwordHash,
// // // //           'members': [user.uid], // Initial member is the admin
// // // //         });

// // // //         // Initialize team_members for the admin
// // // //         await teamRef.collection('team_members').doc(user.uid).set({
// // // //           'userId': user.uid,
// // // //           'status': 'accepted',
// // // //           'joinedAt': FieldValue.serverTimestamp(),
// // // //         });

// // // //         // Send team requests to confirmed emails
// // // //         for (String email in _confirmedEmails) {
// // // //           if (email.isNotEmpty && email != user.email) {
// // // //             final userSnapshot = await FirebaseFirestore.instance
// // // //                 .collection('users')
// // // //                 .where('email', isEqualTo: email)
// // // //                 .get();
// // // //             if (userSnapshot.docs.isNotEmpty) {
// // // //               final targetUserId = userSnapshot.docs.first.id;
// // // //               await FirebaseFirestore.instance.collection('team_requests').add({
// // // //                 'teamId': teamRef.id,
// // // //                 'userId': targetUserId,
// // // //                 'teamName': teamName,
// // // //                 'status': 'pending',
// // // //                 'createdAt': Timestamp.now(),
// // // //               });
// // // //             }
// // // //           }
// // // //         }

// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Team created, requests sent')),
// // // //         );
// // // //         Navigator.pop(context);
// // // //       } catch (e) {
// // // //         print('Error creating team: $e');
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Error creating team: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text('Create New Team')),
// // // //       body: Padding(
// // // //         padding: EdgeInsets.all(16.0),
// // // //         child: Form(
// // // //           key: _formKey,
// // // //           child: Column(
// // // //             children: [
// // // //               TextFormField(
// // // //                 controller: _teamNameController,
// // // //                 decoration: InputDecoration(labelText: 'Team Name'),
// // // //                 validator: (value) => value == null || value.isEmpty ? 'Enter team name' : null,
// // // //               ),
// // // //               SizedBox(height: 16),
// // // //               Autocomplete<String>(
// // // //                 optionsBuilder: (TextEditingValue textEditingValue) {
// // // //                   _fetchEmailSuggestions(textEditingValue.text);
// // // //                   return _emailSuggestions;
// // // //                 },
// // // //                 onSelected: (String selection) {
// // // //                   _emailController.text = selection;
// // // //                 },
// // // //                 fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
// // // //                   _emailController.addListener(() {
// // // //                     _fetchEmailSuggestions(_emailController.text);
// // // //                   });
// // // //                   return TextFormField(
// // // //                     controller: _emailController,
// // // //                     focusNode: focusNode,
// // // //                     decoration: InputDecoration(labelText: 'Member Email'),
// // // //                     onFieldSubmitted: (value) => _addEmail(),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //               SizedBox(height: 8),
// // // //               ElevatedButton(
// // // //                 onPressed: _addEmail,
// // // //                 child: Text('+ Add Member'),
// // // //               ),
// // // //               SizedBox(height: 8),
// // // //               Wrap(
// // // //                 spacing: 8,
// // // //                 children: _confirmedEmails
// // // //                     .map((email) => Chip(
// // // //                           label: Text(email),
// // // //                           deleteIcon: Icon(Icons.close),
// // // //                           onDeleted: () {
// // // //                             setState(() {
// // // //                               _confirmedEmails.remove(email);
// // // //                             });
// // // //                           },
// // // //                         ))
// // // //                     .toList(),
// // // //               ),
// // // //               SizedBox(height: 16),
// // // //               TextFormField(
// // // //                 controller: _passwordController,
// // // //                 obscureText: true,
// // // //                 decoration: InputDecoration(labelText: 'Team Password'),
// // // //                 validator: (value) => value == null || value.length < 6 ? 'Min 6 chars' : null,
// // // //               ),
// // // //               TextFormField(
// // // //                 controller: _confirmPasswordController,
// // // //                 obscureText: true,
// // // //                 decoration: InputDecoration(labelText: 'Confirm Password'),
// // // //                 validator: (value) =>
// // // //                     value != _passwordController.text ? 'Passwords do not match' : null,
// // // //               ),
// // // //               SizedBox(height: 16),
// // // //               ElevatedButton(
// // // //                 onPressed: _createTeam,
// // // //                 child: Text('Create Team'),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:crypto/crypto.dart';
// // // import 'dart:convert';

// // // class CreateTeamPage extends StatefulWidget {
// // //   const CreateTeamPage({super.key});

// // //   @override
// // //   _CreateTeamPageState createState() => _CreateTeamPageState();
// // // }

// // // class _CreateTeamPageState extends State<CreateTeamPage> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   final _teamNameController = TextEditingController();
// // //   final _emailController = TextEditingController();
// // //   final _passwordController = TextEditingController();
// // //   final _confirmPasswordController = TextEditingController();
// // //   List<String> _confirmedEmails = [];
// // //   List<String> _emailSuggestions = [];

// // //   @override
// // //   void dispose() {
// // //     _teamNameController.dispose();
// // //     _emailController.dispose();
// // //     _passwordController.dispose();
// // //     _confirmPasswordController.dispose();
// // //     super.dispose();
// // //   }

// // //   String _hashPassword(String password) {
// // //     return sha256.convert(utf8.encode(password)).toString();
// // //   }

// // //   void _addEmail() async {
// // //     final email = _emailController.text.trim();
// // //     if (email.isNotEmpty) {
// // //       try {
// // //         final userSnapshot = await FirebaseFirestore.instance
// // //             .collection('users')
// // //             .where('email', isEqualTo: email)
// // //             .get();
// // //         if (userSnapshot.docs.isNotEmpty) {
// // //           setState(() {
// // //             _confirmedEmails.add(email);
// // //             _emailController.clear();
// // //           });
// // //         } else {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             SnackBar(content: Text('Email not found in registered users')),
// // //           );
// // //         }
// // //       } catch (e) {
// // //         print('Error validating email: $e');
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Error validating email: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   void _fetchEmailSuggestions(String query) async {
// // //     if (query.isEmpty) {
// // //       setState(() {
// // //         _emailSuggestions = [];
// // //       });
// // //       return;
// // //     }
// // //     try {
// // //       final snapshot = await FirebaseFirestore.instance
// // //           .collection('users')
// // //           .where('email', isGreaterThanOrEqualTo: query)
// // //           .where('email', isLessThanOrEqualTo: query + '\uf8ff')
// // //           .limit(5)
// // //           .get();
// // //       setState(() {
// // //         _emailSuggestions = snapshot.docs.map((doc) => doc['email'] as String).toList();
// // //       });
// // //     } catch (e) {
// // //       print('Error fetching email suggestions: $e');
// // //     }
// // //   }

// // //   void _createTeam() async {
// // //     if (_formKey.currentState!.validate()) {
// // //       try {
// // //         final user = FirebaseAuth.instance.currentUser;
// // //         if (user == null) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             SnackBar(content: Text('No user logged in')),
// // //           );
// // //           return;
// // //         }
// // //         final teamName = _teamNameController.text.trim();
// // //         final passwordHash = _hashPassword(_passwordController.text);

// // //         // Create team document
// // //         final teamRef = await FirebaseFirestore.instance.collection('teams').add({
// // //           'name': teamName,
// // //           'admin': user.uid,
// // //           'passwordHash': passwordHash,
// // //         });

// // //         // Initialize members subcollection for the admin
// // //         await teamRef.collection('members').doc(user.uid).set({
// // //           'userId': user.uid, // Added to satisfy security rules
// // //           'name': user.displayName ?? user.email!.split('@')[0], // Fallback to email username
// // //           'role': 'admin',
// // //           'status': 'joined',
// // //           'joined_at': FieldValue.serverTimestamp(),
// // //         });

// // //         // Send team requests to confirmed emails
// // //         for (String email in _confirmedEmails) {
// // //           if (email.isNotEmpty && email != user.email) {
// // //             final userSnapshot = await FirebaseFirestore.instance
// // //                 .collection('users')
// // //                 .where('email', isEqualTo: email)
// // //                 .get();
// // //             if (userSnapshot.docs.isNotEmpty) {
// // //               final targetUserId = userSnapshot.docs.first.id;
// // //               await FirebaseFirestore.instance.collection('team_requests').add({
// // //                 'teamId': teamRef.id,
// // //                 'userId': targetUserId,
// // //                 'teamName': teamName,
// // //                 'status': 'pending',
// // //                 'createdAt': Timestamp.now(),
// // //               });
// // //             }
// // //           }
// // //         }

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Team created, requests sent')),
// // //         );
// // //         Navigator.pop(context);
// // //       } catch (e) {
// // //         print('Error creating team: $e');
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Error creating team: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Create New Team')),
// // //       body: Padding(
// // //         padding: EdgeInsets.all(16.0),
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             children: [
// // //               TextFormField(
// // //                 controller: _teamNameController,
// // //                 decoration: InputDecoration(labelText: 'Team Name'),
// // //                 validator: (value) => value == null || value.isEmpty ? 'Enter team name' : null,
// // //               ),
// // //               SizedBox(height: 16),
// // //               Autocomplete<String>(
// // //                 optionsBuilder: (TextEditingValue textEditingValue) {
// // //                   _fetchEmailSuggestions(textEditingValue.text);
// // //                   return _emailSuggestions;
// // //                 },
// // //                 onSelected: (String selection) {
// // //                   _emailController.text = selection;
// // //                 },
// // //                 fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
// // //                   _emailController.addListener(() {
// // //                     _fetchEmailSuggestions(_emailController.text);
// // //                   });
// // //                   return TextFormField(
// // //                     controller: _emailController,
// // //                     focusNode: focusNode,
// // //                     decoration: InputDecoration(labelText: 'Member Email'),
// // //                     onFieldSubmitted: (value) => _addEmail(),
// // //                   );
// // //                 },
// // //               ),
// // //               SizedBox(height: 8),
// // //               ElevatedButton(
// // //                 onPressed: _addEmail,
// // //                 child: Text('+ Add Member'),
// // //               ),
// // //               SizedBox(height: 8),
// // //               Wrap(
// // //                 spacing: 8,
// // //                 children: _confirmedEmails
// // //                     .map((email) => Chip(
// // //                           label: Text(email),
// // //                           deleteIcon: Icon(Icons.close),
// // //                           onDeleted: () {
// // //                             setState(() {
// // //                               _confirmedEmails.remove(email);
// // //                             });
// // //                           },
// // //                         ))
// // //                     .toList(),
// // //               ),
// // //               SizedBox(height: 16),
// // //               TextFormField(
// // //                 controller: _passwordController,
// // //                 obscureText: true,
// // //                 decoration: InputDecoration(labelText: 'Team Password'),
// // //                 validator: (value) => value == null || value.length < 6 ? 'Min 6 chars' : null,
// // //               ),
// // //               TextFormField(
// // //                 controller: _confirmPasswordController,
// // //                 obscureText: true,
// // //                 decoration: InputDecoration(labelText: 'Confirm Password'),
// // //                 validator: (value) =>
// // //                     value != _passwordController.text ? 'Passwords do not match' : null,
// // //               ),
// // //               SizedBox(height: 16),
// // //               ElevatedButton(
// // //                 onPressed: _createTeam,
// // //                 child: Text('Create Team'),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:crypto/crypto.dart';
// // import 'dart:convert';

// // class CreateTeamPage extends StatefulWidget {
// //   const CreateTeamPage({super.key});

// //   @override
// //   _CreateTeamPageState createState() => _CreateTeamPageState();
// // }

// // class _CreateTeamPageState extends State<CreateTeamPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _teamNameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _confirmPasswordController = TextEditingController();
// //   List<String> _confirmedEmails = [];
// //   List<String> _emailSuggestions = [];

// //   @override
// //   void dispose() {
// //     _teamNameController.dispose();
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     _confirmPasswordController.dispose();
// //     super.dispose();
// //   }

// //   String _hashPassword(String password) {
// //     return sha256.convert(utf8.encode(password)).toString();
// //   }

// //   void _addEmail() async {
// //     final email = _emailController.text.trim();
// //     if (email.isNotEmpty) {
// //       try {
// //         final userSnapshot = await FirebaseFirestore.instance
// //             .collection('users')
// //             .where('email', isEqualTo: email)
// //             .get();
// //         if (userSnapshot.docs.isNotEmpty) {
// //           setState(() {
// //             _confirmedEmails.add(email);
// //             _emailController.clear();
// //           });
// //         } else {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Email not found in registered users')),
// //           );
// //         }
// //       } catch (e) {
// //         print('Error validating email: $e');
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text('Error validating email: $e')));
// //       }
// //     }
// //   }

// //   void _fetchEmailSuggestions(String query) async {
// //     if (query.isEmpty) {
// //       setState(() {
// //         _emailSuggestions = [];
// //       });
// //       return;
// //     }
// //     try {
// //       final snapshot = await FirebaseFirestore.instance
// //           .collection('users')
// //           .where('email', isGreaterThanOrEqualTo: query)
// //           .where('email', isLessThanOrEqualTo: query + '\uf8ff')
// //           .limit(5)
// //           .get();
// //       setState(() {
// //         _emailSuggestions = snapshot.docs
// //             .map((doc) => doc['email'] as String)
// //             .toList();
// //       });
// //     } catch (e) {
// //       print('Error fetching email suggestions: $e');
// //     }
// //   }

// //   void _createTeam() async {
// //     if (_formKey.currentState!.validate()) {
// //       try {
// //         final user = FirebaseAuth.instance.currentUser;
// //         if (user == null) {
// //           ScaffoldMessenger.of(
// //             context,
// //           ).showSnackBar(SnackBar(content: Text('No user logged in')));
// //           return;
// //         }
// //         final teamName = _teamNameController.text.trim();
// //         final passwordHash = _hashPassword(_passwordController.text);

// //         // Create team document
// //         final teamRef = await FirebaseFirestore.instance
// //             .collection('teams')
// //             .add({
// //               'name': teamName,
// //               'admin': user.uid,
// //               'passwordHash': passwordHash,
// //               'isSelf': false, // Default to false for separate teams
// //             });
// //         // Now that the team is created, you can access the teamId
// //         final teamId = teamRef.id;

// //         // Add teamId to the team document
// //         await teamRef.update({
// //           'teamId': teamId,
// //         }); // Update the document with teamId

// //         // Initialize members subcollection for the admin
// //         await teamRef.collection('members').doc(user.uid).set({
// //           'userId': user.uid,
// //           'name': user.displayName ?? user.email!.split('@')[0],
// //           'role': 'admin',
// //           'status': 'joined',
// //           'joined_at': FieldValue.serverTimestamp(),
// //         });

// //         // Initialize self_items subcollection with default item
// //         await teamRef.collection('self_items').add({
// //           'add_time': FieldValue.serverTimestamp(),
// //           'assigned_by': user.email,
// //           'bought_by': user.email,
// //           'edit_time': null,
// //           'is_done': false,
// //           'is_edited': false,
// //           'item_name': 'Default Item',
// //           'price': 'Rs. 0',
// //           'quantity': '1',
// //         });

// //         // Send team requests to confirmed emails
// //         for (String email in _confirmedEmails) {
// //           if (email.isNotEmpty && email != user.email) {
// //             final userSnapshot = await FirebaseFirestore.instance
// //                 .collection('users')
// //                 .where('email', isEqualTo: email)
// //                 .get();
// //             if (userSnapshot.docs.isNotEmpty) {
// //               final targetUserId = userSnapshot.docs.first.id;
// //               await FirebaseFirestore.instance.collection('team_requests').add({
// //                 'teamId': teamRef.id,
// //                 'userId': targetUserId,
// //                 'teamName': teamName,
// //                 'status': 'pending',
// //                 'createdAt': Timestamp.now(),
// //               });
// //             }
// //           }
// //         }

// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text('Team created, requests sent')));
// //         Navigator.pop(context);
// //       } catch (e) {
// //         print('Error creating team: $e');
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text('Error creating team: $e')));
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Create New Team')),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 controller: _teamNameController,
// //                 decoration: InputDecoration(labelText: 'Team Name'),
// //                 validator: (value) =>
// //                     value == null || value.isEmpty ? 'Enter team name' : null,
// //               ),
// //               SizedBox(height: 16),
// //               Autocomplete<String>(
// //                 optionsBuilder: (TextEditingValue textEditingValue) {
// //                   _fetchEmailSuggestions(textEditingValue.text);
// //                   return _emailSuggestions;
// //                 },
// //                 onSelected: (String selection) {
// //                   _emailController.text = selection;
// //                 },
// //                 fieldViewBuilder:
// //                     (context, controller, focusNode, onFieldSubmitted) {
// //                       _emailController.addListener(() {
// //                         _fetchEmailSuggestions(_emailController.text);
// //                       });
// //                       return TextFormField(
// //                         controller: _emailController,
// //                         focusNode: focusNode,
// //                         decoration: InputDecoration(labelText: 'Member Email'),
// //                         onFieldSubmitted: (value) => _addEmail(),
// //                       );
// //                     },
// //               ),
// //               SizedBox(height: 8),
// //               ElevatedButton(onPressed: _addEmail, child: Text('+ Add Member')),
// //               SizedBox(height: 8),
// //               Wrap(
// //                 spacing: 8,
// //                 children: _confirmedEmails
// //                     .map(
// //                       (email) => Chip(
// //                         label: Text(email),
// //                         deleteIcon: Icon(Icons.close),
// //                         onDeleted: () {
// //                           setState(() {
// //                             _confirmedEmails.remove(email);
// //                           });
// //                         },
// //                       ),
// //                     )
// //                     .toList(),
// //               ),
// //               SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _passwordController,
// //                 obscureText: true,
// //                 decoration: InputDecoration(labelText: 'Team Password'),
// //                 validator: (value) =>
// //                     value == null || value.length < 6 ? 'Min 6 chars' : null,
// //               ),
// //               TextFormField(
// //                 controller: _confirmPasswordController,
// //                 obscureText: true,
// //                 decoration: InputDecoration(labelText: 'Confirm Password'),
// //                 validator: (value) => value != _passwordController.text
// //                     ? 'Passwords do not match'
// //                     : null,
// //               ),
// //               SizedBox(height: 16),
// //               ElevatedButton(
// //                 onPressed: _createTeam,
// //                 child: Text('Create Team'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';

// class CreateTeamPage extends StatefulWidget {
//   const CreateTeamPage({super.key});

//   @override
//   _CreateTeamPageState createState() => _CreateTeamPageState();
// }

// class _CreateTeamPageState extends State<CreateTeamPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _teamNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   List<String> _confirmedEmails = [];
//   List<String> _emailSuggestions = [];

//   @override
//   void dispose() {
//     _teamNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   String _hashPassword(String password) {
//     return sha256.convert(utf8.encode(password)).toString();
//   }

//   void _addEmail() async {
//     final email = _emailController.text.trim();
//     if (email.isNotEmpty) {
//       try {
//         final userSnapshot = await FirebaseFirestore.instance
//             .collection('users')
//             .where('email', isEqualTo: email)
//             .get();
//         if (userSnapshot.docs.isNotEmpty) {
//           setState(() {
//             _confirmedEmails.add(email);
//             _emailController.clear();
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Email not found in registered users')),
//           );
//         }
//       } catch (e) {
//         print('Error validating email: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error validating email: $e')),
//         );
//       }
//     }
//   }

//   void _fetchEmailSuggestions(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _emailSuggestions = [];
//       });
//       return;
//     }
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('email', isGreaterThanOrEqualTo: query)
//           .where('email', isLessThanOrEqualTo: query + '\uf8ff')
//           .limit(5)
//           .get();
//       setState(() {
//         _emailSuggestions = snapshot.docs.map((doc) => doc['email'] as String).toList();
//       });
//     } catch (e) {
//       print('Error fetching email suggestions: $e');
//     }
//   }

//   void _createTeam() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         final user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('No user logged in')),
//           );
//           return;
//         }
//         final teamName = _teamNameController.text.trim();
//         final passwordHash = _hashPassword(_passwordController.text);

//         // Create team document
//         final teamRef = await FirebaseFirestore.instance.collection('teams').add({
//           'name': teamName,
//           'admin': user.uid,
//           'passwordHash': passwordHash,
//           'isSelf': false,
//         });

//         // Add teamId to the team document
//         final teamId = teamRef.id;
//         await teamRef.update({
//           'teamId': teamId,
//         });

//         // Initialize members subcollection for the admin
//         await teamRef.collection('members').doc(user.uid).set({
//           'userId': user.uid,
//           'name': user.displayName ?? user.email!.split('@')[0],
//           'role': 'admin',
//           'status': 'joined',
//           'joined_at': FieldValue.serverTimestamp(),
//         });

//         // Initialize self_items subcollection with default item
//         await teamRef.collection('self_items').add({
//           'add_time': FieldValue.serverTimestamp(),
//           'assigned_by': user.email,
//           'bought_by': user.email,
//           'edit_time': null,
//           'is_done': false,
//           'is_edited': false,
//           'item_name': 'Default Item',
//           'price': 'Rs. 0',
//           'quantity': '1',
//         });

//         // Send team requests to confirmed emails
//         for (String email in _confirmedEmails) {
//           if (email.isNotEmpty && email != user.email) {
//             final userSnapshot = await FirebaseFirestore.instance
//                 .collection('users')
//                 .where('email', isEqualTo: email)
//                 .get();
//             if (userSnapshot.docs.isNotEmpty) {
//               final targetUserId = userSnapshot.docs.first.id;
//               await FirebaseFirestore.instance.collection('team_requests').add({
//                 'teamId': teamId,
//                 'userId': targetUserId,
//                 'teamName': teamName,
//                 'status': 'pending',
//                 'createdAt': Timestamp.now(),
//               });
//             }
//           }
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Team created, requests sent')),
//         );
//         Navigator.pop(context);
//       } catch (e) {
//         print('Error creating team: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error creating team: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create New Team')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _teamNameController,
//                 decoration: InputDecoration(labelText: 'Team Name'),
//                 validator: (value) => value == null || value.isEmpty ? 'Enter team name' : null,
//               ),
//               SizedBox(height: 16),
//               Autocomplete<String>(
//                 optionsBuilder: (TextEditingValue textEditingValue) {
//                   _fetchEmailSuggestions(textEditingValue.text);
//                   return _emailSuggestions;
//                 },
//                 onSelected: (String selection) {
//                   _emailController.text = selection;
//                 },
//                 fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
//                   _emailController.addListener(() {
//                     _fetchEmailSuggestions(_emailController.text);
//                   });
//                   return TextFormField(
//                     controller: _emailController,
//                     focusNode: focusNode,
//                     decoration: InputDecoration(labelText: 'Member Email'),
//                     onFieldSubmitted: (value) => _addEmail(),
//                   );
//                 },
//               ),
//               SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: _addEmail,
//                 child: Text('+ Add Member'),
//               ),
//               SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 children: _confirmedEmails
//                     .map((email) => Chip(
//                           label: Text(email),
//                           deleteIcon: Icon(Icons.close),
//                           onDeleted: () {
//                             setState(() {
//                               _confirmedEmails.remove(email);
//                             });
//                           },
//                         ))
//                     .toList(),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Team Password'),
//                 validator: (value) => value == null || value.length < 6 ? 'Min 6 chars' : null,
//               ),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Confirm Password'),
//                 validator: (value) =>
//                     value != _passwordController.text ? 'Passwords do not match' : null,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _createTeam,
//                 child: Text('Create Team'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key});

  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  List<String> _confirmedEmails = [];
  List<String> _emailSuggestions = [];

  @override
  void dispose() {
    _teamNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  void _addEmail() async {
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();
        if (userSnapshot.docs.isNotEmpty) {
          setState(() {
            _confirmedEmails.add(email);
            _emailController.clear();
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
          .where('email', isLessThanOrEqualTo: query + '\uf8ff')
          .limit(5)
          .get();
      setState(() {
        _emailSuggestions = snapshot.docs.map((doc) => doc['email'] as String).toList();
      });
    } catch (e) {
      print('Error fetching email suggestions: $e');
    }
  }

  void _createTeam() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user logged in')),
          );
          return;
        }
        final teamName = _teamNameController.text.trim();
        final passwordHash = _hashPassword(_passwordController.text);

        // Create team document
        final teamRef = await FirebaseFirestore.instance.collection('teams').add({
          'name': teamName,
          'admin': user.uid,
          'passwordHash': passwordHash,
          'isSelf': false,
        });

        // Add teamId to the team document
        final teamId = teamRef.id;
        await teamRef.update({
          'teamId': teamId,
        });

        // Initialize members subcollection for the admin
        await teamRef.collection('members').doc(user.uid).set({
          'userId': user.uid,
          'name': user.displayName ?? user.email!.split('@')[0],
          'role': 'admin',
          'status': 'joined',
          'joined_at': FieldValue.serverTimestamp(),
        });

        // Initialize self_items subcollection with default item
        await teamRef.collection('self_items').add({
          'add_time': FieldValue.serverTimestamp(),
          'assigned_by': user.email,
          'bought_by': user.email,
          'edit_time': null,
          'is_done': false,
          'is_edited': false,
          'item_name': 'Default Item',
          'price': 'Rs. 0',
          'quantity': '1',
        });

        // Add team to admin's current_teams
        final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userRef.collection('current_teams').doc(teamId).set({
          'teamId': teamId,
          'name': teamName,
          'joined_at': FieldValue.serverTimestamp(),
        });

        // Send team requests to confirmed emails
        for (String email in _confirmedEmails) {
          if (email.isNotEmpty && email != user.email) {
            final userSnapshot = await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: email)
                .get();
            if (userSnapshot.docs.isNotEmpty) {
              final targetUserId = userSnapshot.docs.first.id;
              await FirebaseFirestore.instance.collection('team_requests').add({
                'teamId': teamId,
                'userId': targetUserId,
                'teamName': teamName,
                'status': 'pending',
                'createdAt': Timestamp.now(),
              });
            }
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Team created, requests sent')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error creating team: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating team: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Team')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _teamNameController,
                decoration: InputDecoration(labelText: 'Team Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter team name' : null,
              ),
              SizedBox(height: 16),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  _fetchEmailSuggestions(textEditingValue.text);
                  return _emailSuggestions;
                },
                onSelected: (String selection) {
                  _emailController.text = selection;
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  _emailController.addListener(() {
                    _fetchEmailSuggestions(_emailController.text);
                  });
                  return TextFormField(
                    controller: _emailController,
                    focusNode: focusNode,
                    decoration: InputDecoration(labelText: 'Member Email'),
                    onFieldSubmitted: (value) => _addEmail(),
                  );
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _addEmail,
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
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Team Password'),
                validator: (value) => value == null || value.length < 6 ? 'Min 6 chars' : null,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                validator: (value) =>
                    value != _passwordController.text ? 'Passwords do not match' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _createTeam,
                child: Text('Create Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}