// // // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // // import '../widgets/greet.dart'; // Adjust the import path based on your project structure

// // // // // // // // // // // class NotifyPage extends StatelessWidget {
// // // // // // // // // // //   const NotifyPage({super.key});

// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // //     return Scaffold(
// // // // // // // // // // //       body: Column(
// // // // // // // // // // //         children: [
// // // // // // // // // // //           GreetWidget(), // Call the greet contents here
// // // // // // // // // // //           Expanded(
// // // // // // // // // // //             child: Center(
// // // // // // // // // // //               child: Text('notification page'),
// // // // // // // // // // //             ),
// // // // // // // // // // //           ),

// // // // // // // // // // //         ],

// // // // // // // // // // //       ),
// // // // // // // // // // //     );
// // // // // // // // // // //   }
// // // // // // // // // // // }

// // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // // // // // import '../widgets/greet.dart'; // Adjust the import path based on your project structure

// // // // // // // // // class NotifyPage extends StatelessWidget {
// // // // // // // // //   const NotifyPage({super.key});

// // // // // // // // //   void _handleRequest(String requestId, String teamId, String action) async {
// // // // // // // // //     try {
// // // // // // // // //       if (action == 'accept') {
// // // // // // // // //         final user = FirebaseAuth.instance.currentUser;
// // // // // // // // //         if (user != null) {
// // // // // // // // //           await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
// // // // // // // // //             'members': FieldValue.arrayUnion([user.uid]),
// // // // // // // // //           });
// // // // // // // // //           await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// // // // // // // // //             'status': 'accepted',
// // // // // // // // //           });
// // // // // // // // //         }
// // // // // // // // //       } else {
// // // // // // // // //         await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// // // // // // // // //           'status': 'declined',
// // // // // // // // //         });
// // // // // // // // //       }
// // // // // // // // //     } catch (e) {
// // // // // // // // //       print('Error handling request: $e');
// // // // // // // // //     }
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // // // // // //     return Scaffold(
// // // // // // // // //       body: Column(
// // // // // // // // //         children: [
// // // // // // // // //           GreetWidget(),
// // // // // // // // //           Expanded(
// // // // // // // // //             child: StreamBuilder<QuerySnapshot>(
// // // // // // // // //               stream: FirebaseFirestore.instance
// // // // // // // // //                   .collection('team_requests')
// // // // // // // // //                   .where('userId', isEqualTo: user?.uid ?? '')
// // // // // // // // //                   .where('status', isEqualTo: 'pending')
// // // // // // // // //                   .snapshots(),
// // // // // // // // //               builder: (context, snapshot) {
// // // // // // // // //                 if (snapshot.hasError) {
// // // // // // // // //                   print('Error loading requests: ${snapshot.error}');
// // // // // // // // //                   return Center(child: Text('Error: ${snapshot.error}'));
// // // // // // // // //                 }
// // // // // // // // //                 if (!snapshot.hasData) {
// // // // // // // // //                   return Center(child: CircularProgressIndicator());
// // // // // // // // //                 }
// // // // // // // // //                 final requests = snapshot.data!.docs;
// // // // // // // // //                 if (requests.isEmpty) {
// // // // // // // // //                   return Center(child: Text('No pending team requests'));
// // // // // // // // //                 }
// // // // // // // // //                 return ListView.builder(
// // // // // // // // //                   itemCount: requests.length,
// // // // // // // // //                   itemBuilder: (context, index) {
// // // // // // // // //                     final requestData = requests[index].data() as Map<String, dynamic>;
// // // // // // // // //                     final requestId = requests[index].id;
// // // // // // // // //                     final teamName = requestData['teamName'] ?? 'Unnamed Team';
// // // // // // // // //                     return Container(
// // // // // // // // //                       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // // // // // // // //                       padding: EdgeInsets.all(16),
// // // // // // // // //                       decoration: BoxDecoration(
// // // // // // // // //                         color: Colors.blue[100],
// // // // // // // // //                         borderRadius: BorderRadius.circular(10),
// // // // // // // // //                       ),
// // // // // // // // //                       child: Row(
// // // // // // // // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // // // // //                         children: [
// // // // // // // // //                           Text('Join request for $teamName'),
// // // // // // // // //                           Row(
// // // // // // // // //                             children: [
// // // // // // // // //                               TextButton(
// // // // // // // // //                                 onPressed: () => _handleRequest(requestId, requestData['teamId'], 'accept'),
// // // // // // // // //                                 child: Text('Accept',style: TextStyle(fontSize: 16, color: Colors.green[600]),),
// // // // // // // // //                               ),
// // // // // // // // //                               TextButton(
// // // // // // // // //                                 onPressed: () => _handleRequest(requestId, requestData['teamId'], 'decline'),
// // // // // // // // //                                 child: Text('Decline',style: TextStyle(fontSize: 16, color: Colors.red[600]),),
// // // // // // // // //                               ),
// // // // // // // // //                             ],
// // // // // // // // //                           ),
// // // // // // // // //                         ],
// // // // // // // // //                       ),
// // // // // // // // //                     );
// // // // // // // // //                   },
// // // // // // // // //                 );
// // // // // // // // //               },
// // // // // // // // //             ),
// // // // // // // // //           ),
// // // // // // // // //         ],
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // // // // import '../widgets/greet.dart';

// // // // // // // // class NotifyPage extends StatelessWidget {
// // // // // // // //   const NotifyPage({super.key});

// // // // // // // //   void _handleRequest(String requestId, String teamId, String action) async {
// // // // // // // //     try {
// // // // // // // //       if (action == 'accept') {
// // // // // // // //         final user = FirebaseAuth.instance.currentUser;
// // // // // // // //         if (user != null) {
// // // // // // // //           await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
// // // // // // // //             'members': FieldValue.arrayUnion([user.uid]),
// // // // // // // //           });
// // // // // // // //           await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// // // // // // // //             'status': 'accepted',
// // // // // // // //           });
// // // // // // // //         }
// // // // // // // //       } else {
// // // // // // // //         await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// // // // // // // //           'status': 'declined',
// // // // // // // //         });
// // // // // // // //       }
// // // // // // // //     } catch (e) {
// // // // // // // //       print('Error handling request: $e');
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // // // // //     return Scaffold(
// // // // // // // //       body: Container(
// // // // // // // //         decoration: BoxDecoration(
// // // // // // // //           gradient: LinearGradient(
// // // // // // // //             begin: Alignment.topLeft,
// // // // // // // //             end: Alignment.bottomRight,
// // // // // // // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // // // // // //           ),
// // // // // // // //         ),
// // // // // // // //         child: Column(
// // // // // // // //           children: [
// // // // // // // //             GreetWidget(),
// // // // // // // //             Expanded(
// // // // // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // // // // //                 stream: FirebaseFirestore.instance
// // // // // // // //                     .collection('team_requests')
// // // // // // // //                     .where('userId', isEqualTo: user?.uid ?? '')
// // // // // // // //                     .where('status', isEqualTo: 'pending')
// // // // // // // //                     .snapshots(),
// // // // // // // //                 builder: (context, snapshot) {
// // // // // // // //                   if (snapshot.hasError) {
// // // // // // // //                     print('Error loading requests: ${snapshot.error}');
// // // // // // // //                     return Center(child: Text('Error: ${snapshot.error}'));
// // // // // // // //                   }
// // // // // // // //                   if (!snapshot.hasData) {
// // // // // // // //                     return Center(child: CircularProgressIndicator());
// // // // // // // //                   }
// // // // // // // //                   final requests = snapshot.data!.docs;
// // // // // // // //                   if (requests.isEmpty) {
// // // // // // // //                     return Center(child: Text('No pending team requests'));
// // // // // // // //                   }
// // // // // // // //                   return ListView.builder(
// // // // // // // //                     itemCount: requests.length,
// // // // // // // //                     itemBuilder: (context, index) {
// // // // // // // //                       final requestData = requests[index].data() as Map<String, dynamic>;
// // // // // // // //                       final requestId = requests[index].id;
// // // // // // // //                       final teamName = requestData['teamName'] ?? 'Unnamed Team';
// // // // // // // //                       return Container(
// // // // // // // //                         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // // // // // // //                         padding: EdgeInsets.all(16),
// // // // // // // //                         decoration: BoxDecoration(
// // // // // // // //                           color: Colors.blue[100],
// // // // // // // //                           borderRadius: BorderRadius.circular(10),
// // // // // // // //                         ),
// // // // // // // //                         child: Row(
// // // // // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // // // //                           children: [
// // // // // // // //                             Text('Join request for $teamName'),
// // // // // // // //                             Row(
// // // // // // // //                               children: [
// // // // // // // //                                 TextButton(
// // // // // // // //                                   onPressed: () => _handleRequest(requestId, requestData['teamId'], 'accept'),
// // // // // // // //                                   child: Text('Accept', style: TextStyle(fontSize: 16, color: Colors.green[600])),
// // // // // // // //                                 ),
// // // // // // // //                                 TextButton(
// // // // // // // //                                   onPressed: () => _handleRequest(requestId, requestData['teamId'], 'decline'),
// // // // // // // //                                   child: Text('Decline', style: TextStyle(fontSize: 16, color: Colors.red[600])),
// // // // // // // //                                 ),
// // // // // // // //                               ],
// // // // // // // //                             ),
// // // // // // // //                           ],
// // // // // // // //                         ),
// // // // // // // //                       );
// // // // // // // //                     },
// // // // // // // //                   );
// // // // // // // //                 },
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //           ],
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // // // import '../widgets/greet.dart';

// // // // // // // class NotifyPage extends StatelessWidget {
// // // // // // //   const NotifyPage({super.key});

// // // // // // //   void _handleRequest(String requestId, String teamId, String action) async {
// // // // // // //     try {
// // // // // // //       final user = FirebaseAuth.instance.currentUser;
// // // // // // //       if (user == null) return;

// // // // // // //       if (action == 'accept') {
// // // // // // //         // Update teams with teamRequestId to satisfy security rules
// // // // // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
// // // // // // //           'members': FieldValue.arrayUnion([user.uid]),
// // // // // // //           'teamRequestId': requestId, // Temporary field for rule validation
// // // // // // //         });
// // // // // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
// // // // // // //           'teamRequestId': FieldValue.delete(), // Clean up the temporary field
// // // // // // //         });
// // // // // // //         await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// // // // // // //           'status': 'accepted',
// // // // // // //         });
// // // // // // //       } else {
// // // // // // //         await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// // // // // // //           'status': 'declined',
// // // // // // //         });
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       print('Error handling request: $e');
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // // // //     return Scaffold(
// // // // // // //       body: Container(
// // // // // // //         decoration: BoxDecoration(
// // // // // // //           gradient: LinearGradient(
// // // // // // //             begin: Alignment.topLeft,
// // // // // // //             end: Alignment.bottomRight,
// // // // // // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //         child: Column(
// // // // // // //           children: [
// // // // // // //             GreetWidget(),
// // // // // // //             Expanded(
// // // // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // // // //                 stream: FirebaseFirestore.instance
// // // // // // //                     .collection('team_requests')
// // // // // // //                     .where('userId', isEqualTo: user?.uid ?? '')
// // // // // // //                     .where('status', isEqualTo: 'pending')
// // // // // // //                     .snapshots(),
// // // // // // //                 builder: (context, snapshot) {
// // // // // // //                   if (snapshot.hasError) {
// // // // // // //                     print('Error loading requests: ${snapshot.error}');
// // // // // // //                     return Center(child: Text('Error: ${snapshot.error}'));
// // // // // // //                   }
// // // // // // //                   if (!snapshot.hasData) {
// // // // // // //                     return Center(child: CircularProgressIndicator());
// // // // // // //                   }
// // // // // // //                   final requests = snapshot.data!.docs;
// // // // // // //                   if (requests.isEmpty) {
// // // // // // //                     return Center(child: Text('No pending team requests'));
// // // // // // //                   }
// // // // // // //                   return ListView.builder(
// // // // // // //                     itemCount: requests.length,
// // // // // // //                     itemBuilder: (context, index) {
// // // // // // //                       final requestData = requests[index].data() as Map<String, dynamic>;
// // // // // // //                       final requestId = requests[index].id;
// // // // // // //                       final teamName = requestData['teamName'] ?? 'Unnamed Team';
// // // // // // //                       return Container(
// // // // // // //                         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // // // // // //                         padding: EdgeInsets.all(16),
// // // // // // //                         decoration: BoxDecoration(
// // // // // // //                           color: Colors.blue[100],
// // // // // // //                           borderRadius: BorderRadius.circular(10),
// // // // // // //                         ),
// // // // // // //                         child: Row(
// // // // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // // //                           children: [
// // // // // // //                             Text('$teamName',style: TextStyle(fontSize: 18)),
// // // // // // //                             Row(
// // // // // // //                               children: [
// // // // // // //                                 TextButton(
// // // // // // //                                   onPressed: () => _handleRequest(requestId, requestData['teamId'], 'accept'),
// // // // // // //                                   child: Text('Accept', style: TextStyle(fontSize: 16, color: Colors.green[600])),
// // // // // // //                                 ),
// // // // // // //                                 TextButton(
// // // // // // //                                   onPressed: () => _handleRequest(requestId, requestData['teamId'], 'decline'),
// // // // // // //                                   child: Text('Decline', style: TextStyle(fontSize: 16, color: Colors.red[600])),
// // // // // // //                                 ),
// // // // // // //                               ],
// // // // // // //                             ),
// // // // // // //                           ],
// // // // // // //                         ),
// // // // // // //                       );
// // // // // // //                     },
// // // // // // //                   );
// // // // // // //                 },
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // // import '../widgets/greet.dart';

// // // // // // class NotifyPage extends StatelessWidget {
// // // // // //   const NotifyPage({super.key});

// // // // // //   void _handleRequest(String requestId, String teamId, String action) async {
// // // // // //     try {
// // // // // //       final user = FirebaseAuth.instance.currentUser;
// // // // // //       if (user == null) return;

// // // // // //       print('Handling request: $requestId, $teamId, $action'); // Debug log
// // // // // //       if (action == 'accept') {
// // // // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
// // // // // //           {
// // // // // //             'members': FieldValue.arrayUnion([user.uid]),
// // // // // //             'teamRequestId': requestId,
// // // // // //           },
// // // // // //         );
// // // // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
// // // // // //           {'teamRequestId': FieldValue.delete()},
// // // // // //         );
// // // // // //         await FirebaseFirestore.instance
// // // // // //             .collection('team_requests')
// // // // // //             .doc(requestId)
// // // // // //             .update({'status': 'accepted'});
// // // // // //       } else {
// // // // // //         await FirebaseFirestore.instance
// // // // // //             .collection('team_requests')
// // // // // //             .doc(requestId)
// // // // // //             .update({'status': 'declined'});
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print('Error handling request: $e');
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // // //     return Scaffold(
// // // // // //       backgroundColor:
// // // // // //           Colors.transparent, // Ensure Scaffold doesn't add white background
// // // // // //       body: Container(
// // // // // //         decoration: BoxDecoration(
// // // // // //           gradient: LinearGradient(
// // // // // //             begin: Alignment.topLeft,
// // // // // //             end: Alignment.bottomRight,
// // // // // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // // // //           ),
// // // // // //         ),
// // // // // //         // child: SingleChildScrollView(
// // // // // //           child: Padding(
// // // // // //             padding: EdgeInsets.all(16.0),
// // // // // //             child: Column(
// // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //               children: [
// // // // // //                 GreetWidget(),
// // // // // //                 SizedBox(height: 20),
// // // // // //                 Text(
// // // // // //                   'Gathering Requests',
// // // // // //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // // // //                 ),
// // // // // //                 SizedBox(height: 10),
// // // // // //                 Container(
// // // // // //                   height: 200,
// // // // // //                   decoration: BoxDecoration(
// // // // // //                     border: Border.all(color: Colors.grey[300]!),
// // // // // //                     borderRadius: BorderRadius.circular(10),
// // // // // //                   ),
// // // // // //                   child: StreamBuilder<QuerySnapshot>(
// // // // // //                     stream: FirebaseFirestore.instance
// // // // // //                         .collection('team_requests')
// // // // // //                         .where('userId', isEqualTo: user?.uid ?? '')
// // // // // //                         .where('status', isEqualTo: 'pending')
// // // // // //                         .snapshots(),
// // // // // //                     builder: (context, snapshot) {
// // // // // //                       if (snapshot.hasError) {
// // // // // //                         print('Error loading requests: ${snapshot.error}');
// // // // // //                         return Center(child: Text('Error: ${snapshot.error}'));
// // // // // //                       }
// // // // // //                       if (!snapshot.hasData) {
// // // // // //                         return Center(child: CircularProgressIndicator());
// // // // // //                       }
// // // // // //                       final requests = snapshot.data!.docs;
// // // // // //                       if (requests.isEmpty) {
// // // // // //                         return Center(child: Text('No pending team requests'));
// // // // // //                       }
// // // // // //                       return ListView.builder(
// // // // // //                         padding: EdgeInsets.all(8.0),
// // // // // //                         itemCount: requests.length,
// // // // // //                         itemBuilder: (context, index) {
// // // // // //                           if (index >= 3) return SizedBox.shrink();
// // // // // //                           final requestData =
// // // // // //                               requests[index].data() as Map<String, dynamic>;
// // // // // //                           final requestId = requests[index].id;
// // // // // //                           final teamName =
// // // // // //                               requestData['teamName'] ?? 'Unnamed Team';
// // // // // //                           return Container(
// // // // // //                             margin: EdgeInsets.only(bottom: 8),
// // // // // //                             padding: EdgeInsets.all(12),
// // // // // //                             decoration: BoxDecoration(
// // // // // //                               color: Colors.blue[100],
// // // // // //                               borderRadius: BorderRadius.circular(8),
// // // // // //                             ),
// // // // // //                             child: Row(
// // // // // //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //                               children: [
// // // // // //                                 Text(
// // // // // //                                   '$teamName',
// // // // // //                                   style: TextStyle(fontSize: 18),
// // // // // //                                 ),
// // // // // //                                 Row(
// // // // // //                                   children: [
// // // // // //                                     TextButton(
// // // // // //                                       onPressed: () => _handleRequest(
// // // // // //                                         requestId,
// // // // // //                                         requestData['teamId'],
// // // // // //                                         'accept',
// // // // // //                                       ),
// // // // // //                                       child: Text(
// // // // // //                                         'Accept',
// // // // // //                                         style: TextStyle(
// // // // // //                                           fontSize: 16,
// // // // // //                                           color: Colors.green[600],
// // // // // //                                         ),
// // // // // //                                       ),
// // // // // //                                     ),
// // // // // //                                     TextButton(
// // // // // //                                       onPressed: () => _handleRequest(
// // // // // //                                         requestId,
// // // // // //                                         requestData['teamId'],
// // // // // //                                         'decline',
// // // // // //                                       ),
// // // // // //                                       child: Text(
// // // // // //                                         'Decline',
// // // // // //                                         style: TextStyle(
// // // // // //                                           fontSize: 16,
// // // // // //                                           color: Colors.red[600],
// // // // // //                                         ),
// // // // // //                                       ),
// // // // // //                                     ),
// // // // // //                                   ],
// // // // // //                                 ),
// // // // // //                               ],
// // // // // //                             ),
// // // // // //                           );
// // // // // //                         },
// // // // // //                       );
// // // // // //                     },
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 SizedBox(height: 20),
// // // // // //                 Text(
// // // // // //                   'Other Notifications',
// // // // // //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // // // //                 ),
// // // // // //                 SizedBox(height: 10),
// // // // // //                 Container(
// // // // // //                   decoration: BoxDecoration(
// // // // // //                     border: Border.all(color: Colors.grey[300]!),
// // // // // //                     borderRadius: BorderRadius.circular(10),
// // // // // //                   ),
// // // // // //                   child: ListView(
// // // // // //                     shrinkWrap: true,
// // // // // //                     physics: NeverScrollableScrollPhysics(),
// // // // // //                     padding: EdgeInsets.all(8.0),
// // // // // //                     children: [
// // // // // //                       Container(
// // // // // //                         margin: EdgeInsets.only(bottom: 8),
// // // // // //                         padding: EdgeInsets.all(12),
// // // // // //                         decoration: BoxDecoration(
// // // // // //                           color: Colors.grey[200],
// // // // // //                           borderRadius: BorderRadius.circular(8),
// // // // // //                         ),
// // // // // //                         child: Text(
// // // // // //                           'Notification 1: Sample notification',
// // // // // //                           style: TextStyle(fontSize: 16),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       Container(
// // // // // //                         margin: EdgeInsets.only(bottom: 8),
// // // // // //                         padding: EdgeInsets.all(12),
// // // // // //                         decoration: BoxDecoration(
// // // // // //                           color: Colors.grey[200],
// // // // // //                           borderRadius: BorderRadius.circular(8),
// // // // // //                         ),
// // // // // //                         child: Text(
// // // // // //                           'Notification 2: Another sample',
// // // // // //                           style: TextStyle(fontSize: 16),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import '../widgets/greet.dart';

// // // // // class NotifyPage extends StatelessWidget {
// // // // //   const NotifyPage({super.key});

// // // // //   void _handleRequest(String requestId, String teamId, String action) async {
// // // // //     try {
// // // // //       final user = FirebaseAuth.instance.currentUser;
// // // // //       if (user == null) return;

// // // // //       print('Handling request: $requestId, $teamId, $action'); // Debug log
// // // // //       if (action == 'accept') {
// // // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
// // // // //           {
// // // // //             'members': FieldValue.arrayUnion([user.uid]),
// // // // //             'teamRequestId': requestId,
// // // // //           },
// // // // //         );
// // // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
// // // // //           {'teamRequestId': FieldValue.delete()},
// // // // //         );
// // // // //         await FirebaseFirestore.instance
// // // // //             .collection('team_requests')
// // // // //             .doc(requestId)
// // // // //             .update({'status': 'accepted'});
// // // // //       } else {
// // // // //         await FirebaseFirestore.instance
// // // // //             .collection('team_requests')
// // // // //             .doc(requestId)
// // // // //             .update({'status': 'declined'});
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print('Error handling request: $e');
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final user = FirebaseAuth.instance.currentUser;

// // // // //     return Scaffold(
// // // // //       body: Stack(
// // // // //         children: [
// // // // //           Container(
// // // // //             decoration: BoxDecoration(
// // // // //               gradient: LinearGradient(
// // // // //                 begin: Alignment.topLeft,
// // // // //                 end: Alignment.bottomRight,
// // // // //                 colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // // //               ),
// // // // //             ),
// // // // //             height: MediaQuery.of(context).size.height, // Full screen height
// // // // //           ),
// // // // //           SingleChildScrollView(
// // // // //             child: Padding(
// // // // //               padding: EdgeInsets.all(16.0),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   GreetWidget(),
// // // // //                   SizedBox(height: 20),
// // // // //                   Text(
// // // // //                     'Gathering Requests',
// // // // //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // // //                   ),
// // // // //                   SizedBox(height: 10),
// // // // //                   Container(
// // // // //                     height: 200,
// // // // //                     decoration: BoxDecoration(
// // // // //                       border: Border.all(color: Colors.grey[300]!),
// // // // //                       borderRadius: BorderRadius.circular(10),
// // // // //                     ),
// // // // //                     child: StreamBuilder<QuerySnapshot>(
// // // // //                       stream: FirebaseFirestore.instance
// // // // //                           .collection('team_requests')
// // // // //                           .where('userId', isEqualTo: user?.uid ?? '')
// // // // //                           .where('status', isEqualTo: 'pending')
// // // // //                           .snapshots(),
// // // // //                       builder: (context, snapshot) {
// // // // //                         if (snapshot.hasError) {
// // // // //                           print('Error loading requests: ${snapshot.error}');
// // // // //                           return Center(child: Text('Error: ${snapshot.error}'));
// // // // //                         }
// // // // //                         if (!snapshot.hasData) {
// // // // //                           return Center(child: CircularProgressIndicator());
// // // // //                         }
// // // // //                         final requests = snapshot.data!.docs;
// // // // //                         if (requests.isEmpty) {
// // // // //                           return Center(child: Text('No pending team requests'));
// // // // //                         }
// // // // //                         return ListView.builder(
// // // // //                           padding: EdgeInsets.all(8.0),
// // // // //                           itemCount: requests.length,
// // // // //                           itemBuilder: (context, index) {
// // // // //                             if (index >= 3) return SizedBox.shrink();
// // // // //                             final requestData =
// // // // //                                 requests[index].data() as Map<String, dynamic>;
// // // // //                             final requestId = requests[index].id;
// // // // //                             final teamName =
// // // // //                                 requestData['teamName'] ?? 'Unnamed Team';
// // // // //                             return Container(
// // // // //                               margin: EdgeInsets.only(bottom: 8),
// // // // //                               padding: EdgeInsets.all(12),
// // // // //                               decoration: BoxDecoration(
// // // // //                                 color: Colors.blue[100],
// // // // //                                 borderRadius: BorderRadius.circular(8),
// // // // //                               ),
// // // // //                               child: Row(
// // // // //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                                 children: [
// // // // //                                   Text(
// // // // //                                     '$teamName',
// // // // //                                     style: TextStyle(fontSize: 18),
// // // // //                                   ),
// // // // //                                   Row(
// // // // //                                     children: [
// // // // //                                       TextButton(
// // // // //                                         onPressed: () => _handleRequest(
// // // // //                                           requestId,
// // // // //                                           requestData['teamId'],
// // // // //                                           'accept',
// // // // //                                         ),
// // // // //                                         child: Text(
// // // // //                                           'Accept',
// // // // //                                           style: TextStyle(
// // // // //                                             fontSize: 16,
// // // // //                                             color: Colors.green[600],
// // // // //                                           ),
// // // // //                                         ),
// // // // //                                       ),
// // // // //                                       TextButton(
// // // // //                                         onPressed: () => _handleRequest(
// // // // //                                           requestId,
// // // // //                                           requestData['teamId'],
// // // // //                                           'decline',
// // // // //                                         ),
// // // // //                                         child: Text(
// // // // //                                           'Decline',
// // // // //                                           style: TextStyle(
// // // // //                                             fontSize: 16,
// // // // //                                             color: Colors.red[600],
// // // // //                                           ),
// // // // //                                         ),
// // // // //                                       ),
// // // // //                                     ],
// // // // //                                   ),
// // // // //                                 ],
// // // // //                               ),
// // // // //                             );
// // // // //                           },
// // // // //                         );
// // // // //                       },
// // // // //                     ),
// // // // //                   ),
// // // // //                   SizedBox(height: 20),
// // // // //                   Text(
// // // // //                     'Other Notifications',
// // // // //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // // //                   ),
// // // // //                   SizedBox(height: 10),
// // // // //                   Container(
// // // // //                     decoration: BoxDecoration(
// // // // //                       border: Border.all(color: Colors.grey[300]!),
// // // // //                       borderRadius: BorderRadius.circular(10),
// // // // //                     ),
// // // // //                     child: ListView(
// // // // //                       shrinkWrap: true,
// // // // //                       physics: NeverScrollableScrollPhysics(),
// // // // //                       padding: EdgeInsets.all(8.0),
// // // // //                       children: [
// // // // //                         Container(
// // // // //                           margin: EdgeInsets.only(bottom: 8),
// // // // //                           padding: EdgeInsets.all(12),
// // // // //                           decoration: BoxDecoration(
// // // // //                             color: Colors.grey[200],
// // // // //                             borderRadius: BorderRadius.circular(8),
// // // // //                           ),
// // // // //                           child: Text(
// // // // //                             'Notification 1: Sample notification',
// // // // //                             style: TextStyle(fontSize: 16),
// // // // //                           ),
// // // // //                         ),
// // // // //                         Container(
// // // // //                           margin: EdgeInsets.only(bottom: 8),
// // // // //                           padding: EdgeInsets.all(12),
// // // // //                           decoration: BoxDecoration(
// // // // //                             color: Colors.grey[200],
// // // // //                             borderRadius: BorderRadius.circular(8),
// // // // //                           ),
// // // // //                           child: Text(
// // // // //                             'Notification 2: Another sample',
// // // // //                             style: TextStyle(fontSize: 16),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import '../widgets/greet.dart';

// // // // class NotifyPage extends StatelessWidget {
// // // //   const NotifyPage({super.key});

// // // //   void _handleRequest(String requestId, String teamId, String action) async {
// // // //     try {
// // // //       final user = FirebaseAuth.instance.currentUser;
// // // //       if (user == null) return;

// // // //       print('Handling request: $requestId, $teamId, $action'); // Debug log
// // // //       if (action == 'accept') {
// // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
// // // //           {
// // // //             'members': FieldValue.arrayUnion([user.uid]),
// // // //             'teamRequestId': requestId,
// // // //           },
// // // //         );
// // // //         await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
// // // //           {'teamRequestId': FieldValue.delete()},
// // // //         );
// // // //         await FirebaseFirestore.instance
// // // //             .collection('team_requests')
// // // //             .doc(requestId)
// // // //             .update({'status': 'accepted'});
// // // //       } else {
// // // //         await FirebaseFirestore.instance
// // // //             .collection('team_requests')
// // // //             .doc(requestId)
// // // //             .update({'status': 'declined'});
// // // //       }
// // // //     } catch (e) {
// // // //       print('Error handling request: $e');
// // // //     }
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
// // // //         child: SafeArea(
// // // //           child: Column(
// // // //             children: [
// // // //               GreetWidget(), // Fixed at top with natural height
// // // //               Expanded(
// // // //                 child: SingleChildScrollView(
// // // //                   padding: EdgeInsets.all(16.0),
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Text(
// // // //                         'Gathering Requests',
// // // //                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //                       ),
// // // //                       SizedBox(height: 10),
// // // //                       Container(
// // // //                         height: 200,
// // // //                         decoration: BoxDecoration(
// // // //                           border: Border.all(color: Colors.grey[300]!),
// // // //                           borderRadius: BorderRadius.circular(10),
// // // //                         ),
// // // //                         child: StreamBuilder<QuerySnapshot>(
// // // //                           stream: FirebaseFirestore.instance
// // // //                               .collection('team_requests')
// // // //                               .where('userId', isEqualTo: user?.uid ?? '')
// // // //                               .where('status', isEqualTo: 'pending')
// // // //                               .snapshots(),
// // // //                           builder: (context, snapshot) {
// // // //                             if (snapshot.hasError) {
// // // //                               print('Error loading requests: ${snapshot.error}');
// // // //                               return Center(child: Text('Error: ${snapshot.error}'));
// // // //                             }
// // // //                             if (!snapshot.hasData) {
// // // //                               return Center(child: CircularProgressIndicator());
// // // //                             }
// // // //                             final requests = snapshot.data!.docs;
// // // //                             if (requests.isEmpty) {
// // // //                               return Center(child: Text('No pending team requests'));
// // // //                             }
// // // //                             return ListView.builder(
// // // //                               padding: EdgeInsets.all(8.0),
// // // //                               itemCount: requests.length,
// // // //                               itemBuilder: (context, index) {
// // // //                                 if (index >= 3) return SizedBox.shrink();
// // // //                                 final requestData =
// // // //                                     requests[index].data() as Map<String, dynamic>;
// // // //                                 final requestId = requests[index].id;
// // // //                                 final teamName =
// // // //                                     requestData['teamName'] ?? 'Unnamed Team';
// // // //                                 return Container(
// // // //                                   margin: EdgeInsets.only(bottom: 8),
// // // //                                   padding: EdgeInsets.all(12),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: Colors.blue[100],
// // // //                                     borderRadius: BorderRadius.circular(8),
// // // //                                   ),
// // // //                                   child: Row(
// // // //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                                     children: [
// // // //                                       Text(
// // // //                                         '$teamName',
// // // //                                         style: TextStyle(fontSize: 18),
// // // //                                       ),
// // // //                                       Row(
// // // //                                         children: [
// // // //                                           TextButton(
// // // //                                             onPressed: () => _handleRequest(
// // // //                                               requestId,
// // // //                                               requestData['teamId'],
// // // //                                               'accept',
// // // //                                             ),
// // // //                                             child: Text(
// // // //                                               'Accept',
// // // //                                               style: TextStyle(
// // // //                                                 fontSize: 16,
// // // //                                                 color: Colors.green[600],
// // // //                                               ),
// // // //                                             ),
// // // //                                           ),
// // // //                                           TextButton(
// // // //                                             onPressed: () => _handleRequest(
// // // //                                               requestId,
// // // //                                               requestData['teamId'],
// // // //                                               'decline',
// // // //                                             ),
// // // //                                             child: Text(
// // // //                                               'Decline',
// // // //                                               style: TextStyle(
// // // //                                                 fontSize: 16,
// // // //                                                 color: Colors.red[600],
// // // //                                               ),
// // // //                                             ),
// // // //                                           ),
// // // //                                         ],
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 );
// // // //                               },
// // // //                             );
// // // //                           },
// // // //                         ),
// // // //                       ),
// // // //                       SizedBox(height: 20),
// // // //                       Text(
// // // //                         'Other Notifications',
// // // //                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //                       ),
// // // //                       SizedBox(height: 10),
// // // //                       Container(
// // // //                         decoration: BoxDecoration(
// // // //                           border: Border.all(color: Colors.grey[300]!),
// // // //                           borderRadius: BorderRadius.circular(10),
// // // //                         ),
// // // //                         child: ListView(
// // // //                           shrinkWrap: true,
// // // //                           physics: NeverScrollableScrollPhysics(),
// // // //                           padding: EdgeInsets.all(8.0),
// // // //                           children: [
// // // //                             Container(
// // // //                               margin: EdgeInsets.only(bottom: 8),
// // // //                               padding: EdgeInsets.all(12),
// // // //                               decoration: BoxDecoration(
// // // //                                 color: Colors.grey[200],
// // // //                                 borderRadius: BorderRadius.circular(8),
// // // //                               ),
// // // //                               child: Text(
// // // //                                 'Notification 1: Sample notification',
// // // //                                 style: TextStyle(fontSize: 16),
// // // //                               ),
// // // //                             ),
// // // //                             Container(
// // // //                               margin: EdgeInsets.only(bottom: 8),
// // // //                               padding: EdgeInsets.all(12),
// // // //                               decoration: BoxDecoration(
// // // //                                 color: Colors.grey[200],
// // // //                                 borderRadius: BorderRadius.circular(8),
// // // //                               ),
// // // //                               child: Text(
// // // //                                 'Notification 2: Another sample',
// // // //                                 style: TextStyle(fontSize: 16),
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../widgets/greet.dart';

// // // class NotifyPage extends StatefulWidget {
// // //   const NotifyPage({super.key});

// // //   @override
// // //   _NotifyPageState createState() => _NotifyPageState();
// // // }

// // // class _NotifyPageState extends State<NotifyPage> {
// // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// // //   void _handleRequest(String requestId, String teamId, String action) async {
// // //     if (!mounted) return; // Check if widget is still mounted
// // //     final scaffoldMessenger = ScaffoldMessenger.of(context);
// // //     try {
// // //       final user = FirebaseAuth.instance.currentUser;
// // //       if (user == null) return;
// // //       final batch = FirebaseFirestore.instance.batch();
// // //       final teamRef = FirebaseFirestore.instance
// // //           .collection('teams')
// // //           .doc(teamId);
// // //       final requestRef = FirebaseFirestore.instance
// // //           .collection('team_requests')
// // //           .doc(requestId);

// // //       // Check if the team request exists and is still pending
// // //       final requestSnapshot = await requestRef.get();
// // //       if (!requestSnapshot.exists) {
// // //         print('Request does not exist.');
// // //         return;
// // //       }
// // //       if (requestSnapshot.data()?['status'] != 'pending') {
// // //         print('Request has already been processed.');
// // //         return;
// // //       }

// // //       if (action == 'accept') {
// // //         // Add user to team_members collection
// // //         batch.set(
// // //           teamRef.collection('team_members').doc(user.uid),
// // //           {
// // //             'userId': user.uid,
// // //             'status': 'accepted',
// // //             'joinedAt': FieldValue.serverTimestamp(),
// // //           },
// // //           SetOptions(merge: true),
// // //         );

// // //         // Update the team request status to 'accepted'
// // //         batch.update(requestRef, {'status': 'accepted'});
// // //       } else if (action == 'decline') {
// // //         // Decline the request
// // //         batch.update(requestRef, {'status': 'declined'});
// // //       }

// // //       // Commit the batch operation
// // //       await batch.commit();

// // //       if (mounted) {
// // //         scaffoldMessenger.showSnackBar(
// // //           SnackBar(content: Text('Request $action successfully')),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       print('Error handling request: $e');
// // //       if (mounted) {
// // //         scaffoldMessenger.showSnackBar(
// // //           SnackBar(content: Text('Error handling request: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final user = FirebaseAuth.instance.currentUser;

// // //     return Scaffold(
// // //       key: _scaffoldKey,
// // //       body: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: LinearGradient(
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // //           ),
// // //         ),
// // //         child: SafeArea(
// // //           child: Column(
// // //             children: [
// // //               GreetWidget(),
// // //               Expanded(
// // //                 child: SingleChildScrollView(
// // //                   padding: EdgeInsets.all(16.0),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Gathering Requests',
// // //                         style: TextStyle(
// // //                           fontSize: 20,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       SizedBox(height: 10),
// // //                       Container(
// // //                         height: 200,
// // //                         decoration: BoxDecoration(
// // //                           border: Border.all(color: Colors.grey[300]!),
// // //                           borderRadius: BorderRadius.circular(10),
// // //                         ),
// // //                         child: StreamBuilder<QuerySnapshot>(
// // //                           stream: FirebaseFirestore.instance
// // //                               .collection('team_requests')
// // //                               .where('userId', isEqualTo: user?.uid ?? '')
// // //                               .where('status', isEqualTo: 'pending')
// // //                               .snapshots(),
// // //                           builder: (context, snapshot) {
// // //                             if (snapshot.hasError) {
// // //                               print(
// // //                                 'Error loading requests: ${snapshot.error}',
// // //                               );
// // //                               return Center(
// // //                                 child: Text('Error: ${snapshot.error}'),
// // //                               );
// // //                             }
// // //                             if (!snapshot.hasData) {
// // //                               return Center(child: CircularProgressIndicator());
// // //                             }
// // //                             final requests = snapshot.data!.docs;
// // //                             if (requests.isEmpty) {
// // //                               return Center(
// // //                                 child: Text('No pending team requests'),
// // //                               );
// // //                             }
// // //                             return ListView.builder(
// // //                               padding: EdgeInsets.all(8.0),
// // //                               itemCount: requests.length,
// // //                               itemBuilder: (context, index) {
// // //                                 if (index >= 3) return SizedBox.shrink();
// // //                                 final requestData =
// // //                                     requests[index].data()
// // //                                         as Map<String, dynamic>;
// // //                                 final requestId = requests[index].id;
// // //                                 final teamName =
// // //                                     requestData['teamName'] ?? 'Unnamed Team';
// // //                                 return Container(
// // //                                   margin: EdgeInsets.only(bottom: 8),
// // //                                   padding: EdgeInsets.all(12),
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.blue[100],
// // //                                     borderRadius: BorderRadius.circular(8),
// // //                                   ),
// // //                                   child: Row(
// // //                                     mainAxisAlignment:
// // //                                         MainAxisAlignment.spaceBetween,
// // //                                     children: [
// // //                                       Text(
// // //                                         '$teamName',
// // //                                         style: TextStyle(fontSize: 18),
// // //                                       ),
// // //                                       Row(
// // //                                         children: [
// // //                                           TextButton(
// // //                                             onPressed: () => _handleRequest(
// // //                                               requestId,
// // //                                               requestData['teamId'],
// // //                                               'accept',
// // //                                             ),
// // //                                             child: Text(
// // //                                               'Accept',
// // //                                               style: TextStyle(
// // //                                                 fontSize: 16,
// // //                                                 color: Colors.green[600],
// // //                                               ),
// // //                                             ),
// // //                                           ),
// // //                                           TextButton(
// // //                                             onPressed: () => _handleRequest(
// // //                                               requestId,
// // //                                               requestData['teamId'],
// // //                                               'decline',
// // //                                             ),
// // //                                             child: Text(
// // //                                               'Decline',
// // //                                               style: TextStyle(
// // //                                                 fontSize: 16,
// // //                                                 color: Colors.red[600],
// // //                                               ),
// // //                                             ),
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 );
// // //                               },
// // //                             );
// // //                           },
// // //                         ),
// // //                       ),
// // //                       SizedBox(height: 20),
// // //                       Text(
// // //                         'Other Notifications',
// // //                         style: TextStyle(
// // //                           fontSize: 20,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       SizedBox(height: 10),
// // //                       Container(
// // //                         decoration: BoxDecoration(
// // //                           border: Border.all(color: Colors.grey[300]!),
// // //                           borderRadius: BorderRadius.circular(10),
// // //                         ),
// // //                         child: ListView(
// // //                           shrinkWrap: true,
// // //                           physics: NeverScrollableScrollPhysics(),
// // //                           padding: EdgeInsets.all(8.0),
// // //                           children: [
// // //                             Container(
// // //                               margin: EdgeInsets.only(bottom: 8),
// // //                               padding: EdgeInsets.all(12),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.grey[200],
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               child: Text(
// // //                                 'Notification 1: Sample notification',
// // //                                 style: TextStyle(fontSize: 16),
// // //                               ),
// // //                             ),
// // //                             Container(
// // //                               margin: EdgeInsets.only(bottom: 8),
// // //                               padding: EdgeInsets.all(12),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.grey[200],
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               child: Text(
// // //                                 'Notification 2: Another sample',
// // //                                 style: TextStyle(fontSize: 16),
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../widgets/greet.dart';

// // class NotifyPage extends StatefulWidget {
// //   const NotifyPage({super.key});

// //   @override
// //   _NotifyPageState createState() => _NotifyPageState();
// // }

// // class _NotifyPageState extends State<NotifyPage> {
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// //   void _handleRequest(String requestId, String teamId, String action) async {
// //     if (!mounted) return; // Check if widget is still mounted
// //     final scaffoldMessenger = ScaffoldMessenger.of(context);
// //     try {
// //       final user = FirebaseAuth.instance.currentUser;
// //       if (user == null) return;

// //       print('Handling request: $requestId, $teamId, $action'); // Debug log
// //       final batch = FirebaseFirestore.instance.batch();
// //       final teamRef = FirebaseFirestore.instance.collection('teams').doc(teamId);
// //       final requestRef = FirebaseFirestore.instance.collection('team_requests').doc(requestId);

// //       // Check if the team request exists and is still pending
// //       final requestSnapshot = await requestRef.get();
// //       if (!requestSnapshot.exists) {
// //         print('Request does not exist.');
// //         return;
// //       }
// //       if (requestSnapshot.data()?['status'] != 'pending') {
// //         print('Request has already been processed.');
// //         return;
// //       }

// //       final memberRef = teamRef.collection('members').doc(user.uid);

// //       if (action == 'accept') {
// //         // Add or update the member in the members subcollection
// //         batch.set(
// //           memberRef,
// //           {
// //             'name': user.displayName ?? user.email!.split('@')[0], // Fallback to email username
// //             'role': 'member', // Default role for accepted members
// //             'status': 'joined',
// //             'joined_at': FieldValue.serverTimestamp(),
// //           },
// //           SetOptions(merge: true),
// //         );
// //         // Update the team request status to 'accepted'
// //         batch.update(requestRef, {'status': 'accepted'});
// //       } else if (action == 'decline') {
// //         // No need to add to members, just decline the request
// //         batch.update(requestRef, {'status': 'declined'});
// //       }

// //       // Commit the batch operation
// //       await batch.commit();

// //       if (mounted) {
// //         scaffoldMessenger.showSnackBar(
// //           SnackBar(content: Text('Request $action successfully')),
// //         );
// //       }
// //     } catch (e) {
// //       print('Error handling request: $e');
// //       if (mounted) {
// //         scaffoldMessenger.showSnackBar(
// //           SnackBar(content: Text('Error handling request: $e')),
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;

// //     return Scaffold(
// //       key: _scaffoldKey,
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Column(
// //             children: [
// //               GreetWidget(),
// //               Expanded(
// //                 child: SingleChildScrollView(
// //                   padding: EdgeInsets.all(16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Gathering Requests',
// //                         style: TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       SizedBox(height: 10),
// //                       Container(
// //                         height: 200,
// //                         decoration: BoxDecoration(
// //                           border: Border.all(color: Colors.grey[300]!),
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: StreamBuilder<QuerySnapshot>(
// //                           stream: FirebaseFirestore.instance
// //                               .collection('team_requests')
// //                               .where('userId', isEqualTo: user?.uid ?? '')
// //                               .where('status', isEqualTo: 'pending')
// //                               .snapshots(),
// //                           builder: (context, snapshot) {
// //                             if (snapshot.hasError) {
// //                               print(
// //                                 'Error loading requests: ${snapshot.error}',
// //                               );
// //                               return Center(
// //                                 child: Text('Error: ${snapshot.error}'),
// //                               );
// //                             }
// //                             if (!snapshot.hasData) {
// //                               return Center(child: CircularProgressIndicator());
// //                             }
// //                             final requests = snapshot.data!.docs;
// //                             if (requests.isEmpty) {
// //                               return Center(
// //                                 child: Text('No pending team requests'),
// //                               );
// //                             }
// //                             return ListView.builder(
// //                               padding: EdgeInsets.all(8.0),
// //                               itemCount: requests.length,
// //                               itemBuilder: (context, index) {
// //                                 if (index >= 3) return SizedBox.shrink();
// //                                 final requestData =
// //                                     requests[index].data() as Map<String, dynamic>;
// //                                 final requestId = requests[index].id;
// //                                 final teamName =
// //                                     requestData['teamName'] ?? 'Unnamed Team';
// //                                 return Container(
// //                                   margin: EdgeInsets.only(bottom: 8),
// //                                   padding: EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.blue[100],
// //                                     borderRadius: BorderRadius.circular(8),
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       Text(
// //                                         '$teamName',
// //                                         style: TextStyle(fontSize: 18),
// //                                       ),
// //                                       Row(
// //                                         children: [
// //                                           TextButton(
// //                                             onPressed: () => _handleRequest(
// //                                               requestId,
// //                                               requestData['teamId'],
// //                                               'accept',
// //                                             ),
// //                                             child: Text(
// //                                               'Accept',
// //                                               style: TextStyle(
// //                                                 fontSize: 16,
// //                                                 color: Colors.green[600],
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           TextButton(
// //                                             onPressed: () => _handleRequest(
// //                                               requestId,
// //                                               requestData['teamId'],
// //                                               'decline',
// //                                             ),
// //                                             child: Text(
// //                                               'Decline',
// //                                               style: TextStyle(
// //                                                 fontSize: 16,
// //                                                 color: Colors.red[600],
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 );
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                       SizedBox(height: 20),
// //                       Text(
// //                         'Other Notifications',
// //                         style: TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       SizedBox(height: 10),
// //                       Container(
// //                         decoration: BoxDecoration(
// //                           border: Border.all(color: Colors.grey[300]!),
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: ListView(
// //                           shrinkWrap: true,
// //                           physics: NeverScrollableScrollPhysics(),
// //                           padding: EdgeInsets.all(8.0),
// //                           children: [
// //                             Container(
// //                               margin: EdgeInsets.only(bottom: 8),
// //                               padding: EdgeInsets.all(12),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.grey[200],
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                               child: Text(
// //                                 'Notification 1: Sample notification',
// //                                 style: TextStyle(fontSize: 16),
// //                               ),
// //                             ),
// //                             Container(
// //                               margin: EdgeInsets.only(bottom: 8),
// //                               padding: EdgeInsets.all(12),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.grey[200],
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                               child: Text(
// //                                 'Notification 2: Another sample',
// //                                 style: TextStyle(fontSize: 16),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(8.0),
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Notification 1: Sample notification',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Notification 2: Another sample',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
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