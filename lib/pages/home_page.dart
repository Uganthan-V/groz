// // // import 'package:flutter/material.dart';
// // // import '../widgets/greet.dart'; // Adjust the import path based on your project structure

// // // class HomePage extends StatelessWidget {
// // //   const HomePage({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
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
// // //               GreetWidget(), // Call the greet contents here
// // //               Expanded(
// // //                 child: ListView(
// // //                   children: [
// // //                     // Scrollable List
// // //                     Column(
// // //                       children: [
// // //                         Text( 
// // //                           'Recommendations',
// // //                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          
// // //                         ),
// // //                         Container(
// // //                           height: 350,
// // //                           child: ListView.builder(
// // //                             shrinkWrap: true,
// // //                             physics: BouncingScrollPhysics(),
// // //                             itemCount: 50,
// // //                             itemBuilder: (context, index) {
// // //                               return ListTile(title: Text('Item $index'));
// // //                             },
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import '../widgets/greet.dart';

// // // // class HomePage extends StatelessWidget {
// // // //   const HomePage({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final user = FirebaseAuth.instance.currentUser;
// // // //     final screenHeight = MediaQuery.of(context).size.height;

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
// // // //           child: ListView(
// // // //             children: [
// // // //               GreetWidget(),
// // // //               SizedBox(height: 20),
// // // //               Expanded(
// // // //                 flex: 1,
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Padding(
// // // //                       padding: EdgeInsets.all(8.0),
// // // //                       child: Text(
// // // //                         'Recommendations',
// // // //                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //                       ),
// // // //                     ),
// // // //                     Container(
// // // //                       height: screenHeight * 0.45,
// // // //                       decoration: BoxDecoration(
// // // //                         border: Border.all(color: Colors.grey[300]!),
// // // //                         borderRadius: BorderRadius.circular(10),
// // // //                       ),
// // // //                       child: StreamBuilder<QuerySnapshot>(
// // // //                         stream: FirebaseFirestore.instance
// // // //                             .collectionGroup('recommendations')
// // // //                             .where('teamId', whereIn: [
// // // //                               user?.uid,
// // // //                               ...FirebaseFirestore.instance
// // // //                                   .collection('users')
// // // //                                   .doc(user?.uid)
// // // //                                   .collection('current_teams')
// // // //                                   .snapshots()
// // // //                                   .map((snapshot) => snapshot.docs.map((doc) => doc.id))
// // // //                                   .first
// // // //                             ])
// // // //                             .snapshots(),
// // // //                         builder: (context, snapshot) {
// // // //                           if (!snapshot.hasData) return CircularProgressIndicator();
// // // //                           final recommendations = snapshot.data!.docs;

// // // //                           if (recommendations.isEmpty) {
// // // //                             return Center(child: Text('No recommendations available'));
// // // //                           }

// // // //                           return ListView.builder(
// // // //                             scrollDirection: Axis.horizontal,
// // // //                             padding: EdgeInsets.all(8.0),
// // // //                             itemCount: recommendations.length,
// // // //                             itemBuilder: (context, index) {
// // // //                               final rec = recommendations[index];
// // // //                               final itemName = rec['item_name'] ?? '';
// // // //                               String quantity = rec['quantity']?.toString() ?? '1';
// // // //                               final teamId = rec['teamId'];
// // // //                               final teamName = teamId == user?.uid
// // // //                                   ? 'Self'
// // // //                                   : (FirebaseFirestore.instance
// // // //                                           .collection('teams')
// // // //                                           .doc(teamId)
// // // //                                           .get()
// // // //                                           .then((doc) => doc['name'] ?? 'Unnamed Team') ??
// // // //                                       'Unnamed Team');

// // // //                               return Dismissible(
// // // //                                 key: Key(rec.id),
// // // //                                 direction: DismissDirection.endToStart,
// // // //                                 onDismissed: (_) async {
// // // //                                   await FirebaseFirestore.instance
// // // //                                       .collection('teams')
// // // //                                       .doc(teamId)
// // // //                                       .collection('recommendations')
// // // //                                       .doc(rec.id)
// // // //                                       .delete();
// // // //                                 },
// // // //                                 child: Container(
// // // //                                   width: 200,
// // // //                                   margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
// // // //                                   padding: EdgeInsets.all(8.0),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: Colors.white,
// // // //                                     borderRadius: BorderRadius.circular(10),
// // // //                                     boxShadow: [
// // // //                                       BoxShadow(
// // // //                                         color: Colors.grey.withOpacity(0.3),
// // // //                                         spreadRadius: 2,
// // // //                                         blurRadius: 5,
// // // //                                         offset: Offset(0, 3),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                   child: Column(
// // // //                                     mainAxisAlignment: MainAxisAlignment.center,
// // // //                                     children: [
// // // //                                       Text(
// // // //                                         itemName,
// // // //                                         style: TextStyle(fontSize: 16),
// // // //                                         textAlign: TextAlign.center,
// // // //                                       ),
// // // //                                       Text(
// // // //                                         'Recommended for $teamName',
// // // //                                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // // //                                         textAlign: TextAlign.center,
// // // //                                       ),
// // // //                                       Text(
// // // //                                         'Qty: $quantity',
// // // //                                         style: TextStyle(fontSize: 14),
// // // //                                       ),
// // // //                                       Row(
// // // //                                         mainAxisAlignment: MainAxisAlignment.center,
// // // //                                         children: [
// // // //                                           IconButton(
// // // //                                             icon: Icon(Icons.remove),
// // // //                                             onPressed: () {
// // // //                                               if (int.parse(quantity) > 1) {
// // // //                                                 FirebaseFirestore.instance
// // // //                                                     .collection('teams')
// // // //                                                     .doc(teamId)
// // // //                                                     .collection('recommendations')
// // // //                                                     .doc(rec.id)
// // // //                                                     .update({'quantity': int.parse(quantity) - 1});
// // // //                                               }
// // // //                                             },
// // // //                                           ),
// // // //                                           IconButton(
// // // //                                             icon: Icon(Icons.add),
// // // //                                             onPressed: () {
// // // //                                               FirebaseFirestore.instance
// // // //                                                   .collection('teams')
// // // //                                                   .doc(teamId)
// // // //                                                   .collection('recommendations')
// // // //                                                   .doc(rec.id)
// // // //                                                   .update({'quantity': int.parse(quantity) + 1});
// // // //                                             },
// // // //                                           ),
// // // //                                           IconButton(
// // // //                                             icon: Icon(Icons.add_shopping_cart),
// // // //                                             onPressed: () async {
// // // //                                               await FirebaseFirestore.instance
// // // //                                                   .collection('teams')
// // // //                                                   .doc(teamId)
// // // //                                                   .collection('self_items')
// // // //                                                   .add({
// // // //                                                 'item_name': itemName,
// // // //                                                 'quantity': quantity,
// // // //                                                 'price': 'Rs. 299',
// // // //                                                 'is_done': false,
// // // //                                                 'add_time': FieldValue.serverTimestamp(),
// // // //                                                 'checked_by': null,
// // // //                                               });
// // // //                                               await FirebaseFirestore.instance
// // // //                                                   .collection('teams')
// // // //                                                   .doc(teamId)
// // // //                                                   .collection('recommendations')
// // // //                                                   .doc(rec.id)
// // // //                                                   .delete();
// // // //                                             },
// // // //                                           ),
// // // //                                         ],
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                               );
// // // //                             },
// // // //                           );
// // // //                         },
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               SizedBox(height: 20), // Placeholder for remaining space
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // void main() async {
// // //   runApp(MaterialApp(
// // //     home: HomePage(),
// // //   ));
// // // }

// // import 'package:flutter/material.dart';
// // import '../widgets/greet.dart'; // Adjust the import path based on your project structure



// // class HomePage extends StatelessWidget {
// //   const HomePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: ListView(
// //             children: [
// //               GreetWidget(), // Display greeting widget
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   'Recommendations',
// //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               // Scrollable List of Items
// //               Container(
// //                 height: 350,
// //                 child: ListView.builder(
// //                   shrinkWrap: true,
// //                   physics: BouncingScrollPhysics(),
// //                   itemCount: 50,
// //                   itemBuilder: (context, index) {
// //                     return Container(
// //                       margin: EdgeInsets.all(8.0),
// //                       padding: EdgeInsets.all(16.0),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(10),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.grey.withOpacity(0.2),
// //                             spreadRadius: 2,
// //                             blurRadius: 5,
// //                             offset: Offset(0, 3), // changes position of shadow
// //                           ),
// //                         ],
// //                       ),
// //                       child: Text('Item ${index + 1}', style: TextStyle(fontSize: 18)),
                      
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../widgets/greet.dart';
// import '../service/handle_teams.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
//           ),
//         ),
//         child: SafeArea(
//           child: ListView(
//             children: [
//               GreetWidget(),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Recommendations',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               StreamBuilder<QuerySnapshot>(
//                 stream: _firestore.collection('recommend').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   var recommendations = snapshot.data!.docs;
//                   return Container(
//                     height: 350,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: BouncingScrollPhysics(),
//                       itemCount: recommendations.length,
//                       itemBuilder: (context, index) {
//                         var data = recommendations[index].data() as Map<String, dynamic>;
//                         var docId = recommendations[index].id;
//                         return Dismissible(
//                           key: Key(docId),
//                           direction: DismissDirection.endToStart,
//                           onDismissed: (direction) {
//                             _firestore.collection('recommend').doc(docId).delete();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('${data['item_name']} removed')),
//                             );
//                           },
//                           background: Container(
//                             color: Colors.red,
//                             alignment: Alignment.centerRight,
//                             padding: EdgeInsets.only(right: 20.0),
//                             child: Icon(Icons.delete, color: Colors.white),
//                           ),
//                           child: Container(
//                             margin: EdgeInsets.all(8.0),
//                             padding: EdgeInsets.all(16.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       data['item_name'],
//                                       style: TextStyle(fontSize: 18),
//                                     ),
//                                     Text(
//                                       'Team: ${TeamManager().getTeamName(data['team_id'])}',
//                                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: _teamData.keys.map((teamId) {
//                                     return IconButton(
//                                       icon: Icon(Icons.add, color: Colors.green),
//                                       onPressed: () {
//                                         _addToTeam(data['item_name'], '1', teamId);
//                                       },
//                                     );
//                                   }).toList(),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _addToTeam(String itemName, String quantity, String teamId) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       final userName = user?.displayName ?? user?.email ?? 'Unknown';
//       await FirebaseFirestore.instance
//           .collection('teams')
//           .doc(teamId)
//           .collection('self_items')
//           .add({
//         'add_time': Timestamp.now(),
//         'assigned_by': userName,
//         'bought_by': userName,
//         'edit_time': null,
//         'is_done': false,
//         'is_edited': false,
//         'item_name': itemName,
//         'price': 'Rs. 299',
//         'quantity': quantity,
//         'checked_by': null,
//       });
//       print('[DEBUG] Item added to team $teamId');
//     } catch (e) {
//       print('[ERROR] Error adding item to team: $e');
//     }
//   }

//   Map<String, String> get _teamData {
//     return TeamManager().teamData.map((key, value) => MapEntry(key, value['name']));
//   }
// }

// // Assume TeamManager has a method to get team name
// extension TeamManagerExtension on TeamManager {
//   String getTeamName(String teamId) {
//     return teamData[teamId]?['name'] ?? 'Unknown Team';
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/greet.dart';
import '../service/handle_teams.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TeamManager _teamManager = TeamManager();
  int _quantity = 1; // Default quantity

  @override
  void initState() {
    super.initState();
    _teamManager.updateTeamData(_teamManager.currentTeamId ?? ''); // Use public method
  }

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
          child: ListView(
            children: [
              GreetWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Recommendations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('recommend').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var recommendations = snapshot.data!.docs;
                  return Container(
                    height: 350,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        var data = recommendations[index].data() as Map<String, dynamic>;
                        var docId = recommendations[index].id;
                        return Dismissible(
                          key: Key(docId),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _firestore.collection('recommend').doc(docId).delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${data['item_name']} removed')),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['item_name'],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Team: ${TeamManager().getTeamName(data['team_id'])}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.red),
                                      onPressed: _quantity > 1
                                          ? () => setState(() => _quantity--)
                                          : null,
                                    ),
                                    Text('$_quantity', style: TextStyle(fontSize: 18)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.green),
                                      onPressed: () => setState(() => _quantity++),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_shopping_cart, color: Colors.blue),
                                      onPressed: () {
                                        _addToTeam(data['item_name'], _quantity.toString(), _teamManager.currentTeamId ?? '');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
    );
  }

  Future<void> _addToTeam(String itemName, String quantity, String teamId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userName = user?.displayName ?? user?.email ?? 'Unknown';
      await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .collection('self_items')
          .add({
        'add_time': Timestamp.now(),
        'assigned_by': userName,
        'bought_by': userName,
        'edit_time': null,
        'is_done': false,
        'is_edited': false,
        'item_name': itemName,
        'price': 'Rs. 299',
        'quantity': quantity,
        'checked_by': null,
      });
      print('[DEBUG] Item added to team $teamId with quantity $quantity');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$itemName (x$quantity) added to ${TeamManager().getTeamName(teamId)}')),
      );
    } catch (e) {
      print('[ERROR] Error adding item to team: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding item: $e')),
      );
    }
  }
}