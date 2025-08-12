
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../service/mic.dart';
// // import '../widgets/greet.dart';
// // import '../service/handle_teams.dart';
// // import '../pages/account_page.dart';

// // class ListingPage extends StatefulWidget {
// //   const ListingPage({super.key});

// //   @override
// //   _ListingPageState createState() => _ListingPageState();
// // }

// // class _ListingPageState extends State<ListingPage> {
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// //   final MicService _micService = MicService();
// //   bool _micActive = false;
// //   Map<String, dynamic>? _lastDeletedItem;
// //   bool _isUndoPending = false;
// //   bool _isOffline = false;
// //   List<QueryDocumentSnapshot> _cachedItems = []; // Cache for items

// //   User? get _currentUser => FirebaseAuth.instance.currentUser;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeTeamIfNeeded();
// //     _checkConnectivity();
// //   }

// //   Future<void> _initializeTeamIfNeeded() async {
// //     final teamManager = TeamManager();
// //     if (teamManager.currentTeamId.isEmpty) {
// //       final user = _currentUser;
// //       if (user != null) {
// //         final snapshot = await FirebaseFirestore.instance
// //             .collection('teams')
// //             .where('admin', isEqualTo: user.uid)
// //             .where('name', isEqualTo: 'Self')
// //             .limit(1)
// //             .get(GetOptions(source: Source.cache)); // Try cache first
// //         if (snapshot.docs.isNotEmpty) {
// //           final teamId = snapshot.docs.first.id;
// //           teamManager.setCurrentTeam(teamId, 'Self', context);
// //           setState(() {});
// //         } else {
// //           // Fall back to server if cache is empty
// //           final serverSnapshot = await FirebaseFirestore.instance
// //               .collection('teams')
// //               .where('admin', isEqualTo: user.uid)
// //               .where('name', isEqualTo: 'Self')
// //               .limit(1)
// //               .get(GetOptions(source: Source.serverAndCache));
// //           if (serverSnapshot.docs.isNotEmpty) {
// //             final teamId = serverSnapshot.docs.first.id;
// //             teamManager.setCurrentTeam(teamId, 'Self', context);
// //             setState(() {});
// //           } else if (mounted) {
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(builder: (context) => AccountPage()),
// //             );
// //           }
// //         }
// //       }
// //     }
// //   }

// //   Future<void> _checkConnectivity() async {
// //     // Simplified offline check
// //     try {
// //       await FirebaseFirestore.instance
// //           .collection('teams')
// //           .limit(1)
// //           .get(GetOptions(source: Source.server));
// //       setState(() => _isOffline = false);
// //     } catch (e) {
// //       setState(() => _isOffline = true);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final teamManager = TeamManager();
// //     final isSelfTeam = teamManager.currentTeamName == 'Self';
// //     if (teamManager.currentTeamId.isEmpty) {
// //       return Center(child: CircularProgressIndicator());
// //     }

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
// //               Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// //                 child: TextField(
// //                   decoration: InputDecoration(
// //                     hintText: 'Search',
// //                     prefixIcon: Icon(Icons.search),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 20),
// //               Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(
// //                       'Grocery List',
// //                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                     ),
// //                     StreamBuilder<QuerySnapshot>(
// //                       stream: isSelfTeam
// //                           ? FirebaseFirestore.instance
// //                               .collection('teams')
// //                               .doc(teamManager.currentTeamId)
// //                               .collection('self_items')
// //                               .snapshots()
// //                           : null,
// //                       builder: (context, snapshot) {
// //                         if (snapshot.hasError) {
// //                           print('Error loading self_items: ${snapshot.error}');
// //                           return Text('Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
// //                         }
// //                         if (snapshot.connectionState == ConnectionState.waiting && _cachedItems.isEmpty) {
// //                           return Text('Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
// //                         }
// //                         if (snapshot.hasData || _cachedItems.isNotEmpty) {
// //                           final items = snapshot.data?.docs ?? _cachedItems;
// //                           _cachedItems = items; // Update cache
// //                           final totalCost = items.fold(0.0, (sum, doc) {
// //                             final price = double.tryParse((doc.data() as Map<String, dynamic>)['price'].replaceAll('Rs. ', '')) ?? 0.0;
// //                             final quantity = int.tryParse((doc.data() as Map<String, dynamic>)['quantity']) ?? 1;
// //                             return sum + (price * quantity);
// //                           });
// //                           return Text(
// //                             'Estimated Cost: ₹${totalCost.toStringAsFixed(2)}',
// //                             style: TextStyle(fontSize: 16, color: Colors.grey),
// //                           );
// //                         }
// //                         return Text(_isOffline ? 'Offline - No cost' : 'Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               _buildAddItem(context),
// //               Expanded(
// //                 child: StreamBuilder<QuerySnapshot>(
// //                   stream: isSelfTeam
// //                       ? FirebaseFirestore.instance
// //                           .collection('teams')
// //                           .doc(teamManager.currentTeamId)
// //                           .collection('self_items')
// //                           .snapshots()
// //                       : null,
// //                   builder: (context, snapshot) {
// //                     if (snapshot.hasError) {
// //                       print('Error loading self_items: ${snapshot.error}');
// //                       return Center(child: Text('Error: ${snapshot.error}'));
// //                     }
// //                     if (snapshot.connectionState == ConnectionState.waiting && _cachedItems.isEmpty) {
// //                       return Center(child: CircularProgressIndicator());
// //                     }
// //                     if (snapshot.hasData || _cachedItems.isNotEmpty) {
// //                       final items = snapshot.data?.docs ?? _cachedItems;
// //                       _cachedItems = items; // Update cache
// //                       return ListView(
// //                         padding: EdgeInsets.all(16.0),
// //                         children: items.map((doc) {
// //                           final data = doc.data() as Map<String, dynamic>;
// //                           final docId = doc.id;
// //                           final itemName = data['item_name'] ?? '';
// //                           final quantity = data['quantity'] ?? '';
// //                           final isDone = data['is_done'] ?? false;
// //                           final addTime = data['add_time']?.toDate() ?? DateTime.now();
// //                           final isEdited = data['is_edited'] ?? false;
// //                           final assignedBy = data['assigned_by'] ?? '';
// //                           final boughtBy = data['bought_by'] ?? '';
// //                           final editTime = data['edit_time']?.toDate() ?? null;
// //                           final price = data['price'] ?? 'Rs. 0';
// //                           return _buildListItem(
// //                             docId,
// //                             itemName,
// //                             quantity,
// //                             isDone,
// //                             addTime,
// //                             isEdited,
// //                             assignedBy,
// //                             boughtBy,
// //                             editTime,
// //                             price,
// //                           );
// //                         }).toList(),
// //                       );
// //                     }
// //                     return Center(child: Text(_isOffline ? 'Offline - No data yet' : 'No items yet'));
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           try {
// //             setState(() {
// //               _micActive = !_micActive;
// //             });
// //             if (_micActive) {
// //               _micService.setListening(true);
// //               _micService.showVoiceInputDialog(context, () {
// //                 if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
// //                   _addItemToFirestore(_micService.name!, _micService.quantity!);
// //                 }
// //               }, () {
// //                 setState(() {
// //                   _micActive = false;
// //                 });
// //               });
// //             } else {
// //               _micService.setListening(false);
// //             }
// //           } catch (e) {
// //             print('MicService error: $e');
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('Error with mic service: $e')),
// //             );
// //           }
// //         },
// //         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
// //         elevation: 6.0,
// //         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
// //     );
// //   }

// //   Widget _buildAddItem(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         _showAddItemDialog(context);
// //       },
// //       child: Container(
// //         margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
// //         padding: EdgeInsets.all(10),
// //         decoration: BoxDecoration(
// //           color: Colors.blue[100],
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.add, color: Colors.blue[600]),
// //             SizedBox(width: 10),
// //             Text(
// //               'Add Item',
// //               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildListItem(
// //     String docId,
// //     String itemName,
// //     String quantity,
// //     bool isDone,
// //     DateTime addTime,
// //     bool isEdited,
// //     String assignedBy,
// //     String boughtBy,
// //     DateTime? editTime,
// //     String price,
// //   ) {
// //     final textLength = (itemName + quantity).length;
// //     final containerHeight = textLength > 20 ? 120.0 : 100.0;

// //     return Container(
// //       margin: EdgeInsets.only(bottom: 10),
// //       height: containerHeight,
// //       padding: EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: isDone ? Colors.green[200] : Colors.blue[100],
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Stack(
// //         children: [
// //           Align(
// //             alignment: Alignment.centerLeft,
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Checkbox(
// //                   value: isDone,
// //                   onChanged: (value) async {
// //                     if (value != null) {
// //                       try {
// //                         await FirebaseFirestore.instance
// //                             .collection('teams')
// //                             .doc(TeamManager().currentTeamId)
// //                             .collection('self_items')
// //                             .doc(docId)
// //                             .update({
// //                               'is_done': value,
// //                               'edit_time': Timestamp.now(),
// //                               'is_edited': true,
// //                             });
// //                       } catch (e) {
// //                         print('Error updating is_done: $e');
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text('Error updating item: $e')),
// //                         );
// //                       }
// //                     }
// //                   },
// //                 ),
// //                 Flexible(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         '$itemName - $quantity',
// //                         style: TextStyle(
// //                           decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
// //                           fontSize: 16,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(height: 4),
// //                       Text(
// //                         'Assigned by: $assignedBy',
// //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// //                       ),
// //                       Text(
// //                         'Bought by: $boughtBy',
// //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// //                       ),
// //                       if (editTime != null)
// //                         Text(
// //                           'Edited: ${editTime.toLocal()}',
// //                           style: TextStyle(fontSize: 12, color: Colors.grey),
// //                         ),
// //                       Text(
// //                         'Added: ${addTime.toLocal()}',
// //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             left: 0,
// //             right: 0,
// //             top: 10,
// //             child: Center(
// //               child: Text(
// //                 '$price',
// //                 style: TextStyle(fontSize: 14, color: Colors.black),
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             right: 10,
// //             top: 10,
// //             child: Row(
// //               children: [
// //                 if (!isDone)
// //                   IconButton(
// //                     icon: Icon(Icons.edit, size: 20),
// //                     onPressed: () {
// //                       _showEditItemDialog(context, docId, itemName, quantity, assignedBy, boughtBy, price);
// //                     },
// //                   ),
// //                 if (!isDone)
// //                   IconButton(
// //                     icon: Icon(Icons.delete, size: 20),
// //                     onPressed: () {
// //                       _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, addTime, assignedBy, boughtBy, editTime, price);
// //                     },
// //                   ),
// //               ],
// //             ),
// //           ),
// //           if (isEdited)
// //             Positioned(
// //               right: 10,
// //               top: 50,
// //               child: Container(
// //                 padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[600],
// //                   borderRadius: BorderRadius.circular(4),
// //                 ),
// //                 child: Text(
// //                   'Edited',
// //                   style: TextStyle(color: Colors.white, fontSize: 10),
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _addItemToFirestore(String itemName, String quantity) async {
// //     try {
// //       final user = _currentUser;
// //       final userName = user?.displayName ?? user?.email ?? 'rock';
// //       if (TeamManager().currentTeamName != 'Self') {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Can only add items to "Self" team')),
// //         );
// //         return;
// //       }
// //       final teamId = TeamManager().currentTeamId;
// //       await FirebaseFirestore.instance
// //           .collection('teams')
// //           .doc(teamId)
// //           .collection('self_items')
// //           .add({
// //         'add_time': Timestamp.now(),
// //         'assigned_by': userName,
// //         'bought_by': userName,
// //         'edit_time': null,
// //         'is_done': false,
// //         'is_edited': false,
// //         'item_name': itemName,
// //         'price': 'Rs. 299',
// //         'quantity': quantity,
// //       });
// //     } catch (e) {
// //       print('Error adding item to Firestore: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error adding item: $e')),
// //       );
// //     }
// //   }

// //   void _showAddItemDialog(BuildContext context) {
// //     String itemName = '';
// //     String quantity = '';

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Add New Item'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               TextField(
// //                 decoration: InputDecoration(labelText: 'Item Name'),
// //                 onChanged: (value) {
// //                   itemName = value;
// //                 },
// //               ),
// //               TextField(
// //                 decoration: InputDecoration(labelText: 'Quantity'),
// //                 onChanged: (value) {
// //                   quantity = value;
// //                 },
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 if (itemName.isNotEmpty && quantity.isNotEmpty) {
// //                   _addItemToFirestore(itemName, quantity);
// //                   Navigator.pop(context);
// //                 }
// //               },
// //               child: Text('Add'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String assignedBy, String boughtBy, String price) {
// //     String editedItemName = itemName;
// //     String editedQuantity = quantity;

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Edit Item'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               TextField(
// //                 decoration: InputDecoration(labelText: 'Item Name'),
// //                 controller: TextEditingController(text: itemName),
// //                 onChanged: (value) {
// //                   editedItemName = value;
// //                 },
// //               ),
// //               TextField(
// //                 decoration: InputDecoration(labelText: 'Quantity'),
// //                 controller: TextEditingController(text: quantity),
// //                 onChanged: (value) {
// //                   editedQuantity = value;
// //                 },
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () async {
// //                 if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
// //                   try {
// //                     await FirebaseFirestore.instance
// //                         .collection('teams')
// //                         .doc(TeamManager().currentTeamId)
// //                         .collection('self_items')
// //                         .doc(docId)
// //                         .update({
// //                           'item_name': editedItemName,
// //                           'quantity': editedQuantity,
// //                           'edit_time': Timestamp.now(),
// //                           'is_edited': true,
// //                         });
// //                     Navigator.pop(context);
// //                   } catch (e) {
// //                     print('Error editing item: $e');
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       SnackBar(content: Text('Error editing item: $e')),
// //                     );
// //                   }
// //                 }
// //               },
// //               child: Text('Save'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _deleteItemFromFirestore(
// //     BuildContext context,
// //     String docId,
// //     String itemName,
// //     String quantity,
// //     bool isDone,
// //     DateTime addTime,
// //     String assignedBy,
// //     String boughtBy,
// //     DateTime? editTime,
// //     String price,
// //   ) async {
// //     try {
// //       final deletedItem = {
// //         'docId': docId,
// //         'add_time': addTime,
// //         'assigned_by': assignedBy,
// //         'bought_by': boughtBy,
// //         'edit_time': editTime,
// //         'is_done': isDone,
// //         'is_edited': true,
// //         'item_name': itemName,
// //         'price': price,
// //         'quantity': quantity,
// //       };

// //       await FirebaseFirestore.instance
// //           .collection('teams')
// //           .doc(TeamManager().currentTeamId)
// //           .collection('self_items')
// //           .doc(docId)
// //           .delete();

// //       _lastDeletedItem = deletedItem;
// //       _isUndoPending = true;

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Item "$itemName" deleted'),
// //           action: SnackBarAction(
// //             label: 'Undo',
// //             onPressed: () async {
// //               if (_isUndoPending && _lastDeletedItem != null) {
// //                 try {
// //                   await FirebaseFirestore.instance
// //                       .collection('teams')
// //                       .doc(TeamManager().currentTeamId)
// //                       .collection('self_items')
// //                       .add(_lastDeletedItem!);
// //                   setState(() {
// //                     _isUndoPending = false;
// //                     _lastDeletedItem = null;
// //                   });
// //                 } catch (e) {
// //                   print('Error undoing delete: $e');
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(content: Text('Error undoing delete: $e')),
// //                   );
// //                 }
// //               }
// //             },
// //           ),
// //           duration: Duration(seconds: 5),
// //         ),
// //       );

// //       Future.delayed(Duration(seconds: 5), () {
// //         if (_isUndoPending && _lastDeletedItem != null) {
// //           setState(() {
// //             _isUndoPending = false;
// //             _lastDeletedItem = null;
// //           });
// //         }
// //       });
// //     } catch (e) {
// //       print('Error deleting item: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error deleting item: $e')),
// //       );
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../service/mic.dart';
// import '../widgets/greet.dart';
// import '../service/handle_teams.dart';

// class ListingPage extends StatefulWidget {
//   const ListingPage({super.key});

//   @override
//   _ListingPageState createState() => _ListingPageState();
// }

// class _ListingPageState extends State<ListingPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final MicService _micService = MicService();
//   bool _micActive = false;
//   Map<String, List<QueryDocumentSnapshot>> _teamItems = {}; // Store items per team
//   String? _expandedTeamId; // Track the currently expanded team
//   bool _isLoading = true;
//   final User? _currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllTeamData();
//   }

//   Future<void> _fetchAllTeamData() async {
//     final user = _currentUser;
//     if (user == null) {
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('current_teams')
//           .get();
//       final teamIds = snapshot.docs.map((doc) => doc.id).toList();
//       final teamData = <String, List<QueryDocumentSnapshot>>{};
//       for (final teamId in teamIds) {
//         final itemsSnapshot = await FirebaseFirestore.instance
//             .collection('teams')
//             .doc(teamId)
//             .collection('self_items')
//             .get();
//         teamData[teamId] = itemsSnapshot.docs;
//       }
//       setState(() {
//         _teamItems = teamData;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching team data: $e');
//       setState(() => _isLoading = false);
//     }
//   }

//   void _toggleTeamExpansion(String teamId, String teamName) {
//     setState(() {
//       if (_expandedTeamId == teamId) {
//         _expandedTeamId = null; // Collapse if already expanded
//       } else {
//         _expandedTeamId = teamId; // Expand new team
//         // Optionally set current team for context (if needed by functions)
//         TeamManager().setCurrentTeam(teamId, teamName, context);
//       }
//     });
//   }

//   Widget _buildAddItem(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _showAddItemDialog(context);
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.blue[100],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.add, color: Colors.blue[600]),
//             SizedBox(width: 10),
//             Text(
//               'Add Item',
//               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildListItem(
//     String docId,
//     String itemName,
//     String quantity,
//     bool isDone,
//     DateTime addTime,
//     bool isEdited,
//     String assignedBy,
//     String boughtBy,
//     DateTime? editTime,
//     String price,
//   ) {
//     final textLength = (itemName + quantity).length;
//     final containerHeight = textLength > 20 ? 120.0 : 100.0;

//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       height: containerHeight,
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: isDone ? Colors.green[200] : Colors.blue[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Checkbox(
//                   value: isDone,
//                   onChanged: (value) async {
//                     if (value != null) {
//                       try {
//                         await FirebaseFirestore.instance
//                             .collection('teams')
//                             .doc(TeamManager().currentTeamId)
//                             .collection('self_items')
//                             .doc(docId)
//                             .update({
//                               'is_done': value,
//                               'edit_time': Timestamp.now(),
//                               'is_edited': true,
//                             });
//                       } catch (e) {
//                         print('Error updating is_done: $e');
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Error updating item: $e')),
//                         );
//                       }
//                     }
//                   },
//                 ),
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '$itemName - $quantity',
//                         style: TextStyle(
//                           decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
//                           fontSize: 16,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Assigned by: $assignedBy',
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       Text(
//                         'Bought by: $boughtBy',
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       if (editTime != null)
//                         Text(
//                           'Edited: ${editTime.toLocal()}',
//                           style: TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
//                       Text(
//                         'Added: ${addTime.toLocal()}',
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 10,
//             child: Center(
//               child: Text(
//                 '$price',
//                 style: TextStyle(fontSize: 14, color: Colors.black),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 10,
//             child: Row(
//               children: [
//                 if (!isDone)
//                   IconButton(
//                     icon: Icon(Icons.edit, size: 20),
//                     onPressed: () {
//                       _showEditItemDialog(context, docId, itemName, quantity, assignedBy, boughtBy, price);
//                     },
//                   ),
//                 if (!isDone)
//                   IconButton(
//                     icon: Icon(Icons.delete, size: 20),
//                     onPressed: () {
//                       _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, addTime, assignedBy, boughtBy, editTime, price);
//                     },
//                   ),
//               ],
//             ),
//           ),
//           if (isEdited)
//             Positioned(
//               right: 10,
//               top: 50,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[600],
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   'Edited',
//                   style: TextStyle(color: Colors.white, fontSize: 10),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   void _addItemToFirestore(String itemName, String quantity) async {
//     try {
//       final user = _currentUser;
//       final userName = user?.displayName ?? user?.email ?? 'rock';
//       if (TeamManager().currentTeamName != 'Self') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Can only add items to "Self" team')),
//         );
//         return;
//       }
//       final teamId = TeamManager().currentTeamId;
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
//       });
//       _fetchAllTeamData(); // Refresh data
//     } catch (e) {
//       print('Error adding item to Firestore: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error adding item: $e')),
//       );
//     }
//   }

//   void _showAddItemDialog(BuildContext context) {
//     String itemName = '';
//     String quantity = '';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add New Item'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Item Name'),
//                 onChanged: (value) {
//                   itemName = value;
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Quantity'),
//                 onChanged: (value) {
//                   quantity = value;
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (itemName.isNotEmpty && quantity.isNotEmpty) {
//                   _addItemToFirestore(itemName, quantity);
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String assignedBy, String boughtBy, String price) {
//     String editedItemName = itemName;
//     String editedQuantity = quantity;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Item'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Item Name'),
//                 controller: TextEditingController(text: itemName),
//                 onChanged: (value) {
//                   editedItemName = value;
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Quantity'),
//                 controller: TextEditingController(text: quantity),
//                 onChanged: (value) {
//                   editedQuantity = value;
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
//                   try {
//                     await FirebaseFirestore.instance
//                         .collection('teams')
//                         .doc(TeamManager().currentTeamId)
//                         .collection('self_items')
//                         .doc(docId)
//                         .update({
//                           'item_name': editedItemName,
//                           'quantity': editedQuantity,
//                           'edit_time': Timestamp.now(),
//                           'is_edited': true,
//                         });
//                     Navigator.pop(context);
//                     _fetchAllTeamData(); // Refresh data
//                   } catch (e) {
//                     print('Error editing item: $e');
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Error editing item: $e')),
//                     );
//                   }
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteItemFromFirestore(
//     BuildContext context,
//     String docId,
//     String itemName,
//     String quantity,
//     bool isDone,
//     DateTime addTime,
//     String assignedBy,
//     String boughtBy,
//     DateTime? editTime,
//     String price,
//   ) async {
//     try {
//       final deletedItem = {
//         'docId': docId,
//         'add_time': addTime,
//         'assigned_by': assignedBy,
//         'bought_by': boughtBy,
//         'edit_time': editTime,
//         'is_done': isDone,
//         'is_edited': true,
//         'item_name': itemName,
//         'price': price,
//         'quantity': quantity,
//       };

//       await FirebaseFirestore.instance
//           .collection('teams')
//           .doc(TeamManager().currentTeamId)
//           .collection('self_items')
//           .doc(docId)
//           .delete();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Item "$itemName" deleted'),
//           action: SnackBarAction(
//             label: 'Undo',
//             onPressed: () async {
//               try {
//                 await FirebaseFirestore.instance
//                     .collection('teams')
//                     .doc(TeamManager().currentTeamId)
//                     .collection('self_items')
//                     .add(deletedItem);
//                 _fetchAllTeamData(); // Refresh data
//               } catch (e) {
//                 print('Error undoing delete: $e');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error undoing delete: $e')),
//                 );
//               }
//             },
//           ),
//           duration: Duration(seconds: 5),
//         ),
//       );
//       _fetchAllTeamData(); // Refresh data
//     } catch (e) {
//       print('Error deleting item: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting item: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
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
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: _isLoading
//                     ? Center(child: CircularProgressIndicator())
//                     : ListView.builder(
//                         padding: EdgeInsets.all(16.0),
//                         itemCount: _teamItems.length,
//                         itemBuilder: (context, index) {
//                           final teamId = _teamItems.keys.elementAt(index);
//                           final items = _teamItems[teamId] ?? [];
//                           final teamName = items.isNotEmpty
//                               ? (items.first.data() as Map<String, dynamic>)['name'] ?? 'Unnamed Team'
//                               : 'Unnamed Team';
//                           return Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: () => _toggleTeamExpansion(teamId, teamName),
//                                 child: Container(
//                                   padding: EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.3),
//                                         spreadRadius: 2,
//                                         blurRadius: 5,
//                                         offset: Offset(0, 3),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         teamName,
//                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                       ),
//                                       Icon(
//                                         _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               AnimatedSize(
//                                 duration: Duration(milliseconds: 300),
//                                 curve: Curves.easeInOut,
//                                 child: _expandedTeamId == teamId
//                                     ? Container(
//                                         padding: EdgeInsets.all(16),
//                                         child: Column(
//                                           children: [
//                                             _buildAddItem(context),
//                                             Column(
//                                               children: items.map<Widget>((doc) {
//                                                 final data = doc.data() as Map<String, dynamic>;
//                                                 final docId = doc.id;
//                                                 final itemName = data['item_name'] ?? '';
//                                                 final quantity = data['quantity'] ?? '';
//                                                 final isDone = data['is_done'] ?? false;
//                                                 final addTime = data['add_time']?.toDate() ?? DateTime.now();
//                                                 final isEdited = data['is_edited'] ?? false;
//                                                 final assignedBy = data['assigned_by'] ?? '';
//                                                 final boughtBy = data['bought_by'] ?? '';
//                                                 final editTime = data['edit_time']?.toDate() ?? null;
//                                                 final price = data['price'] ?? 'Rs. 0';
//                                                 return _buildListItem(
//                                                   docId,
//                                                   itemName,
//                                                   quantity,
//                                                   isDone,
//                                                   addTime,
//                                                   isEdited,
//                                                   assignedBy,
//                                                   boughtBy,
//                                                   editTime,
//                                                   price,
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : SizedBox.shrink(),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             setState(() {
//               _micActive = !_micActive;
//             });
//             if (_micActive) {
//               _micService.setListening(true);
//               _micService.showVoiceInputDialog(context, () {
//                 if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
//                   _addItemToFirestore(_micService.name!, _micService.quantity!);
//                 }
//               }, () {
//                 setState(() {
//                   _micActive = false;
//                 });
//               });
//             } else {
//               _micService.setListening(false);
//             }
//           } catch (e) {
//             print('MicService error: $e');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error with mic service: $e')),
//             );
//           }
//         },
//         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
//         elevation: 6.0,
//         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/mic.dart';
import '../widgets/greet.dart';
import '../service/handle_teams.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MicService _micService = MicService();
  bool _micActive = false;
  Map<String, Map<String, dynamic>> _teamData = {}; // Store team data (id, name, isSelf)
  Map<String, List<QueryDocumentSnapshot>> _teamItems = {}; // Store items per team
  String? _expandedTeamId; // Track the currently expanded team
  bool _isLoading = true;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchAllTeamData();
  }

  Future<void> _fetchAllTeamData() async {
    final user = _currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      // Fetch teams from current_teams
      final currentTeamsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('current_teams')
          .get();

      final teamData = <String, Map<String, dynamic>>{};
      final teamItems = <String, List<QueryDocumentSnapshot>>{};

      // Process current_teams
      for (final doc in currentTeamsSnapshot.docs) {
        final data = doc.data();
        teamData[doc.id] = {
          'teamId': doc.id,
          'name': data['name'] ?? 'Unnamed Team',
          'isSelf': false,
        };
      }

      // Check for "Self" team if not in current_teams
      final selfTeamSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('admin', isEqualTo: user.uid)
          .where('isSelf', isEqualTo: true)
          .get();

      if (selfTeamSnapshot.docs.isNotEmpty) {
        final selfTeam = selfTeamSnapshot.docs.first;
        final selfTeamId = selfTeam.id;
        if (!teamData.containsKey(selfTeamId)) {
          teamData[selfTeamId] = {
            'teamId': selfTeamId,
            'name': selfTeam['name'] ?? 'Self',
            'isSelf': true,
          };
        }
      }

      // Fetch items for each team
      for (final teamId in teamData.keys) {
        final itemsSnapshot = await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .collection('self_items')
            .get();
        teamItems[teamId] = itemsSnapshot.docs;
      }

      setState(() {
        _teamData = teamData;
        _teamItems = teamItems;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching team data: $e');
      setState(() => _isLoading = false);
    }
  }

  void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
    setState(() {
      if (_expandedTeamId == teamId) {
        _expandedTeamId = null; // Collapse if already expanded
      } else {
        _expandedTeamId = teamId; // Expand new team
        TeamManager().setCurrentTeam(teamId, teamName, context);
      }
    });
  }

  Widget _buildAddItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddItemDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.blue[600]),
            SizedBox(width: 10),
            Text(
              'Add Item',
              style: TextStyle(fontSize: 16, color: Colors.blue[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    String docId,
    String itemName,
    String quantity,
    bool isDone,
    String price,
  ) {
    final textLength = (itemName + quantity).length;
    final containerHeight = textLength > 20 ? 80.0 : 60.0;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: containerHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDone ? Colors.green[200] : Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isDone,
                  onChanged: (value) async {
                    if (value != null) {
                      try {
                        await FirebaseFirestore.instance
                            .collection('teams')
                            .doc(TeamManager().currentTeamId)
                            .collection('self_items')
                            .doc(docId)
                            .update({
                              'is_done': value,
                              'edit_time': Timestamp.now(),
                              'is_edited': true,
                            });
                        _fetchAllTeamData(); // Refresh data
                      } catch (e) {
                        print('Error updating is_done: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error updating item: $e')),
                        );
                      }
                    }
                  },
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$itemName - $quantity',
                        style: TextStyle(
                          decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            child: Center(
              child: Text(
                '$price',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Row(
              children: [
                if (!isDone)
                  IconButton(
                    icon: Icon(Icons.edit, size: 20),
                    onPressed: () {
                      _showEditItemDialog(context, docId, itemName, quantity, price);
                    },
                  ),
                if (!isDone)
                  IconButton(
                    icon: Icon(Icons.delete, size: 20),
                    onPressed: () {
                      _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addItemToFirestore(String itemName, String quantity) async {
    try {
      final user = _currentUser;
      final userName = user?.displayName ?? user?.email ?? 'Unknown';
      final teamId = TeamManager().currentTeamId;
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
      });
      _fetchAllTeamData(); // Refresh data
    } catch (e) {
      print('Error adding item to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding item: $e')),
      );
    }
  }

  void _showAddItemDialog(BuildContext context) {
    String itemName = '';
    String quantity = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Item Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                onChanged: (value) {
                  quantity = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (itemName.isNotEmpty && quantity.isNotEmpty) {
                  _addItemToFirestore(itemName, quantity);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
    String editedItemName = itemName;
    String editedQuantity = quantity;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Item Name'),
                controller: TextEditingController(text: itemName),
                onChanged: (value) {
                  editedItemName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                controller: TextEditingController(text: quantity),
                onChanged: (value) {
                  editedQuantity = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance
                        .collection('teams')
                        .doc(TeamManager().currentTeamId)
                        .collection('self_items')
                        .doc(docId)
                        .update({
                          'item_name': editedItemName,
                          'quantity': editedQuantity,
                          'edit_time': Timestamp.now(),
                          'is_edited': true,
                        });
                    Navigator.pop(context);
                    _fetchAllTeamData(); // Refresh data
                  } catch (e) {
                    print('Error editing item: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error editing item: $e')),
                    );
                  }
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItemFromFirestore(
    BuildContext context,
    String docId,
    String itemName,
    String quantity,
    bool isDone,
    String price,
  ) async {
    try {
      final deletedItem = {
        'add_time': Timestamp.now(),
        'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
        'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
        'edit_time': null,
        'is_done': isDone,
        'is_edited': false,
        'item_name': itemName,
        'price': price,
        'quantity': quantity,
      };

      await FirebaseFirestore.instance
          .collection('teams')
          .doc(TeamManager().currentTeamId)
          .collection('self_items')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item "$itemName" deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('teams')
                    .doc(TeamManager().currentTeamId)
                    .collection('self_items')
                    .add(deletedItem);
                _fetchAllTeamData(); // Refresh data
              } catch (e) {
                print('Error undoing delete: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error undoing delete: $e')),
                );
              }
            },
          ),
          duration: Duration(seconds: 5),
        ),
      );
      _fetchAllTeamData(); // Refresh data
    } catch (e) {
      print('Error deleting item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _teamData.isEmpty
                        ? Center(child: Text('No gatherings yet'))
                        : ListView.builder(
                            padding: EdgeInsets.all(16.0),
                            itemCount: _teamData.length,
                            itemBuilder: (context, index) {
                              final teamId = _teamData.keys.elementAt(index);
                              final team = _teamData[teamId]!;
                              final teamName = team['name'] as String;
                              final isSelf = team['isSelf'] as bool;
                              final items = _teamItems[teamId] ?? [];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            teamName,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: _expandedTeamId == teamId
                                        ? Container(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              children: [
                                                _buildAddItem(context),
                                                Column(
                                                  children: items.map<Widget>((doc) {
                                                    final data = doc.data() as Map<String, dynamic>;
                                                    final docId = doc.id;
                                                    final itemName = data['item_name'] ?? '';
                                                    final quantity = data['quantity'] ?? '';
                                                    final isDone = data['is_done'] ?? false;
                                                    final price = data['price'] ?? 'Rs. 0';
                                                    return _buildListItem(
                                                      docId,
                                                      itemName,
                                                      quantity,
                                                      isDone,
                                                      price,
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                  SizedBox(height: 16), // Add spacing between teams
                                ],
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            setState(() {
              _micActive = !_micActive;
            });
            if (_micActive) {
              _micService.setListening(true);
              _micService.showVoiceInputDialog(context, () {
                if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
                  _addItemToFirestore(_micService.name!, _micService.quantity!);
                }
              }, () {
                setState(() {
                  _micActive = false;
                });
              });
            } else {
              _micService.setListening(false);
            }
          } catch (e) {
            print('MicService error: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error with mic service: $e')),
            );
          }
        },
        backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
        elevation: 6.0,
        child: Icon(_micActive ? Icons.mic_off : Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}