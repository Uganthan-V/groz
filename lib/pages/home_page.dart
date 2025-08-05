import 'package:flutter/material.dart';
import '../widgets/greet.dart'; // Adjust the import path based on your project structure

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              GreetWidget(), // Call the greet contents here
              Expanded(child: Center(child: Text('Homeeeeeeeeeee Page'))),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import '../widgets/greet.dart'; // Adjust the import path based on your project structure

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
//               ),
//             ),
//             child:
//       Column(
//         children: [
//           GreetWidget(), // Call the greet contents here
//           Expanded(
//             child: 
//             Center(
              
//               child: Text('Home Page'),
//             ),
//           ),
//         ],
//       ),),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../widgets/greet.dart';

// // class HomePage extends StatelessWidget {
// //   const HomePage({super.key});

// //   void _handleRequest(String requestId, String teamId, String action) async {
// //     try {
// //       if (action == 'accept') {
// //         final user = FirebaseAuth.instance.currentUser;
// //         if (user != null) {
// //           await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
// //             'members': FieldValue.arrayUnion([user.uid]),
// //           });
// //           await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// //             'status': 'accepted',
// //           });
// //         }
// //       } else {
// //         await FirebaseFirestore.instance.collection('team_requests').doc(requestId).update({
// //           'status': 'declined',
// //         });
// //       }
// //     } catch (e) {
// //       print('Error handling request: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;

// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           GreetWidget(),
// //           Expanded(
// //             child: StreamBuilder<QuerySnapshot>(
// //               stream: FirebaseFirestore.instance
// //                   .collection('team_requests')
// //                   .where('userId', isEqualTo: user?.uid ?? '')
// //                   .where('status', isEqualTo: 'pending')
// //                   .snapshots(),
// //               builder: (context, snapshot) {
// //                 if (snapshot.hasError) {
// //                   print('Error loading requests: ${snapshot.error}');
// //                   return Center(child: Text('Error: ${snapshot.error}'));
// //                 }
// //                 if (!snapshot.hasData) {
// //                   return Center(child: CircularProgressIndicator());
// //                 }
// //                 final requests = snapshot.data!.docs;
// //                 if (requests.isEmpty) {
// //                   return Center(child: Text('No pending team requests'));
// //                 }
// //                 return ListView.builder(
// //                   itemCount: requests.length,
// //                   itemBuilder: (context, index) {
// //                     final requestData = requests[index].data() as Map<String, dynamic>;
// //                     final requestId = requests[index].id;
// //                     final teamName = requestData['teamName'] ?? 'Unnamed Team';
// //                     return Container(
// //                       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //                       padding: EdgeInsets.all(16),
// //                       decoration: BoxDecoration(
// //                         color: Colors.blue[100],
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text('Join request for $teamName'),
// //                           Row(
// //                             children: [
// //                               TextButton(
// //                                 onPressed: () => _handleRequest(requestId, requestData['teamId'], 'accept'),
// //                                 child: Text('Accept'),
// //                               ),
// //                               TextButton(
// //                                 onPressed: () => _handleRequest(requestId, requestData['teamId'], 'decline'),
// //                                 child: Text('Decline'),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }