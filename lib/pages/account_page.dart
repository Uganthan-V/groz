
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import '../widgets/greet.dart';
// // // // // // import './team/create_team.dart';
// // // // // // import './team/manage_team.dart';
// // // // // // import '../widgets/gathering.dart';

// // // // // // class AccountPage extends StatefulWidget {
// // // // // //   const AccountPage({super.key});

// // // // // //   @override
// // // // // //   _AccountPageState createState() => _AccountPageState();
// // // // // // }

// // // // // // class _AccountPageState extends State<AccountPage> {
// // // // // //   void _showLeaveTeamDialog(String teamId) {
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder: (context) {
// // // // // //         return AlertDialog(
// // // // // //           title: Text('Leave Gathering'),
// // // // // //           content: Text('Are you sure you want to leave this gathering?'),
// // // // // //           actions: [
// // // // // //             TextButton(
// // // // // //               onPressed: () => Navigator.pop(context),
// // // // // //               child: Text('Cancel'),
// // // // // //             ),
// // // // // //             TextButton(
// // // // // //               onPressed: () async {
// // // // // //                 try {
// // // // // //                   final user = FirebaseAuth.instance.currentUser;
// // // // // //                   if (user != null) {
// // // // // //                     await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
// // // // // //                       'members': FieldValue.arrayRemove([user.uid]),
// // // // // //                     });
// // // // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                       SnackBar(content: Text('Left gathering')),
// // // // // //                     );
// // // // // //                     Navigator.pop(context);
// // // // // //                   }
// // // // // //                 } catch (e) {
// // // // // //                   print('Error leaving gathering: $e');
// // // // // //                   ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                     SnackBar(content: Text('Error leaving gathering: $e')),
// // // // // //                   );
// // // // // //                 }
// // // // // //               },
// // // // // //               child: Text('Leave'),
// // // // // //             ),
// // // // // //           ],
// // // // // //         );
// // // // // //       },
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // // //     return Scaffold(
// // // // // //       body: Container(
// // // // // //         decoration: BoxDecoration(
// // // // // //           gradient: LinearGradient(
// // // // // //             begin: Alignment.topLeft,
// // // // // //             end: Alignment.bottomRight,
// // // // // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // // // //           ),
// // // // // //         ),
// // // // // //         child:
// // // // // //        Column(
// // // // // //         children: [
// // // // // //           GreetWidget(),
// // // // // //           GestureDetector(
// // // // // //             onTap: () {
// // // // // //               Navigator.push(
// // // // // //                 context,
// // // // // //                 MaterialPageRoute(builder: (_) => CreateTeamPage()),
// // // // // //               );
// // // // // //             },
// // // // // //             child: Container(
// // // // // //               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // // // // //               padding: EdgeInsets.all(16),
// // // // // //               decoration: BoxDecoration(
// // // // // //                 color: Colors.blue[100],
// // // // // //                 borderRadius: BorderRadius.circular(10),
// // // // // //                 boxShadow: [
// // // // // //                   BoxShadow(
// // // // // //                     color: Colors.grey.withOpacity(0.3),
// // // // // //                     spreadRadius: 2,
// // // // // //                     blurRadius: 5,
// // // // // //                     offset: Offset(0, 3),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               child: Row(
// // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                 children: [
// // // // // //                   Icon(Icons.add, color: Colors.blue[600]),
// // // // // //                   SizedBox(width: 10),
// // // // // //                   Text(
// // // // // //                     'Create Gathering',
// // // // // //                     style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           Expanded(
// // // // // //             child: StreamBuilder<QuerySnapshot>(
// // // // // //               stream: FirebaseFirestore.instance
// // // // // //                   .collection('teams')
// // // // // //                   .where('members', arrayContains: user?.uid ?? '')
// // // // // //                   .snapshots(),
// // // // // //               builder: (context, snapshot) {
// // // // // //                 if (snapshot.hasError) {
// // // // // //                   print('Error loading gatherings: ${snapshot.error}');
// // // // // //                   return Center(child: Text('Error: ${snapshot.error}'));
// // // // // //                 }
// // // // // //                 if (!snapshot.hasData) {
// // // // // //                   return Center(child: CircularProgressIndicator());
// // // // // //                 }
// // // // // //                 final teams = snapshot.data!.docs;
// // // // // //                 if (teams.isEmpty) {
// // // // // //                   return SizedBox.shrink(); // Display nothing if no gatherings
// // // // // //                 }
// // // // // //                 return ListView.builder(
// // // // // //                   itemCount: teams.length,
// // // // // //                   itemBuilder: (context, index) {
// // // // // //                     final teamData = teams[index].data() as Map<String, dynamic>;
// // // // // //                     final teamId = teams[index].id;
// // // // // //                     final teamName = teamData['name'] ?? 'Unnamed Gathering';
// // // // // //                     final isAdmin = teamData['admin'] == user?.uid;
// // // // // //                     return GatheringWidget(
// // // // // //                       teamId: teamId,
// // // // // //                       teamName: teamName,
// // // // // //                       isAdmin: isAdmin,
// // // // // //                       onTap: () {
// // // // // //                         if (isAdmin) {
// // // // // //                           Navigator.push(
// // // // // //                             context,
// // // // // //                             MaterialPageRoute(
// // // // // //                               builder: (_) => ManageTeamPage(
// // // // // //                                 teamId: teamId,
// // // // // //                                 teamName: teamName,
// // // // // //                                 isAdmin: isAdmin,
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                           );
// // // // // //                         } else {
// // // // // //                           _showLeaveTeamDialog(teamId);
// // // // // //                         }
// // // // // //                       },
// // // // // //                     );
// // // // // //                   },
// // // // // //                 );
// // // // // //               },
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //       )
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import '../widgets/greet.dart';
// // // // // import './team/create_team.dart';
// // // // // import './team/manage_team.dart';
// // // // // import '../widgets/gathering.dart';

// // // // // class AccountPage extends StatefulWidget {
// // // // //   const AccountPage({super.key});

// // // // //   @override
// // // // //   _AccountPageState createState() => _AccountPageState();
// // // // // }

// // // // // class _AccountPageState extends State<AccountPage> {
// // // // //   List<String> _teamIds = [];

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchTeamIds();
// // // // //   }

// // // // //   Future<void> _fetchTeamIds() async {
// // // // //     final user = FirebaseAuth.instance.currentUser;
// // // // //     if (user == null) return;

// // // // //     try {
// // // // //       final snapshot = await FirebaseFirestore.instance
// // // // //           .collectionGroup('members')
// // // // //           .where('userId', isEqualTo: user.uid)
// // // // //           .where('status', isEqualTo: 'joined')
// // // // //           .get();
// // // // //       final ids = snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toList();
// // // // //       setState(() {
// // // // //         _teamIds = ids;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       print('Error fetching team IDs: $e');
// // // // //     }
// // // // //   }

// // // // //   void _showLeaveTeamDialog(String teamId) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) {
// // // // //         return AlertDialog(
// // // // //           title: Text('Leave Gathering'),
// // // // //           content: Text('Are you sure you want to leave this gathering?'),
// // // // //           actions: [
// // // // //             TextButton(
// // // // //               onPressed: () => Navigator.pop(context),
// // // // //               child: Text('Cancel'),
// // // // //             ),
// // // // //             TextButton(
// // // // //               onPressed: () async {
// // // // //                 try {
// // // // //                   final user = FirebaseAuth.instance.currentUser;
// // // // //                   if (user != null) {
// // // // //                     final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
// // // // //                     final memberRef = teamRef.collection('members').doc(user.uid);
// // // // //                     await FirebaseFirestore.instance.runTransaction((transaction) async {
// // // // //                       final teamDoc = await transaction.get(teamRef);
// // // // //                       if (teamDoc.exists) {
// // // // //                         transaction.delete(memberRef);
// // // // //                       }
// // // // //                     });
// // // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // // //                       SnackBar(content: Text('Left gathering')),
// // // // //                     );
// // // // //                     // Refresh team IDs after leaving
// // // // //                     await _fetchTeamIds();
// // // // //                     Navigator.pop(context);
// // // // //                   }
// // // // //                 } catch (e) {
// // // // //                   print('Error leaving gathering: $e');
// // // // //                   ScaffoldMessenger.of(context).showSnackBar(
// // // // //                     SnackBar(content: Text('Error leaving gathering: $e')),
// // // // //                   );
// // // // //                 }
// // // // //               },
// // // // //               child: Text('Leave'),
// // // // //             ),
// // // // //           ],
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // //     return Scaffold(
// // // // //       body: Container(
// // // // //         decoration: BoxDecoration(
// // // // //           gradient: LinearGradient(
// // // // //             begin: Alignment.topLeft,
// // // // //             end: Alignment.bottomRight,
// // // // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // // //           ),
// // // // //         ),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             GreetWidget(),
// // // // //             GestureDetector(
// // // // //               onTap: () {
// // // // //                 Navigator.push(
// // // // //                   context,
// // // // //                   MaterialPageRoute(builder: (_) => CreateTeamPage()),
// // // // //                 );
// // // // //               },
// // // // //               child: Container(
// // // // //                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // // // //                 padding: EdgeInsets.all(16),
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: Colors.blue[100],
// // // // //                   borderRadius: BorderRadius.circular(10),
// // // // //                   boxShadow: [
// // // // //                     BoxShadow(
// // // // //                       color: Colors.grey.withOpacity(0.3),
// // // // //                       spreadRadius: 2,
// // // // //                       blurRadius: 5,
// // // // //                       offset: Offset(0, 3),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //                 child: Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     Icon(Icons.add, color: Colors.blue[600]),
// // // // //                     SizedBox(width: 10),
// // // // //                     Text(
// // // // //                       'Create Gathering',
// // // // //                       style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             Expanded(
// // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // //                 stream: _teamIds.isNotEmpty
// // // // //                     ? FirebaseFirestore.instance
// // // // //                         .collection('teams')
// // // // //                         .where(FieldPath.documentId, whereIn: _teamIds)
// // // // //                         .snapshots()
// // // // //                     : const Stream.empty(),
// // // // //                 builder: (context, snapshot) {
// // // // //                   if (snapshot.hasError) {
// // // // //                     print('Error loading gatherings: ${snapshot.error}');
// // // // //                     return Center(child: Text('Error: ${snapshot.error}'));
// // // // //                   }
// // // // //                   if (!snapshot.hasData) {
// // // // //                     return Center(child: CircularProgressIndicator());
// // // // //                   }
// // // // //                   final teams = snapshot.data!.docs;
// // // // //                   if (teams.isEmpty) {
// // // // //                     return Center(child: Text('No gatherings found')); // Updated to show message
// // // // //                   }
// // // // //                   return ListView.builder(
// // // // //                     itemCount: teams.length,
// // // // //                     itemBuilder: (context, index) {
// // // // //                       final teamData = teams[index].data() as Map<String, dynamic>;
// // // // //                       final teamId = teams[index].id;
// // // // //                       final teamName = teamData['name'] ?? 'Unnamed Gathering';
// // // // //                       final isAdmin = teamData['admin'] == user?.uid;
// // // // //                       return GatheringWidget(
// // // // //                         teamId: teamId,
// // // // //                         teamName: teamName,
// // // // //                         isAdmin: isAdmin,
// // // // //                         onTap: () {
// // // // //                           if (isAdmin) {
// // // // //                             Navigator.push(
// // // // //                               context,
// // // // //                               MaterialPageRoute(
// // // // //                                 builder: (_) => ManageTeamPage(
// // // // //                                   teamId: teamId,
// // // // //                                   teamName: teamName,
// // // // //                                   isAdmin: isAdmin,
// // // // //                                 ),
// // // // //                               ),
// // // // //                             );
// // // // //                           } else {
// // // // //                             _showLeaveTeamDialog(teamId);
// // // // //                           }
// // // // //                         },
// // // // //                       );
// // // // //                     },
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../widgets/greet.dart';
// // // // import './team/create_team.dart';
// // // // import './team/manage_team.dart';
// // // // import '../widgets/gathering.dart';

// // // // class AccountPage extends StatefulWidget {
// // // //   const AccountPage({super.key});

// // // //   @override
// // // //   _AccountPageState createState() => _AccountPageState();
// // // // }

// // // // class _AccountPageState extends State<AccountPage> {
// // // //   List<String> _teamIds = [];

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _fetchTeamIds();
// // // //   }

// // // //   Future<void> _fetchTeamIds() async {
// // // //     final user = FirebaseAuth.instance.currentUser;
// // // //     if (user == null) return;

// // // //     try {
// // // //       final snapshot = await FirebaseFirestore.instance
// // // //           .collectionGroup('members')
// // // //           .where('userId', isEqualTo: user.uid)
// // // //           .where('status', isEqualTo: 'joined')
// // // //           .get();
// // // //       final ids = snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toList();
// // // //       setState(() {
// // // //         _teamIds = ids;
// // // //       });
// // // //     } catch (e) {
// // // //       print('Error fetching team IDs: $e');
// // // //     }
// // // //   }

// // // //   void _showLeaveTeamDialog(String teamId) {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) {
// // // //         return AlertDialog(
// // // //           title: Text('Leave Gathering'),
// // // //           content: Text('Are you sure you want to leave this gathering?'),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () => Navigator.pop(context),
// // // //               child: Text('Cancel'),
// // // //             ),
// // // //             TextButton(
// // // //               onPressed: () async {
// // // //                 try {
// // // //                   final user = FirebaseAuth.instance.currentUser;
// // // //                   if (user != null) {
// // // //                     final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
// // // //                     final memberRef = teamRef.collection('members').doc(user.uid);
// // // //                     await FirebaseFirestore.instance.runTransaction((transaction) async {
// // // //                       final teamDoc = await transaction.get(teamRef);
// // // //                       if (teamDoc.exists) {
// // // //                         transaction.delete(memberRef);
// // // //                       }
// // // //                     });
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       SnackBar(content: Text('Left gathering')),
// // // //                     );
// // // //                     // Refresh team IDs after leaving
// // // //                     await _fetchTeamIds();
// // // //                     Navigator.pop(context);
// // // //                   }
// // // //                 } catch (e) {
// // // //                   print('Error leaving gathering: $e');
// // // //                   ScaffoldMessenger.of(context).showSnackBar(
// // // //                     SnackBar(content: Text('Error leaving gathering: $e')),
// // // //                   );
// // // //                 }
// // // //               },
// // // //               child: Text('Leave'),
// // // //             ),
// // // //           ],
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final user = FirebaseAuth.instance.currentUser;

// // // //     return Scaffold(
// // // //       body: Container(
// // // //         decoration: BoxDecoration(
// // // //           gradient: LinearGradient(
// // // //             begin: Alignment.topLeft,
// // // //             end: Alignment.bottomRight,
// // // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // //           ),
// // // //         ),
// // // //         child: Column(
// // // //           children: [
// // // //             GreetWidget(),
// // // //             GestureDetector(
// // // //               onTap: () {
// // // //                 Navigator.push(
// // // //                   context,
// // // //                   MaterialPageRoute(builder: (_) => CreateTeamPage()),
// // // //                 );
// // // //               },
// // // //               child: Container(
// // // //                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // // //                 padding: EdgeInsets.all(16),
// // // //                 decoration: BoxDecoration(
// // // //                   color: Colors.blue[100],
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                   boxShadow: [
// // // //                     BoxShadow(
// // // //                       color: Colors.grey.withOpacity(0.3),
// // // //                       spreadRadius: 2,
// // // //                       blurRadius: 5,
// // // //                       offset: Offset(0, 3),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //                 child: Row(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     Icon(Icons.add, color: Colors.blue[600]),
// // // //                     SizedBox(width: 10),
// // // //                     Text(
// // // //                       'Create Gathering',
// // // //                       style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             Expanded(
// // // //               child: StreamBuilder<QuerySnapshot>(
// // // //                 stream: _teamIds.isNotEmpty
// // // //                     ? FirebaseFirestore.instance
// // // //                         .collection('teams')
// // // //                         .where(FieldPath.documentId, whereIn: _teamIds)
// // // //                         .snapshots()
// // // //                     : null, // Use null to handle empty case outside StreamBuilder
// // // //                 builder: (context, snapshot) {
// // // //                   if (snapshot.hasError) {
// // // //                     print('Error loading gatherings: ${snapshot.error}');
// // // //                     return Center(child: Text('Error: ${snapshot.error}'));
// // // //                   }
// // // //                   // Only show loading if stream is active and data is not yet available
// // // //                   if (snapshot.connectionState == ConnectionState.waiting && _teamIds.isNotEmpty) {
// // // //                     return Center(child: CircularProgressIndicator());
// // // //                   }
// // // //                   final teams = snapshot.data?.docs ?? [];
// // // //                   if (teams.isEmpty && _teamIds.isEmpty) {
// // // //                     return Center(child: Text('No gatherings yet'));
// // // //                   }
// // // //                   if (teams.isEmpty) {
// // // //                     return Center(child: Text('No gatherings found'));
// // // //                   }
// // // //                   return ListView.builder(
// // // //                     itemCount: teams.length,
// // // //                     itemBuilder: (context, index) {
// // // //                       final teamData = teams[index].data() as Map<String, dynamic>;
// // // //                       final teamId = teams[index].id;
// // // //                       final teamName = teamData['name'] ?? 'Unnamed Gathering';
// // // //                       final isAdmin = teamData['admin'] == user?.uid;
// // // //                       return GatheringWidget(
// // // //                         teamId: teamId,
// // // //                         teamName: teamName,
// // // //                         isAdmin: isAdmin,
// // // //                         onTap: () {
// // // //                           if (isAdmin) {
// // // //                             Navigator.push(
// // // //                               context,
// // // //                               MaterialPageRoute(
// // // //                                 builder: (_) => ManageTeamPage(
// // // //                                   teamId: teamId,
// // // //                                   teamName: teamName,
// // // //                                   isAdmin: isAdmin,
// // // //                                 ),
// // // //                               ),
// // // //                             );
// // // //                           } else {
// // // //                             _showLeaveTeamDialog(teamId);
// // // //                           }
// // // //                         },
// // // //                       );
// // // //                     },
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }


// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../widgets/greet.dart';
// // // import './team/create_team.dart';
// // // import './team/manage_team.dart';
// // // import '../widgets/gathering.dart';

// // // class AccountPage extends StatefulWidget {
// // //   const AccountPage({super.key});

// // //   @override
// // //   _AccountPageState createState() => _AccountPageState();
// // // }

// // // class _AccountPageState extends State<AccountPage> {
// // //   List<String> _teamIds = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchTeamIds();
// // //   }

// // //   Future<void> _fetchTeamIds() async {
// // //     final user = FirebaseAuth.instance.currentUser;
// // //     if (user == null) return;

// // //     try {
// // //       final snapshot = await FirebaseFirestore.instance
// // //           .collectionGroup('members')
// // //           .where('userId', isEqualTo: user.uid)
// // //           .where('status', isEqualTo: 'joined')
// // //           .get();
// // //       final ids = snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toList();
// // //       setState(() {
// // //         _teamIds = ids;
// // //       });
// // //     } catch (e) {
// // //       print('Error fetching team IDs: $e');
// // //     }
// // //   }

// // //   void _showLeaveTeamDialog(String teamId) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return AlertDialog(
// // //           title: Text('Leave Gathering'),
// // //           content: Text('Are you sure you want to leave this gathering?'),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context),
// // //               child: Text('Cancel'),
// // //             ),
// // //             TextButton(
// // //               onPressed: () async {
// // //                 try {
// // //                   final user = FirebaseAuth.instance.currentUser;
// // //                   if (user != null) {
// // //                     final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
// // //                     final teamSnap = await teamRef.get();
// // //                     if (teamSnap.exists && !teamSnap.data()!['isSelf']) { // Only allow leaving non-"Self" gatherings
// // //                       final memberRef = teamRef.collection('members').doc(user.uid);
// // //                       await FirebaseFirestore.instance.runTransaction((transaction) async {
// // //                         final teamDoc = await transaction.get(teamRef);
// // //                         if (teamDoc.exists) {
// // //                           transaction.delete(memberRef);
// // //                         }
// // //                       });
// // //                       ScaffoldMessenger.of(context).showSnackBar(
// // //                         SnackBar(content: Text('Left gathering')),
// // //                       );
// // //                       await _fetchTeamIds();
// // //                     } else {
// // //                       ScaffoldMessenger.of(context).showSnackBar(
// // //                         SnackBar(content: Text('Cannot leave "Self" gathering')),
// // //                       );
// // //                     }
// // //                     Navigator.pop(context);
// // //                   }
// // //                 } catch (e) {
// // //                   print('Error leaving gathering: $e');
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(content: Text('Error leaving gathering: $e')),
// // //                   );
// // //                 }
// // //               },
// // //               child: Text('Leave'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final user = FirebaseAuth.instance.currentUser;

// // //     return Scaffold(
// // //       body: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: LinearGradient(
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // //           ),
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             GreetWidget(),
// // //             GestureDetector(
// // //               onTap: () {
// // //                 Navigator.push(
// // //                   context,
// // //                   MaterialPageRoute(builder: (_) => CreateTeamPage()),
// // //                 );
// // //               },
// // //               child: Container(
// // //                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // //                 padding: EdgeInsets.all(16),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.blue[100],
// // //                   borderRadius: BorderRadius.circular(10),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Colors.grey.withOpacity(0.3),
// // //                       spreadRadius: 2,
// // //                       blurRadius: 5,
// // //                       offset: Offset(0, 3),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     Icon(Icons.add, color: Colors.blue[600]),
// // //                     SizedBox(width: 10),
// // //                     Text(
// // //                       'Create Gathering',
// // //                       style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //             Expanded(
// // //               child: StreamBuilder<QuerySnapshot>(
// // //                 stream: _teamIds.isNotEmpty
// // //                     ? FirebaseFirestore.instance
// // //                         .collection('teams')
// // //                         .where(FieldPath.documentId, whereIn: _teamIds)
// // //                         .snapshots()
// // //                     : null,
// // //                 builder: (context, snapshot) {
// // //                   if (snapshot.hasError) {
// // //                     print('Error loading gatherings: ${snapshot.error}');
// // //                     return Center(child: Text('Error: ${snapshot.error}'));
// // //                   }
// // //                   if (snapshot.connectionState == ConnectionState.waiting && _teamIds.isNotEmpty) {
// // //                     return Center(child: CircularProgressIndicator());
// // //                   }
// // //                   final teams = snapshot.data?.docs ?? [];
// // //                   if (teams.isEmpty && _teamIds.isEmpty) {
// // //                     return Center(child: Text('No gatherings yet'));
// // //                   }
// // //                   if (teams.isEmpty) {
// // //                     return Center(child: Text('No gatherings found'));
// // //                   }
// // //                   return ListView.builder(
// // //                     itemCount: teams.length,
// // //                     itemBuilder: (context, index) {
// // //                       final teamData = teams[index].data() as Map<String, dynamic>;
// // //                       final teamId = teams[index].id;
// // //                       final teamName = teamData['name'] ?? 'Unnamed Gathering';
// // //                       final isAdmin = teamData['admin'] == user?.uid;
// // //                       final isSelf = teamData['isSelf'] ?? false;
// // //                       return GatheringWidget(
// // //                         teamId: teamId,
// // //                         teamName: teamName,
// // //                         isAdmin: isAdmin,
// // //                         isSelf: isSelf, // Pass isSelf to GatheringWidget
// // //                         onTap: () {
// // //                           if (isAdmin && !isSelf) { // Only allow manage for non-"Self" gatherings
// // //                             Navigator.push(
// // //                               context,
// // //                               MaterialPageRoute(
// // //                                 builder: (_) => ManageTeamPage(
// // //                                   teamId: teamId,
// // //                                   teamName: teamName,
// // //                                   isAdmin: isAdmin,
// // //                                 ),
// // //                               ),
// // //                             );
// // //                           } else if (!isSelf) {
// // //                             _showLeaveTeamDialog(teamId);
// // //                           }
// // //                         },
// // //                       );
// // //                     },
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../widgets/greet.dart';
// // import './team/create_team.dart';
// // import './team/manage_team.dart';
// // import '../widgets/gathering.dart';
// // import '../service/handle_teams.dart';

// // class AccountPage extends StatefulWidget {
// //   const AccountPage({super.key});

// //   @override
// //   _AccountPageState createState() => _AccountPageState();
// // }

// // class _AccountPageState extends State<AccountPage> {
// //   List<String> _teamIds = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchTeamIds();
// //   }

// //   Future<void> _fetchTeamIds() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     if (user == null) return;

// //     try {
// //       final snapshot = await FirebaseFirestore.instance
// //           .collectionGroup('members')
// //           .where('userId', isEqualTo: user.uid)
// //           .where('status', isEqualTo: 'joined')
// //           .get();
// //       final ids = snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toList();
// //       if (ids.isNotEmpty && TeamManager().currentTeamId.isEmpty) {
// //         // Set default to first team or "Self" if exists
// //         final teamRef = FirebaseFirestore.instance.collection('teams').doc(ids[0]);
// //         final teamSnap = await teamRef.get();
// //         if (teamSnap.exists) {
// //           TeamManager().setCurrentTeam(ids[0], teamSnap.data()?['name'] ?? 'Unnamed', context);
// //         }
// //       }
// //       setState(() {
// //         _teamIds = ids;
// //       });
// //     } catch (e) {
// //       print('Error fetching team IDs: $e');
// //     }
// //   }

// //   Future<void> _showLeaveTeamDialog(String teamId) async {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Leave Gathering'),
// //           content: Text('Are you sure you want to leave this gathering?'),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () async {
// //                 try {
// //                   final user = FirebaseAuth.instance.currentUser;
// //                   if (user != null) {
// //                     final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
// //                     final teamSnap = await teamRef.get();
// //                     if (teamSnap.exists && !teamSnap.data()!['isSelf']) {
// //                       final memberRef = teamRef.collection('members').doc(user.uid);
// //                       await FirebaseFirestore.instance.runTransaction((transaction) async {
// //                         final teamDoc = await transaction.get(teamRef);
// //                         if (teamDoc.exists) {
// //                           transaction.delete(memberRef);
// //                         }
// //                       });
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         SnackBar(content: Text('Left gathering')),
// //                       );
// //                       await _fetchTeamIds();
// //                     } else {
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         SnackBar(content: Text('Cannot leave "Self" gathering')),
// //                       );
// //                     }
// //                     Navigator.pop(context);
// //                   }
// //                 } catch (e) {
// //                   print('Error leaving gathering: $e');
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(content: Text('Error leaving gathering: $e')),
// //                   );
// //                 }
// //               },
// //               child: Text('Leave'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;

// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             GreetWidget(),
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (_) => CreateTeamPage()),
// //                 );
// //               },
// //               child: Container(
// //                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //                 padding: EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.blue[100],
// //                   borderRadius: BorderRadius.circular(10),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.grey.withOpacity(0.3),
// //                       spreadRadius: 2,
// //                       blurRadius: 5,
// //                       offset: Offset(0, 3),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Icon(Icons.add, color: Colors.blue[600]),
// //                     SizedBox(width: 10),
// //                     Text(
// //                       'Create Gathering',
// //                       style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             Expanded(
// //               child: StreamBuilder<QuerySnapshot>(
// //                 stream: _teamIds.isNotEmpty
// //                     ? FirebaseFirestore.instance
// //                         .collection('teams')
// //                         .where(FieldPath.documentId, whereIn: _teamIds)
// //                         .snapshots()
// //                     : null,
// //                 builder: (context, snapshot) {
// //                   if (snapshot.hasError) {
// //                     print('Error loading gatherings: ${snapshot.error}');
// //                     return Center(child: Text('Error: ${snapshot.error}'));
// //                   }
// //                   if (snapshot.connectionState == ConnectionState.waiting && _teamIds.isNotEmpty) {
// //                     return Center(child: CircularProgressIndicator());
// //                   }
// //                   final teams = snapshot.data?.docs ?? [];
// //                   if (teams.isEmpty && _teamIds.isEmpty) {
// //                     return Center(child: Text('No gatherings yet'));
// //                   }
// //                   if (teams.isEmpty) {
// //                     return Center(child: Text('No gatherings found'));
// //                   }
// //                   return ListView.builder(
// //                     itemCount: teams.length,
// //                     itemBuilder: (context, index) {
// //                       final teamData = teams[index].data() as Map<String, dynamic>;
// //                       final teamId = teams[index].id;
// //                       final teamName = teamData['name'] ?? 'Unnamed Gathering';
// //                       final isAdmin = teamData['admin'] == user?.uid;
// //                       final isSelf = teamData['isSelf'] ?? false;
// //                       return GestureDetector(
// //                         onTap: () {
// //                           TeamManager().setCurrentTeam(teamId, teamName, context);
// //                           setState(() {}); // Refresh UI
// //                         },
// //                         child: GatheringWidget(
// //                           teamId: teamId,
// //                           teamName: teamName,
// //                           isAdmin: isAdmin,
// //                           isSelf: isSelf,
// //                           onTap: () {
// //                             if (isAdmin && !isSelf) {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (_) => ManageTeamPage(
// //                                     teamId: teamId,
// //                                     teamName: teamName,
// //                                     isAdmin: isAdmin,
// //                                   ),
// //                                 ),
// //                               );
// //                             } else if (!isSelf) {
// //                               _showLeaveTeamDialog(teamId);
// //                             }
// //                           },
// //                           isCurrent: TeamManager().currentTeamId == teamId, // Highlight current team
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../widgets/greet.dart';
// import './team/create_team.dart';
// import './team/manage_team.dart';
// import '../widgets/gathering.dart';
// import '../service/handle_teams.dart';

// class AccountPage extends StatefulWidget {
//   const AccountPage({super.key});

//   @override
//   _AccountPageState createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   List<String> _teamIds = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchTeamIds();
//   }

//   Future<void> _fetchTeamIds() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collectionGroup('members')
//           .where('userId', isEqualTo: user.uid)
//           .where('status', isEqualTo: 'joined')
//           .get();
//       final ids = snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toList();
//       print('Fetched team IDs: $ids'); // Debug log
//       if (ids.isNotEmpty && TeamManager().currentTeamId.isEmpty) {
//         final teamRef = FirebaseFirestore.instance.collection('teams').doc(ids[0]);
//         final teamSnap = await teamRef.get();
//         if (teamSnap.exists) {
//           TeamManager().setCurrentTeam(ids[0], teamSnap.data()?['name'] ?? 'Unnamed', context);
//         }
//       }
//       setState(() {
//         _teamIds = ids;
//       });
//     } catch (e) {
//       print('Error fetching team IDs: $e');
//     }
//   }

//   Future<void> _showLeaveTeamDialog(String teamId) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Leave Gathering'),
//           content: Text('Are you sure you want to leave this gathering?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 try {
//                   final user = FirebaseAuth.instance.currentUser;
//                   if (user != null) {
//                     final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
//                     final teamSnap = await teamRef.get();
//                     if (teamSnap.exists && !teamSnap.data()!['isSelf']) {
//                       final memberRef = teamRef.collection('members').doc(user.uid);
//                       await FirebaseFirestore.instance.runTransaction((transaction) async {
//                         final teamDoc = await transaction.get(teamRef);
//                         if (teamDoc.exists) {
//                           transaction.delete(memberRef);
//                         }
//                       });
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Left gathering')),
//                       );
//                       await _fetchTeamIds();
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Cannot leave "Self" gathering')),
//                       );
//                     }
//                     Navigator.pop(context);
//                   }
//                 } catch (e) {
//                   print('Error leaving gathering: $e');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error leaving gathering: $e')),
//                   );
//                 }
//               },
//               child: Text('Leave'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
//           ),
//         ),
//         child: Column(
//           children: [
//             GreetWidget(),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => CreateTeamPage()),
//                 );
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[100],
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add, color: Colors.blue[600]),
//                     SizedBox(width: 10),
//                     Text(
//                       'Create Gathering',
//                       style: TextStyle(fontSize: 16, color: Colors.blue[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _teamIds.isNotEmpty
//                     ? FirebaseFirestore.instance
//                         .collection('teams')
//                         .where(FieldPath.documentId, whereIn: _teamIds)
//                         .snapshots()
//                     : null,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     print('Error loading gatherings: ${snapshot.error}');
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting && _teamIds.isNotEmpty) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   final teams = snapshot.data?.docs ?? [];
//                   print('Teams loaded: ${teams.map((doc) => doc.id).toList()}'); // Debug log
//                   if (teams.isEmpty && _teamIds.isEmpty) {
//                     return Center(child: Text('No gatherings yet'));
//                   }
//                   if (teams.isEmpty) {
//                     return Center(child: Text('No gatherings found'));
//                   }
//                   return ListView.builder(
//                     itemCount: teams.length,
//                     itemBuilder: (context, index) {
//                       final teamData = teams[index].data() as Map<String, dynamic>;
//                       final teamId = teams[index].id;
//                       final teamName = teamData['name'] ?? 'Unnamed Gathering';
//                       final isAdmin = teamData['admin'] == user?.uid;
//                       final isSelf = teamData['isSelf'] ?? false;
//                       return GestureDetector(
//                         onTap: () {
//                           TeamManager().setCurrentTeam(teamId, teamName, context);
//                           setState(() {}); // Refresh UI
//                         },
//                         child: GatheringWidget(
//                           teamId: teamId,
//                           teamName: teamName,
//                           isAdmin: isAdmin,
//                           isSelf: isSelf,
//                           onTap: () {
//                             if (isAdmin && !isSelf) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => ManageTeamPage(
//                                     teamId: teamId,
//                                     teamName: teamName,
//                                     isAdmin: isAdmin,
//                                   ),
//                                 ),
//                               );
//                             } else if (!isSelf) {
//                               _showLeaveTeamDialog(teamId);
//                             }
//                           },
//                           isCurrent: TeamManager().currentTeamId == teamId, // Highlight current team
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/greet.dart';
import './team/create_team.dart';
import './team/manage_team.dart';
import '../widgets/gathering.dart';
import '../service/handle_teams.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<String> _teamIds = [];

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
          .collectionGroup('members')
          .where('userId', isEqualTo: user.uid)
          .where('status', isEqualTo: 'joined')
          .get();
      final ids = snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toList();
      print('Fetched team IDs: $ids'); // Debug log
      if (ids.isNotEmpty && TeamManager().currentTeamId.isEmpty) {
        final teamRef = FirebaseFirestore.instance.collection('teams').doc(ids[0]);
        final teamSnap = await teamRef.get();
        if (teamSnap.exists) {
          TeamManager().setCurrentTeam(ids[0], teamSnap.data()?['name'] ?? 'Unnamed', context);
        }
      }
      setState(() {
        _teamIds = ids;
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
                    final teamSnap = await teamRef.get();
                    if (teamSnap.exists && !teamSnap.data()!['isSelf']) {
                      final memberRef = teamRef.collection('members').doc(user.uid);
                      await FirebaseFirestore.instance.runTransaction((transaction) async {
                        final teamDoc = await transaction.get(teamRef);
                        if (teamDoc.exists) {
                          transaction.delete(memberRef);
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Left gathering')),
                      );
                      await _fetchTeamIds();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cannot leave "Self" gathering')),
                      );
                    }
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print('Error leaving gathering: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error leaving gathering: $e')),
                  );
                }
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
                  stream: _teamIds.isNotEmpty
                      ? FirebaseFirestore.instance
                          .collection('teams')
                          .where(FieldPath.documentId, whereIn: _teamIds)
                          .snapshots()
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('Error loading gatherings: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting && _teamIds.isNotEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final teams = snapshot.data?.docs ?? [];
                    print('Teams loaded: ${teams.map((doc) => doc.id).toList()}'); // Debug log
                    if (teams.isEmpty && _teamIds.isEmpty) {
                      return Center(child: Text('No gatherings yet'));
                    }
                    if (teams.isEmpty) {
                      return Center(child: Text('No gatherings found'));
                    }
                    return ListView.builder(
                      itemCount: teams.length,
                      itemBuilder: (context, index) {
                        final teamData = teams[index].data() as Map<String, dynamic>;
                        final teamId = teams[index].id;
                        final teamName = teamData['name'] ?? 'Unnamed Gathering';
                        final isAdmin = teamData['admin'] == user?.uid;
                        final isSelf = teamData['isSelf'] ?? false;
                        return GestureDetector(
                          onTap: () {
                            TeamManager().setCurrentTeam(teamId, teamName, context);
                            setState(() {}); // Refresh UI
                          },
                          child: GatheringWidget(
                            teamId: teamId,
                            teamName: teamName,
                            isAdmin: isAdmin,
                            isSelf: isSelf,
                            onTap: () {
                              if (isAdmin && !isSelf) {
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
                              } else if (!isSelf) {
                                _showLeaveTeamDialog(teamId);
                              }
                            },
                            isCurrent: TeamManager().currentTeamId == teamId, // Highlight current team
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