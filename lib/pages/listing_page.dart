

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import '../service/mic.dart'; // Import the new mic service
// // // // // import '../widgets/greet.dart'; // Import the new greet widget

// // // // // class ListingPage extends StatefulWidget {
// // // // //   const ListingPage({super.key});

// // // // //   @override
// // // // //   _ListingPageState createState() => _ListingPageState();
// // // // // }
// // // // // class _ListingPageState extends State<ListingPage> {
// // // // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// // // // //   final MicService _micService = MicService();
// // // // //   bool _micActive = false;
// // // // //   Map<String, dynamic>? _lastDeletedItem;
// // // // //   bool _isUndoPending = false;

// // // // //   // Get current user for assigned_by and bought_by
// // // // //   User? get _currentUser => FirebaseAuth.instance.currentUser;

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       key: _scaffoldKey,
// // // // //       body: Container(
// // // // //         decoration: BoxDecoration(
// // // // //           color: Colors.blue[50],
// // // // //         ),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             GreetWidget(), // Use the new greet widget
// // // // //             Padding(
// // // // //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // // //               child: TextField(
// // // // //                 decoration: InputDecoration(
// // // // //                   hintText: 'Search',
// // // // //                   prefixIcon: Icon(Icons.search),
// // // // //                   filled: true,
// // // // //                   fillColor: Colors.white,
// // // // //                   border: OutlineInputBorder(
// // // // //                     borderRadius: BorderRadius.circular(10),
// // // // //                     borderSide: BorderSide.none,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 20),
// // // // //             Padding(
// // // // //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // //                 stream: FirebaseFirestore.instance.collection('items').snapshots(),
// // // // //                 builder: (context, snapshot) {
// // // // //                   if (!snapshot.hasData) {
// // // // //                     return Center(child: CircularProgressIndicator());
// // // // //                   }
// // // // //                   final items = snapshot.data!.docs;
// // // // //                   final totalCost = items.length * 30; // Approx cost calculation
// // // // //                   return Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Text(
// // // // //                         'Grocery List',
// // // // //                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // // //                       ),
// // // // //                       Text(
// // // // //                         'Estimated Cost: ₹$totalCost',
// // // // //                         style: TextStyle(fontSize: 16, color: Colors.grey),
// // // // //                       ),
// // // // //                     ],
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //             Expanded(
// // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // //                 stream: FirebaseFirestore.instance.collection('items').snapshots(),
// // // // //                 builder: (context, snapshot) {
// // // // //                   if (!snapshot.hasData) {
// // // // //                     return Center(child: CircularProgressIndicator());
// // // // //                   }
// // // // //                   final items = snapshot.data!.docs;
// // // // //                   return ListView(
// // // // //                     padding: EdgeInsets.all(16.0),
// // // // //                     children: [
// // // // //                       _buildAddItem(context),
// // // // //                       ...items.map((doc) {
// // // // //                         final data = doc.data() as Map<String, dynamic>;
// // // // //                         return _buildListItem(
// // // // //                           doc.id,
// // // // //                           data['item_name'] ?? '',
// // // // //                           data['quantity'] ?? '',
// // // // //                           data['is_done'] ?? false,
// // // // //                           data['add_time']?.toDate() ?? DateTime.now(),
// // // // //                         );
// // // // //                       }).toList(),
// // // // //                     ],
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //       floatingActionButton: FloatingActionButton(
// // // // //         onPressed: () {
// // // // //           setState(() {
// // // // //             _micActive = !_micActive;
// // // // //           });
// // // // //           if (_micActive) {
// // // // //             _micService.setListening(true);
// // // // //             _micService.showVoiceInputDialog(context, () {
// // // // //               if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
// // // // //                 _addItemToFirestore(_micService.name!, _micService.quantity!);
// // // // //               }
// // // // //             }, () {
// // // // //               setState(() {
// // // // //                 _micActive = false;
// // // // //               });
// // // // //             });
// // // // //           } else {
// // // // //             _micService.setListening(false);
// // // // //           }
// // // // //         },
// // // // //         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
// // // // //         elevation: 6.0,
// // // // //         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
// // // // //       ),
// // // // //       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
// // // // //     );
// // // // //   }

// // // // //   Widget _buildAddItem(BuildContext context) {
// // // // //     return GestureDetector(
// // // // //       onTap: () {
// // // // //         _showAddItemDialog(context);
// // // // //       },
// // // // //       child: Container(
// // // // //         margin: EdgeInsets.only(bottom: 10),
// // // // //         padding: EdgeInsets.all(10),
// // // // //         decoration: BoxDecoration(
// // // // //           color: Colors.blue[100],
// // // // //           borderRadius: BorderRadius.circular(10),
// // // // //         ),
// // // // //         child: Row(
// // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // //           children: [
// // // // //             Icon(Icons.add, color: Colors.blue[600]),
// // // // //             SizedBox(width: 10),
// // // // //             Text(
// // // // //               'Add Item',
// // // // //               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildListItem(String docId, String itemName, String quantity, bool isDone, DateTime addTime) {
// // // // //     return Container(
// // // // //       margin: EdgeInsets.only(bottom: 10),
// // // // //       padding: EdgeInsets.all(10),
// // // // //       decoration: BoxDecoration(
// // // // //         // color: isDone ? Colors.grey[300] : Colors.blue[100],
// // // // //         color: isDone ? Colors.green[200] : Colors.blue[100],
// // // // //         borderRadius: BorderRadius.circular(10),
// // // // //       ),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           Row(
// // // // //             children: [
// // // // //               Checkbox(
// // // // //                 value: isDone,
// // // // //                 onChanged: (value) {
// // // // //                   if (value != null) {
// // // // //                     FirebaseFirestore.instance.collection('items').doc(docId).update({
// // // // //                       'is_done': value,
// // // // //                       'edit_time': Timestamp.now(),
// // // // //                       'is_edited': true,
// // // // //                     });
// // // // //                   }
// // // // //                 },
// // // // //               ),
// // // // //               Text(
// // // // //                 '$itemName - $quantity',
// // // // //                 style: TextStyle(
// // // // //                   decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           Text('Approx. ₹30'),
// // // // //           Row(
// // // // //             children: [
// // // // //               if (!isDone)
// // // // //                 IconButton(
// // // // //                   icon: Icon(Icons.edit, size: 20),
// // // // //                   onPressed: () {
// // // // //                     _showEditItemDialog(context, docId, itemName, quantity);
// // // // //                   },
// // // // //                 ),
// // // // //               if (!isDone)
// // // // //                 IconButton(
// // // // //                   icon: Icon(Icons.delete, size: 20),
// // // // //                   onPressed: () {
// // // // //                     _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, addTime);
// // // // //                   },
// // // // //                 ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _addItemToFirestore(String itemName, String quantity) {
// // // // //     final user = _currentUser;
// // // // //     final userName = user?.displayName ?? user?.email ?? 'rock'; // Fallback to 'rock' if no user info
// // // // //     FirebaseFirestore.instance.collection('items').add({
// // // // //       'add_time': Timestamp.now(),
// // // // //       'assigned_by': userName,
// // // // //       'bought_by': userName,
// // // // //       'edit_time': null,
// // // // //       'is_done': false,
// // // // //       'is_edited': false,
// // // // //       'item_name': itemName,
// // // // //       'price': 'Rs. 299', // Hardcoded for now, adjust as needed
// // // // //       'quantity': quantity,
// // // // //     });
// // // // //   }

// // // // //   void _showAddItemDialog(BuildContext context) {
// // // // //     String itemName = '';
// // // // //     String quantity = '';

// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) {
// // // // //         return AlertDialog(
// // // // //           title: Text('Add New Item'),
// // // // //           content: Column(
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             children: [
// // // // //               TextField(
// // // // //                 decoration: InputDecoration(labelText: 'Item Name'),
// // // // //                 onChanged: (value) {
// // // // //                   itemName = value;
// // // // //                 },
// // // // //               ),
// // // // //               TextField(
// // // // //                 decoration: InputDecoration(labelText: 'Quantity'),
// // // // //                 onChanged: (value) {
// // // // //                   quantity = value;
// // // // //                 },
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           actions: [
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //               child: Text('Cancel'),
// // // // //             ),
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 if (itemName.isNotEmpty && quantity.isNotEmpty) {
// // // // //                   _addItemToFirestore(itemName, quantity);
// // // // //                   Navigator.of(context).pop();
// // // // //                 }
// // // // //               },
// // // // //               child: Text('Add'),
// // // // //             ),
// // // // //           ],
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity) {
// // // // //     String editedItemName = itemName;
// // // // //     String editedQuantity = quantity;

// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) {
// // // // //         return AlertDialog(
// // // // //           title: Text('Edit Item'),
// // // // //           content: Column(
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             children: [
// // // // //               TextField(
// // // // //                 decoration: InputDecoration(labelText: 'Item Name'),
// // // // //                 controller: TextEditingController(text: itemName),
// // // // //                 onChanged: (value) {
// // // // //                   editedItemName = value;
// // // // //                 },
// // // // //               ),
// // // // //               TextField(
// // // // //                 decoration: InputDecoration(labelText: 'Quantity'),
// // // // //                 controller: TextEditingController(text: quantity),
// // // // //                 onChanged: (value) {
// // // // //                   editedQuantity = value;
// // // // //                 },
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           actions: [
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //               child: Text('Cancel'),
// // // // //             ),
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
// // // // //                   FirebaseFirestore.instance.collection('items').doc(docId).update({
// // // // //                     'item_name': editedItemName,
// // // // //                     'quantity': editedQuantity,
// // // // //                     'edit_time': Timestamp.now(),
// // // // //                     'is_edited': true,
// // // // //                   });
// // // // //                   Navigator.of(context).pop();
// // // // //                 }
// // // // //               },
// // // // //               child: Text('Save'),
// // // // //             ),
// // // // //           ],
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   void _deleteItemFromFirestore(
// // // // //       BuildContext context, String docId, String itemName, String quantity, bool isDone, DateTime addTime) {
// // // // //     final deletedItem = {
// // // // //       'docId': docId,
// // // // //       'item_name': itemName,
// // // // //       'quantity': quantity,
// // // // //       'is_done': isDone,
// // // // //       'add_time': addTime,
// // // // //       'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'rock',
// // // // //       'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'rock',
// // // // //       'edit_time': null,
// // // // //       'is_edited': false,
// // // // //       'price': 'Rs. 299',
// // // // //     };

// // // // //     FirebaseFirestore.instance.collection('items').doc(docId).delete();

// // // // //     _lastDeletedItem = deletedItem;
// // // // //     _isUndoPending = true;

// // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // //       SnackBar(
// // // // //         content: Text('Item "$itemName" deleted'),
// // // // //         action: SnackBarAction(
// // // // //           label: 'Undo',
// // // // //           onPressed: () {
// // // // //             if (_isUndoPending && _lastDeletedItem != null) {
// // // // //               FirebaseFirestore.instance.collection('items').add(_lastDeletedItem!);
// // // // //               setState(() {
// // // // //                 _isUndoPending = false;
// // // // //                 _lastDeletedItem = null;
// // // // //               });
// // // // //             }
// // // // //           },
// // // // //         ),
// // // // //         duration: Duration(seconds: 5),
// // // // //       ),
// // // // //     );

// // // // //     Future.delayed(Duration(seconds: 5), () {
// // // // //       if (_isUndoPending && _lastDeletedItem != null) {
// // // // //         setState(() {
// // // // //           _isUndoPending = false;
// // // // //           _lastDeletedItem = null;
// // // // //         });
// // // // //       }
// // // // //     });
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import '../service/mic.dart';
// // // // import '../widgets/greet.dart';

// // // // class ListingPage extends StatefulWidget {
// // // //   const ListingPage({super.key});

// // // //   @override
// // // //   _ListingPageState createState() => _ListingPageState();
// // // // }

// // // // class _ListingPageState extends State<ListingPage> {
// // // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// // // //   final MicService _micService = MicService();
// // // //   bool _micActive = false;
// // // //   Map<String, dynamic>? _lastDeletedItem;
// // // //   bool _isUndoPending = false;

// // // //   User? get _currentUser => FirebaseAuth.instance.currentUser;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       key: _scaffoldKey,
// // // //       body: Container(
// // // //         decoration: BoxDecoration(
// // // //               gradient: LinearGradient(
// // // //                 begin: Alignment.topLeft,
// // // //                 end: Alignment.bottomRight,
// // // //                 colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// // // //               ),
// // // //             ),
// // // //         child: Column(
// // // //           children: [
// // // //             GreetWidget(),
// // // //             Padding(
// // // //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // //               child: TextField(
// // // //                 decoration: InputDecoration(
// // // //                   hintText: 'Search',
// // // //                   prefixIcon: Icon(Icons.search),
// // // //                   filled: true,
// // // //                   fillColor: Colors.white,
// // // //                   border: OutlineInputBorder(
// // // //                     borderRadius: BorderRadius.circular(10),
// // // //                     borderSide: BorderSide.none,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             Padding(
// // // //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // //               child: StreamBuilder<QuerySnapshot>(
// // // //                 stream: FirebaseFirestore.instance
// // // //                     .collection('teams')
// // // //                     .where('members', arrayContains: _currentUser?.uid ?? '')
// // // //                     .snapshots(),
// // // //                 builder: (context, teamSnapshot) {
// // // //                   if (teamSnapshot.hasError) {
// // // //                     print('Error loading teams: ${teamSnapshot.error}');
// // // //                     return Center(child: Text('Error: ${teamSnapshot.error}'));
// // // //                   }
// // // //                   if (!teamSnapshot.hasData) {
// // // //                     return Center(child: CircularProgressIndicator());
// // // //                   }
// // // //                   final teamIds = teamSnapshot.data!.docs.map((doc) => doc.id).toList();
// // // //                   return StreamBuilder<QuerySnapshot>(
// // // //                     stream: teamIds.isEmpty
// // // //                         ? null
// // // //                         : FirebaseFirestore.instance
// // // //                             .collection('items')
// // // //                             .where('teamId', whereIn: teamIds)
// // // //                             .snapshots(),
// // // //                     builder: (context, snapshot) {
// // // //                       if (snapshot.hasError) {
// // // //                         print('Error loading items: ${snapshot.error}');
// // // //                         return Center(child: Text('Error: ${snapshot.error}'));
// // // //                       }
// // // //                       if (!snapshot.hasData) {
// // // //                         return Center(child: CircularProgressIndicator());
// // // //                       }
// // // //                       final items = snapshot.data!.docs;
// // // //                       final totalCost = items.length * 30;
// // // //                       return Row(
// // // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                         children: [
// // // //                           Text(
// // // //                             'Grocery List',
// // // //                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //                           ),
// // // //                           Text(
// // // //                             'Estimated Cost: ₹$totalCost',
// // // //                             style: TextStyle(fontSize: 16, color: Colors.grey),
// // // //                           ),
// // // //                         ],
// // // //                       );
// // // //                     },
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ),
// // // //             Expanded(
// // // //               child: StreamBuilder<QuerySnapshot>(
// // // //                 stream: FirebaseFirestore.instance
// // // //                     .collection('teams')
// // // //                     .where('members', arrayContains: _currentUser?.uid ?? '')
// // // //                     .snapshots(),
// // // //                 builder: (context, teamSnapshot) {
// // // //                   if (teamSnapshot.hasError) {
// // // //                     print('Error loading teams: ${teamSnapshot.error}');
// // // //                     return Center(child: Text('Error: ${teamSnapshot.error}'));
// // // //                   }
// // // //                   if (!teamSnapshot.hasData) {
// // // //                     return Center(child: CircularProgressIndicator());
// // // //                   }
// // // //                   final teamIds = teamSnapshot.data!.docs.map((doc) => doc.id).toList();
// // // //                   return StreamBuilder<QuerySnapshot>(
// // // //                     stream: teamIds.isEmpty
// // // //                         ? null
// // // //                         : FirebaseFirestore.instance
// // // //                             .collection('items')
// // // //                             .where('teamId', whereIn: teamIds)
// // // //                             .snapshots(),
// // // //                     builder: (context, snapshot) {
// // // //                       if (snapshot.hasError) {
// // // //                         print('Error loading items: ${snapshot.error}');
// // // //                         return Center(child: Text('Error: ${snapshot.error}'));
// // // //                       }
// // // //                       if (!snapshot.hasData) {
// // // //                         return Center(child: CircularProgressIndicator());
// // // //                       }
// // // //                       final items = snapshot.data!.docs;
// // // //                       return ListView(
// // // //                         padding: EdgeInsets.all(16.0),
// // // //                         children: [
// // // //                           _buildAddItem(context),
// // // //                           ...items.map((doc) {
// // // //                             final data = doc.data() as Map<String, dynamic>;
// // // //                             return _buildListItem(
// // // //                               doc.id,
// // // //                               data['item_name'] ?? '',
// // // //                               data['quantity'] ?? '',
// // // //                               data['is_done'] ?? false,
// // // //                               data['add_time']?.toDate() ?? DateTime.now(),
// // // //                               data['is_edited'] ?? false,
// // // //                             );
// // // //                           }).toList(),
// // // //                         ],
// // // //                       );
// // // //                     },
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //       floatingActionButton: FloatingActionButton(
// // // //         onPressed: () async {
// // // //           try {
// // // //             setState(() {
// // // //               _micActive = !_micActive;
// // // //             });
// // // //             if (_micActive) {
// // // //               _micService.setListening(true);
// // // //               _micService.showVoiceInputDialog(context, () {
// // // //                 if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
// // // //                   _addItemToFirestore(_micService.name!, _micService.quantity!);
// // // //                 }
// // // //               }, () {
// // // //                 setState(() {
// // // //                   _micActive = false;
// // // //                 });
// // // //               });
// // // //             } else {
// // // //               _micService.setListening(false);
// // // //             }
// // // //           } catch (e) {
// // // //             print('MicService error: $e');
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               SnackBar(content: Text('Error with mic service: $e')),
// // // //             );
// // // //           }
// // // //         },
// // // //         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
// // // //         elevation: 6.0,
// // // //         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
// // // //       ),
// // // //       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
// // // //     );
// // // //   }

// // // //   Widget _buildAddItem(BuildContext context) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         _showAddItemDialog(context);
// // // //       },
// // // //       child: Container(
// // // //         margin: EdgeInsets.only(bottom: 10),
// // // //         padding: EdgeInsets.all(10),
// // // //         decoration: BoxDecoration(
// // // //           color: Colors.blue[100],
// // // //           borderRadius: BorderRadius.circular(10),
// // // //         ),
// // // //         child: Row(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             Icon(Icons.add, color: Colors.blue[600]),
// // // //             SizedBox(width: 10),
// // // //             Text(
// // // //               'Add Item',
// // // //               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildListItem(String docId, String itemName, String quantity, bool isDone, DateTime addTime, bool isEdited) {
// // // //     final textLength = (itemName + quantity).length;
// // // //     final containerHeight = textLength > 20 ? 100.0 : 80.0;

// // // //     return Container(
// // // //       margin: EdgeInsets.only(bottom: 10),
// // // //       height: containerHeight,
// // // //       padding: EdgeInsets.all(10),
// // // //       decoration: BoxDecoration(
// // // //         color: isDone ? Colors.green[200] : Colors.blue[100],
// // // //         borderRadius: BorderRadius.circular(10),
// // // //       ),
// // // //       child: Stack(
// // // //         children: [
// // // //           Align(
// // // //             alignment: Alignment.centerLeft,
// // // //             child: Row(
// // // //               crossAxisAlignment: CrossAxisAlignment.center,
// // // //               children: [
// // // //                 Checkbox(
// // // //                   value: isDone,
// // // //                   onChanged: (value) async {
// // // //                     if (value != null) {
// // // //                       try {
// // // //                         await FirebaseFirestore.instance.collection('items').doc(docId).update({
// // // //                           'is_done': value,
// // // //                           'edit_time': Timestamp.now(),
// // // //                           'is_edited': true,
// // // //                         });
// // // //                       } catch (e) {
// // // //                         print('Error updating is_done: $e');
// // // //                         ScaffoldMessenger.of(context).showSnackBar(
// // // //                           SnackBar(content: Text('Error updating item: $e')),
// // // //                         );
// // // //                       }
// // // //                     }
// // // //                   },
// // // //                 ),
// // // //                 Flexible(
// // // //                   child: Text(
// // // //                     '$itemName - $quantity',
// // // //                     style: TextStyle(
// // // //                       decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
// // // //                     ),
// // // //                     overflow: TextOverflow.ellipsis,
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           Positioned(
// // // //             left: 0,
// // // //             right: 0,
// // // //             top: 10,
// // // //             child: Center(
// // // //               child: Text(
// // // //                 'Rs. 299',
// // // //                 style: TextStyle(fontSize: 14, color: Colors.black),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           Positioned(
// // // //             right: 10,
// // // //             top: 10,
// // // //             child: Row(
// // // //               children: [
// // // //                 if (!isDone)
// // // //                   IconButton(
// // // //                     icon: Icon(Icons.edit, size: 20),
// // // //                     onPressed: () {
// // // //                       _showEditItemDialog(context, docId, itemName, quantity);
// // // //                     },
// // // //                   ),
// // // //                 if (!isDone)
// // // //                   IconButton(
// // // //                     icon: Icon(Icons.delete, size: 20),
// // // //                     onPressed: () {
// // // //                       _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, addTime);
// // // //                     },
// // // //                   ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           if (isEdited)
// // // //             Positioned(
// // // //               right: 10,
// // // //               top: 50,
// // // //               child: Container(
// // // //                 padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // // //                 decoration: BoxDecoration(
// // // //                   color: Colors.grey[600],
// // // //                   borderRadius: BorderRadius.circular(4),
// // // //                 ),
// // // //                 child: Text(
// // // //                   'Edited',
// // // //                   style: TextStyle(color: Colors.white, fontSize: 10),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _addItemToFirestore(String itemName, String quantity) async {
// // // //     try {
// // // //       final user = _currentUser;
// // // //       final userName = user?.displayName ?? user?.email ?? 'rock';
// // // //       final teamSnapshot = await FirebaseFirestore.instance
// // // //           .collection('teams')
// // // //           .where('members', arrayContains: user?.uid ?? '')
// // // //           .limit(1)
// // // //           .get();
// // // //       if (teamSnapshot.docs.isEmpty) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Join a team to add items')),
// // // //         );
// // // //         return;
// // // //       }
// // // //       final teamId = teamSnapshot.docs.first.id;
// // // //       await FirebaseFirestore.instance.collection('items').add({
// // // //         'add_time': Timestamp.now(),
// // // //         'assigned_by': userName,
// // // //         'bought_by': userName,
// // // //         'edit_time': null,
// // // //         'is_done': false,
// // // //         'is_edited': false,
// // // //         'item_name': itemName,
// // // //         'price': 'Rs. 299',
// // // //         'quantity': quantity,
// // // //         'teamId': teamId,
// // // //       });
// // // //     } catch (e) {
// // // //       print('Error adding item to Firestore: $e');
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Error adding item: $e')),
// // // //       );
// // // //     }
// // // //   }

// // // //   void _showAddItemDialog(BuildContext context) {
// // // //     String itemName = '';
// // // //     String quantity = '';

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) {
// // // //         return AlertDialog(
// // // //           title: Text('Add New Item'),
// // // //           content: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               TextField(
// // // //                 decoration: InputDecoration(labelText: 'Item Name'),
// // // //                 onChanged: (value) {
// // // //                   itemName = value;
// // // //                 },
// // // //               ),
// // // //               TextField(
// // // //                 decoration: InputDecoration(labelText: 'Quantity'),
// // // //                 onChanged: (value) {
// // // //                   quantity = value;
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () {
// // // //                 Navigator.pop(context);
// // // //               },
// // // //               child: Text('Cancel'),
// // // //             ),
// // // //             TextButton(
// // // //               onPressed: () {
// // // //                 if (itemName.isNotEmpty && quantity.isNotEmpty) {
// // // //                   _addItemToFirestore(itemName, quantity);
// // // //                   Navigator.pop(context);
// // // //                 }
// // // //               },
// // // //               child: Text('Add'),
// // // //             ),
// // // //           ],
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity) {
// // // //     String editedItemName = itemName;
// // // //     String editedQuantity = quantity;

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) {
// // // //         return AlertDialog(
// // // //           title: Text('Edit Item'),
// // // //           content: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               TextField(
// // // //                 decoration: InputDecoration(labelText: 'Item Name'),
// // // //                 controller: TextEditingController(text: itemName),
// // // //                 onChanged: (value) {
// // // //                   editedItemName = value;
// // // //                 },
// // // //               ),
// // // //               TextField(
// // // //                 decoration: InputDecoration(labelText: 'Quantity'),
// // // //                 controller: TextEditingController(text: quantity),
// // // //                 onChanged: (value) {
// // // //                   editedQuantity = value;
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () {
// // // //                 Navigator.pop(context);
// // // //               },
// // // //               child: Text('Cancel'),
// // // //             ),
// // // //             TextButton(
// // // //               onPressed: () async {
// // // //                 if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
// // // //                   try {
// // // //                     await FirebaseFirestore.instance.collection('items').doc(docId).update({
// // // //                       'item_name': editedItemName,
// // // //                       'quantity': editedQuantity,
// // // //                       'edit_time': Timestamp.now(),
// // // //                       'is_edited': true,
// // // //                     });
// // // //                     Navigator.pop(context);
// // // //                   } catch (e) {
// // // //                     print('Error editing item: $e');
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       SnackBar(content: Text('Error editing item: $e')),
// // // //                     );
// // // //                   }
// // // //                 }
// // // //               },
// // // //               child: Text('Save'),
// // // //             ),
// // // //           ],
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _deleteItemFromFirestore(
// // // //       BuildContext context, String docId, String itemName, String quantity, bool isDone, DateTime addTime) async {
// // // //     try {
// // // //       final deletedItem = {
// // // //         'docId': docId,
// // // //         'item_name': itemName,
// // // //         'quantity': quantity,
// // // //         'is_done': isDone,
// // // //         'add_time': addTime,
// // // //         'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'rock',
// // // //         'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'rock',
// // // //         'edit_time': null,
// // // //         'is_edited': false,
// // // //         'price': 'Rs. 299',
// // // //         'teamId': (await FirebaseFirestore.instance.collection('items').doc(docId).get()).data()!['teamId'],
// // // //       };

// // // //       await FirebaseFirestore.instance.collection('items').doc(docId).delete();

// // // //       _lastDeletedItem = deletedItem;
// // // //       _isUndoPending = true;

// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(
// // // //           content: Text('Item "$itemName" deleted'),
// // // //           action: SnackBarAction(
// // // //             label: 'Undo',
// // // //             onPressed: () async {
// // // //               if (_isUndoPending && _lastDeletedItem != null) {
// // // //                 try {
// // // //                   await FirebaseFirestore.instance.collection('items').add(_lastDeletedItem!);
// // // //                   setState(() {
// // // //                     _isUndoPending = false;
// // // //                     _lastDeletedItem = null;
// // // //                   });
// // // //                 } catch (e) {
// // // //                   print('Error undoing delete: $e');
// // // //                   ScaffoldMessenger.of(context).showSnackBar(
// // // //                     SnackBar(content: Text('Error undoing delete: $e')),
// // // //                   );
// // // //                 }
// // // //               }
// // // //             },
// // // //           ),
// // // //           duration: Duration(seconds: 5),
// // // //         ),
// // // //       );

// // // //       Future.delayed(Duration(seconds: 5), () {
// // // //         if (_isUndoPending && _lastDeletedItem != null) {
// // // //           setState(() {
// // // //             _isUndoPending = false;
// // // //             _lastDeletedItem = null;
// // // //           });
// // // //         }
// // // //       });
// // // //     } catch (e) {
// // // //       print('Error deleting item: $e');
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Error deleting item: $e')),
// // // //       );
// // // //     }
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../service/mic.dart';
// // // import '../widgets/greet.dart';
// // // import '../service/handle_teams.dart';
// // // import '../pages/account_page.dart'; // Add this import for redirection

// // // class ListingPage extends StatefulWidget {
// // //   const ListingPage({super.key});

// // //   @override
// // //   _ListingPageState createState() => _ListingPageState();
// // // }

// // // class _ListingPageState extends State<ListingPage> {
// // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// // //   final MicService _micService = MicService();
// // //   bool _micActive = false;
// // //   Map<String, dynamic>? _lastDeletedItem;
// // //   bool _isUndoPending = false;

// // //   User? get _currentUser => FirebaseAuth.instance.currentUser;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initializeTeamIfNeeded();
// // //   }

// // //   Future<void> _initializeTeamIfNeeded() async {
// // //     final teamManager = TeamManager();
// // //     if (teamManager.currentTeamId.isEmpty) {
// // //       // Attempt to set the "Self" team as default
// // //       final user = _currentUser;
// // //       if (user != null) {
// // //         final snapshot = await FirebaseFirestore.instance
// // //             .collection('teams')
// // //             .where('admin', isEqualTo: user.uid)
// // //             .where('name', isEqualTo: 'Self')
// // //             .limit(1)
// // //             .get();
// // //         if (snapshot.docs.isNotEmpty) {
// // //           final teamId = snapshot.docs.first.id;
// // //           teamManager.setCurrentTeam(teamId, 'Self', context);
// // //           setState(() {});
// // //         } else {
// // //           // Redirect to AccountPage if no "Self" team is found
// // //           if (mounted) {
// // //             Navigator.pushReplacement(
// // //               context,
// // //               MaterialPageRoute(builder: (context) => AccountPage()),
// // //             );
// // //           }
// // //         }
// // //       }
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final teamManager = TeamManager();
// // //     final isSelfTeam = teamManager.currentTeamName == 'Self';
// // //     if (teamManager.currentTeamId.isEmpty) {
// // //       return Center(child: CircularProgressIndicator());
// // //     }

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
// // //         child: Column(
// // //           children: [
// // //             GreetWidget(),
// // //             Padding(
// // //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// // //               child: TextField(
// // //                 decoration: InputDecoration(
// // //                   hintText: 'Search',
// // //                   prefixIcon: Icon(Icons.search),
// // //                   filled: true,
// // //                   fillColor: Colors.white,
// // //                   border: OutlineInputBorder(
// // //                     borderRadius: BorderRadius.circular(10),
// // //                     borderSide: BorderSide.none,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //             SizedBox(height: 20),
// // //             Padding(
// // //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// // //               child: StreamBuilder<QuerySnapshot>(
// // //                 stream: isSelfTeam
// // //                     ? FirebaseFirestore.instance
// // //                         .collection('teams')
// // //                         .where(FieldPath.documentId, isEqualTo: teamManager.currentTeamId)
// // //                         .snapshots()
// // //                     : null,
// // //                 builder: (context, teamSnapshot) {
// // //                   if (teamSnapshot.hasError) {
// // //                     print('Error loading teams: ${teamSnapshot.error}');
// // //                     return Center(child: Text('Error: ${teamSnapshot.error}'));
// // //                   }
// // //                   if (!teamSnapshot.hasData && isSelfTeam) {
// // //                     return Center(child: CircularProgressIndicator());
// // //                   }
// // //                   final teamIds = teamSnapshot.data?.docs.map((doc) => doc.id).toList() ?? [];
// // //                   return StreamBuilder<QuerySnapshot>(
// // //                     stream: isSelfTeam && teamIds.isNotEmpty
// // //                         ? FirebaseFirestore.instance
// // //                             .collection('teams')
// // //                             .doc(teamManager.currentTeamId)
// // //                             .collection('self_items')
// // //                             .snapshots()
// // //                         : null,
// // //                     builder: (context, snapshot) {
// // //                       if (snapshot.hasError) {
// // //                         print('Error loading self_items: ${snapshot.error}');
// // //                         return Center(child: Text('Error: ${snapshot.error}'));
// // //                       }
// // //                       if (!snapshot.hasData && isSelfTeam) {
// // //                         return Center(child: CircularProgressIndicator());
// // //                       }
// // //                       final items = snapshot.data?.docs ?? [];
// // //                       final totalCost = items.fold(0.0, (sum, doc) {
// // //                         final price = double.tryParse((doc.data() as Map<String, dynamic>)['price'].replaceAll('Rs. ', '')) ?? 0.0;
// // //                         final quantity = int.tryParse((doc.data() as Map<String, dynamic>)['quantity']) ?? 1;
// // //                         return sum + (price * quantity);
// // //                       });
// // //                       return Row(
// // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                         children: [
// // //                           Text(
// // //                             'Grocery List',
// // //                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //                           ),
// // //                           Text(
// // //                             'Estimated Cost: ₹${totalCost.toStringAsFixed(2)}',
// // //                             style: TextStyle(fontSize: 16, color: Colors.grey),
// // //                           ),
// // //                         ],
// // //                       );
// // //                     },
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //             Expanded(
// // //               child: StreamBuilder<QuerySnapshot>(
// // //                 stream: isSelfTeam
// // //                     ? FirebaseFirestore.instance
// // //                         .collection('teams')
// // //                         .doc(teamManager.currentTeamId)
// // //                         .collection('self_items')
// // //                         .snapshots()
// // //                     : null,
// // //                 builder: (context, snapshot) {
// // //                   if (snapshot.hasError) {
// // //                     print('Error loading self_items: ${snapshot.error}');
// // //                     return Center(child: Text('Error: ${snapshot.error}'));
// // //                   }
// // //                   if (!snapshot.hasData && isSelfTeam) {
// // //                     return Center(child: Text('No items yet'));
// // //                   }
// // //                   final items = snapshot.data?.docs ?? [];
// // //                   return ListView(
// // //                     padding: EdgeInsets.all(16.0),
// // //                     children: [
// // //                       _buildAddItem(context),
// // //                       ...items.map((doc) {
// // //                         final data = doc.data() as Map<String, dynamic>;
// // //                         final docId = doc.id;
// // //                         final itemName = data['item_name'] ?? '';
// // //                         final quantity = data['quantity'] ?? '';
// // //                         final isDone = data['is_done'] ?? false;
// // //                         final addTime = data['add_time']?.toDate() ?? DateTime.now();
// // //                         final isEdited = data['is_edited'] ?? false;
// // //                         final assignedBy = data['assigned_by'] ?? '';
// // //                         final boughtBy = data['bought_by'] ?? '';
// // //                         final editTime = data['edit_time']?.toDate() ?? null;
// // //                         final price = data['price'] ?? 'Rs. 0';
// // //                         return _buildListItem(
// // //                           docId,
// // //                           itemName,
// // //                           quantity,
// // //                           isDone,
// // //                           addTime,
// // //                           isEdited,
// // //                           assignedBy,
// // //                           boughtBy,
// // //                           editTime,
// // //                           price,
// // //                         );
// // //                       }).toList(),
// // //                     ],
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () async {
// // //           try {
// // //             setState(() {
// // //               _micActive = !_micActive;
// // //             });
// // //             if (_micActive) {
// // //               _micService.setListening(true);
// // //               _micService.showVoiceInputDialog(context, () {
// // //                 if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
// // //                   _addItemToFirestore(_micService.name!, _micService.quantity!);
// // //                 }
// // //               }, () {
// // //                 setState(() {
// // //                   _micActive = false;
// // //                 });
// // //               });
// // //             } else {
// // //               _micService.setListening(false);
// // //             }
// // //           } catch (e) {
// // //             print('MicService error: $e');
// // //             ScaffoldMessenger.of(context).showSnackBar(
// // //               SnackBar(content: Text('Error with mic service: $e')),
// // //             );
// // //           }
// // //         },
// // //         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
// // //         elevation: 6.0,
// // //         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
// // //       ),
// // //       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
// // //     );
// // //   }

// // //   Widget _buildAddItem(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         _showAddItemDialog(context);
// // //       },
// // //       child: Container(
// // //         margin: EdgeInsets.only(bottom: 10),
// // //         padding: EdgeInsets.all(10),
// // //         decoration: BoxDecoration(
// // //           color: Colors.blue[100],
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Icon(Icons.add, color: Colors.blue[600]),
// // //             SizedBox(width: 10),
// // //             Text(
// // //               'Add Item',
// // //               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildListItem(
// // //     String docId,
// // //     String itemName,
// // //     String quantity,
// // //     bool isDone,
// // //     DateTime addTime,
// // //     bool isEdited,
// // //     String assignedBy,
// // //     String boughtBy,
// // //     DateTime? editTime,
// // //     String price,
// // //   ) {
// // //     final textLength = (itemName + quantity).length;
// // //     final containerHeight = textLength > 20 ? 120.0 : 100.0;

// // //     return Container(
// // //       margin: EdgeInsets.only(bottom: 10),
// // //       height: containerHeight,
// // //       padding: EdgeInsets.all(10),
// // //       decoration: BoxDecoration(
// // //         color: isDone ? Colors.green[200] : Colors.blue[100],
// // //         borderRadius: BorderRadius.circular(10),
// // //       ),
// // //       child: Stack(
// // //         children: [
// // //           Align(
// // //             alignment: Alignment.centerLeft,
// // //             child: Row(
// // //               crossAxisAlignment: CrossAxisAlignment.center,
// // //               children: [
// // //                 Checkbox(
// // //                   value: isDone,
// // //                   onChanged: (value) async {
// // //                     if (value != null) {
// // //                       try {
// // //                         await FirebaseFirestore.instance
// // //                             .collection('teams')
// // //                             .doc(TeamManager().currentTeamId)
// // //                             .collection('self_items')
// // //                             .doc(docId)
// // //                             .update({
// // //                           'is_done': value,
// // //                           'edit_time': Timestamp.now(),
// // //                           'is_edited': true,
// // //                         });
// // //                       } catch (e) {
// // //                         print('Error updating is_done: $e');
// // //                         ScaffoldMessenger.of(context).showSnackBar(
// // //                           SnackBar(content: Text('Error updating item: $e')),
// // //                         );
// // //                       }
// // //                     }
// // //                   },
// // //                 ),
// // //                 Flexible(
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         '$itemName - $quantity',
// // //                         style: TextStyle(
// // //                           decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
// // //                           fontSize: 16,
// // //                         ),
// // //                         overflow: TextOverflow.ellipsis,
// // //                       ),
// // //                       SizedBox(height: 4),
// // //                       Text(
// // //                         'Assigned by: $assignedBy',
// // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                       ),
// // //                       Text(
// // //                         'Bought by: $boughtBy',
// // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                       ),
// // //                       if (editTime != null)
// // //                         Text(
// // //                           'Edited: ${editTime.toLocal()}',
// // //                           style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                         ),
// // //                       Text(
// // //                         'Added: ${addTime.toLocal()}',
// // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           Positioned(
// // //             left: 0,
// // //             right: 0,
// // //             top: 10,
// // //             child: Center(
// // //               child: Text(
// // //                 '$price',
// // //                 style: TextStyle(fontSize: 14, color: Colors.black),
// // //               ),
// // //             ),
// // //           ),
// // //           Positioned(
// // //             right: 10,
// // //             top: 10,
// // //             child: Row(
// // //               children: [
// // //                 if (!isDone)
// // //                   IconButton(
// // //                     icon: Icon(Icons.edit, size: 20),
// // //                     onPressed: () {
// // //                       _showEditItemDialog(context, docId, itemName, quantity, assignedBy, boughtBy, price);
// // //                     },
// // //                   ),
// // //                 if (!isDone)
// // //                   IconButton(
// // //                     icon: Icon(Icons.delete, size: 20),
// // //                     onPressed: () {
// // //                       _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, addTime, assignedBy, boughtBy, editTime, price);
// // //                     },
// // //                   ),
// // //               ],
// // //             ),
// // //           ),
// // //           if (isEdited)
// // //             Positioned(
// // //               right: 10,
// // //               top: 50,
// // //               child: Container(
// // //                 padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[600],
// // //                   borderRadius: BorderRadius.circular(4),
// // //                 ),
// // //                 child: Text(
// // //                   'Edited',
// // //                   style: TextStyle(color: Colors.white, fontSize: 10),
// // //                 ),
// // //               ),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   void _addItemToFirestore(String itemName, String quantity) async {
// // //     try {
// // //       final user = _currentUser;
// // //       final userName = user?.displayName ?? user?.email ?? 'rock';
// // //       if (TeamManager().currentTeamName != 'Self') {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Can only add items to "Self" team')),
// // //         );
// // //         return;
// // //       }
// // //       final teamId = TeamManager().currentTeamId;
// // //       await FirebaseFirestore.instance
// // //           .collection('teams')
// // //           .doc(teamId)
// // //           .collection('self_items')
// // //           .add({
// // //         'add_time': Timestamp.now(),
// // //         'assigned_by': userName,
// // //         'bought_by': userName,
// // //         'edit_time': null,
// // //         'is_done': false,
// // //         'is_edited': false,
// // //         'item_name': itemName,
// // //         'price': 'Rs. 299',
// // //         'quantity': quantity,
// // //       });
// // //     } catch (e) {
// // //       print('Error adding item to Firestore: $e');
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Error adding item: $e')),
// // //       );
// // //     }
// // //   }

// // //   void _showAddItemDialog(BuildContext context) {
// // //     String itemName = '';
// // //     String quantity = '';

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return AlertDialog(
// // //           title: Text('Add New Item'),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               TextField(
// // //                 decoration: InputDecoration(labelText: 'Item Name'),
// // //                 onChanged: (value) {
// // //                   itemName = value;
// // //                 },
// // //               ),
// // //               TextField(
// // //                 decoration: InputDecoration(labelText: 'Quantity'),
// // //                 onChanged: (value) {
// // //                   quantity = value;
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.pop(context);
// // //               },
// // //               child: Text('Cancel'),
// // //             ),
// // //             TextButton(
// // //               onPressed: () {
// // //                 if (itemName.isNotEmpty && quantity.isNotEmpty) {
// // //                   _addItemToFirestore(itemName, quantity);
// // //                   Navigator.pop(context);
// // //                 }
// // //               },
// // //               child: Text('Add'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String assignedBy, String boughtBy, String price) {
// // //     String editedItemName = itemName;
// // //     String editedQuantity = quantity;

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return AlertDialog(
// // //           title: Text('Edit Item'),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               TextField(
// // //                 decoration: InputDecoration(labelText: 'Item Name'),
// // //                 controller: TextEditingController(text: itemName),
// // //                 onChanged: (value) {
// // //                   editedItemName = value;
// // //                 },
// // //               ),
// // //               TextField(
// // //                 decoration: InputDecoration(labelText: 'Quantity'),
// // //                 controller: TextEditingController(text: quantity),
// // //                 onChanged: (value) {
// // //                   editedQuantity = value;
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.pop(context);
// // //               },
// // //               child: Text('Cancel'),
// // //             ),
// // //             TextButton(
// // //               onPressed: () async {
// // //                 if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
// // //                   try {
// // //                     await FirebaseFirestore.instance
// // //                         .collection('teams')
// // //                         .doc(TeamManager().currentTeamId)
// // //                         .collection('self_items')
// // //                         .doc(docId)
// // //                         .update({
// // //                       'item_name': editedItemName,
// // //                       'quantity': editedQuantity,
// // //                       'edit_time': Timestamp.now(),
// // //                       'is_edited': true,
// // //                     });
// // //                     Navigator.pop(context);
// // //                   } catch (e) {
// // //                     print('Error editing item: $e');
// // //                     ScaffoldMessenger.of(context).showSnackBar(
// // //                       SnackBar(content: Text('Error editing item: $e')),
// // //                     );
// // //                   }
// // //                 }
// // //               },
// // //               child: Text('Save'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _deleteItemFromFirestore(
// // //     BuildContext context,
// // //     String docId,
// // //     String itemName,
// // //     String quantity,
// // //     bool isDone,
// // //     DateTime addTime,
// // //     String assignedBy,
// // //     String boughtBy,
// // //     DateTime? editTime,
// // //     String price,
// // //   ) async {
// // //     try {
// // //       final deletedItem = {
// // //         'docId': docId,
// // //         'add_time': addTime,
// // //         'assigned_by': assignedBy,
// // //         'bought_by': boughtBy,
// // //         'edit_time': editTime,
// // //         'is_done': isDone,
// // //         'is_edited': true,
// // //         'item_name': itemName,
// // //         'price': price,
// // //         'quantity': quantity,
// // //       };

// // //       await FirebaseFirestore.instance
// // //           .collection('teams')
// // //           .doc(TeamManager().currentTeamId)
// // //           .collection('self_items')
// // //           .doc(docId)
// // //           .delete();

// // //       _lastDeletedItem = deletedItem;
// // //       _isUndoPending = true;

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           content: Text('Item "$itemName" deleted'),
// // //           action: SnackBarAction(
// // //             label: 'Undo',
// // //             onPressed: () async {
// // //               if (_isUndoPending && _lastDeletedItem != null) {
// // //                 try {
// // //                   await FirebaseFirestore.instance
// // //                       .collection('teams')
// // //                       .doc(TeamManager().currentTeamId)
// // //                       .collection('self_items')
// // //                       .add(_lastDeletedItem!);
// // //                   setState(() {
// // //                     _isUndoPending = false;
// // //                     _lastDeletedItem = null;
// // //                   });
// // //                 } catch (e) {
// // //                   print('Error undoing delete: $e');
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(content: Text('Error undoing delete: $e')),
// // //                   );
// // //                 }
// // //               }
// // //             },
// // //           ),
// // //           duration: Duration(seconds: 5),
// // //         ),
// // //       );

// // //       Future.delayed(Duration(seconds: 5), () {
// // //         if (_isUndoPending && _lastDeletedItem != null) {
// // //           setState(() {
// // //             _isUndoPending = false;
// // //             _lastDeletedItem = null;
// // //           });
// // //         }
// // //       });
// // //     } catch (e) {
// // //       print('Error deleting item: $e');
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Error deleting item: $e')),
// // //       );
// // //     }
// // //   }
// // // }


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
// //     // Simplified offline check (add connectivity package for real-time detection)
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
// //         child: Column(
// //           children: [
// //             GreetWidget(),
// //             Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// //               child: TextField(
// //                 decoration: InputDecoration(
// //                   hintText: 'Search',
// //                   prefixIcon: Icon(Icons.search),
// //                   filled: true,
// //                   fillColor: Colors.white,
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// //               child: StreamBuilder<QuerySnapshot>(
// //                 stream: isSelfTeam
// //                     ? FirebaseFirestore.instance
// //                         .collection('teams')
// //                         .where(FieldPath.documentId, isEqualTo: teamManager.currentTeamId)
// //                         .snapshots()
// //                     : null,
// //                 builder: (context, teamSnapshot) {
// //                   if (teamSnapshot.hasError) {
// //                     print('Error loading teams: ${teamSnapshot.error}');
// //                     return Center(child: Text('Error: ${teamSnapshot.error}'));
// //                   }
// //                   if (!teamSnapshot.hasData && isSelfTeam) {
// //                     return Center(child: CircularProgressIndicator());
// //                   }
// //                   final teamIds = teamSnapshot.data?.docs.map((doc) => doc.id).toList() ?? [];
// //                   return StreamBuilder<QuerySnapshot>(
// //                     stream: isSelfTeam && teamIds.isNotEmpty
// //                         ? FirebaseFirestore.instance
// //                             .collection('teams')
// //                             .doc(teamManager.currentTeamId)
// //                             .collection('self_items')
// //                             .snapshots()
// //                     : null,
// //                     builder: (context, snapshot) {
// //                       if (snapshot.hasError) {
// //                         print('Error loading self_items: ${snapshot.error}');
// //                         return Center(child: Text('Error: ${snapshot.error}'));
// //                       }
// //                       if (!snapshot.hasData && isSelfTeam) {
// //                         return Center(child: Text(_isOffline ? 'Offline - No data yet' : 'No items yet'));
// //                       }
// //                       final items = snapshot.data?.docs ?? [];
// //                       final totalCost = items.fold(0.0, (sum, doc) {
// //                         final price = double.tryParse((doc.data() as Map<String, dynamic>)['price'].replaceAll('Rs. ', '')) ?? 0.0;
// //                         final quantity = int.tryParse((doc.data() as Map<String, dynamic>)['quantity']) ?? 1;
// //                         return sum + (price * quantity);
// //                       });
// //                       return Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text(
// //                             'Grocery List',
// //                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                           ),
// //                           Text(
// //                             'Estimated Cost: ₹${totalCost.toStringAsFixed(2)}',
// //                             style: TextStyle(fontSize: 16, color: Colors.grey),
// //                           ),
// //                         ],
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //             Expanded(
// //               child: StreamBuilder<QuerySnapshot>(
// //                 stream: isSelfTeam
// //                     ? FirebaseFirestore.instance
// //                         .collection('teams')
// //                         .doc(teamManager.currentTeamId)
// //                         .collection('self_items')
// //                         .snapshots()
// //                     : null,
// //                 builder: (context, snapshot) {
// //                   if (snapshot.hasError) {
// //                     print('Error loading self_items: ${snapshot.error}');
// //                     return Center(child: Text('Error: ${snapshot.error}'));
// //                   }
// //                   if (!snapshot.hasData && isSelfTeam) {
// //                     return Center(child: Text(_isOffline ? 'Offline - No data yet' : 'No items yet'));
// //                   }
// //                   final items = snapshot.data?.docs ?? [];
// //                   return ListView(
// //                     padding: EdgeInsets.all(16.0),
// //                     children: [
// //                       _buildAddItem(context),
// //                       ...items.map((doc) {
// //                         final data = doc.data() as Map<String, dynamic>;
// //                         final docId = doc.id;
// //                         final itemName = data['item_name'] ?? '';
// //                         final quantity = data['quantity'] ?? '';
// //                         final isDone = data['is_done'] ?? false;
// //                         final addTime = data['add_time']?.toDate() ?? DateTime.now();
// //                         final isEdited = data['is_edited'] ?? false;
// //                         final assignedBy = data['assigned_by'] ?? '';
// //                         final boughtBy = data['bought_by'] ?? '';
// //                         final editTime = data['edit_time']?.toDate() ?? null;
// //                         final price = data['price'] ?? 'Rs. 0';
// //                         return _buildListItem(
// //                           docId,
// //                           itemName,
// //                           quantity,
// //                           isDone,
// //                           addTime,
// //                           isEdited,
// //                           assignedBy,
// //                           boughtBy,
// //                           editTime,
// //                           price,
// //                         );
// //                       }).toList(),
// //                     ],
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
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
// //         margin: EdgeInsets.only(bottom: 10),
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
// import '../pages/account_page.dart';

// class ListingPage extends StatefulWidget {
//   const ListingPage({super.key});

//   @override
//   _ListingPageState createState() => _ListingPageState();
// }

// class _ListingPageState extends State<ListingPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final MicService _micService = MicService();
//   bool _micActive = false;
//   Map<String, dynamic>? _lastDeletedItem;
//   bool _isUndoPending = false;
//   bool _isOffline = false;
//   List<QueryDocumentSnapshot> _cachedItems = []; // Cache for items

//   User? get _currentUser => FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _initializeTeamIfNeeded();
//     _checkConnectivity();
//   }

//   Future<void> _initializeTeamIfNeeded() async {
//     final teamManager = TeamManager();
//     if (teamManager.currentTeamId.isEmpty) {
//       final user = _currentUser;
//       if (user != null) {
//         final snapshot = await FirebaseFirestore.instance
//             .collection('teams')
//             .where('admin', isEqualTo: user.uid)
//             .where('name', isEqualTo: 'Self')
//             .limit(1)
//             .get(GetOptions(source: Source.cache)); // Try cache first
//         if (snapshot.docs.isNotEmpty) {
//           final teamId = snapshot.docs.first.id;
//           teamManager.setCurrentTeam(teamId, 'Self', context);
//           setState(() {});
//         } else {
//           // Fall back to server if cache is empty
//           final serverSnapshot = await FirebaseFirestore.instance
//               .collection('teams')
//               .where('admin', isEqualTo: user.uid)
//               .where('name', isEqualTo: 'Self')
//               .limit(1)
//               .get(GetOptions(source: Source.serverAndCache));
//           if (serverSnapshot.docs.isNotEmpty) {
//             final teamId = serverSnapshot.docs.first.id;
//             teamManager.setCurrentTeam(teamId, 'Self', context);
//             setState(() {});
//           } else if (mounted) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AccountPage()),
//             );
//           }
//         }
//       }
//     }
//   }

//   Future<void> _checkConnectivity() async {
//     // Simplified offline check
//     try {
//       await FirebaseFirestore.instance
//           .collection('teams')
//           .limit(1)
//           .get(GetOptions(source: Source.server));
//       setState(() => _isOffline = false);
//     } catch (e) {
//       setState(() => _isOffline = true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final teamManager = TeamManager();
//     final isSelfTeam = teamManager.currentTeamName == 'Self';
//     if (teamManager.currentTeamId.isEmpty) {
//       return Center(child: CircularProgressIndicator());
//     }

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
//         child: Column(
//           children: [
//             GreetWidget(),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   prefixIcon: Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Grocery List',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   StreamBuilder<QuerySnapshot>(
//                     stream: isSelfTeam
//                         ? FirebaseFirestore.instance
//                             .collection('teams')
//                             .doc(teamManager.currentTeamId)
//                             .collection('self_items')
//                             .snapshots()
//                         : null,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         print('Error loading self_items: ${snapshot.error}');
//                         return Text('Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting && _cachedItems.isEmpty) {
//                         return Text('Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
//                       }
//                       if (snapshot.hasData || _cachedItems.isNotEmpty) {
//                         final items = snapshot.data?.docs ?? _cachedItems;
//                         _cachedItems = items; // Update cache
//                         final totalCost = items.fold(0.0, (sum, doc) {
//                           final price = double.tryParse((doc.data() as Map<String, dynamic>)['price'].replaceAll('Rs. ', '')) ?? 0.0;
//                           final quantity = int.tryParse((doc.data() as Map<String, dynamic>)['quantity']) ?? 1;
//                           return sum + (price * quantity);
//                         });
//                         return Text(
//                           'Estimated Cost: ₹${totalCost.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                         );
//                       }
//                       return Text(_isOffline ? 'Offline - No cost' : 'Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             _buildAddItem(context),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: isSelfTeam
//                     ? FirebaseFirestore.instance
//                         .collection('teams')
//                         .doc(teamManager.currentTeamId)
//                         .collection('self_items')
//                         .snapshots()
//                     : null,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     print('Error loading self_items: ${snapshot.error}');
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting && _cachedItems.isEmpty) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasData || _cachedItems.isNotEmpty) {
//                     final items = snapshot.data?.docs ?? _cachedItems;
//                     _cachedItems = items; // Update cache
//                     return ListView(
//                       padding: EdgeInsets.all(16.0),
//                       children: items.map((doc) {
//                         final data = doc.data() as Map<String, dynamic>;
//                         final docId = doc.id;
//                         final itemName = data['item_name'] ?? '';
//                         final quantity = data['quantity'] ?? '';
//                         final isDone = data['is_done'] ?? false;
//                         final addTime = data['add_time']?.toDate() ?? DateTime.now();
//                         final isEdited = data['is_edited'] ?? false;
//                         final assignedBy = data['assigned_by'] ?? '';
//                         final boughtBy = data['bought_by'] ?? '';
//                         final editTime = data['edit_time']?.toDate() ?? null;
//                         final price = data['price'] ?? 'Rs. 0';
//                         return _buildListItem(
//                           docId,
//                           itemName,
//                           quantity,
//                           isDone,
//                           addTime,
//                           isEdited,
//                           assignedBy,
//                           boughtBy,
//                           editTime,
//                           price,
//                         );
//                       }).toList(),
//                     );
//                   }
//                   return Center(child: Text(_isOffline ? 'Offline - No data yet' : 'No items yet'));
//                 },
//               ),
//             ),
//           ],
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

//       _lastDeletedItem = deletedItem;
//       _isUndoPending = true;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Item "$itemName" deleted'),
//           action: SnackBarAction(
//             label: 'Undo',
//             onPressed: () async {
//               if (_isUndoPending && _lastDeletedItem != null) {
//                 try {
//                   await FirebaseFirestore.instance
//                       .collection('teams')
//                       .doc(TeamManager().currentTeamId)
//                       .collection('self_items')
//                       .add(_lastDeletedItem!);
//                   setState(() {
//                     _isUndoPending = false;
//                     _lastDeletedItem = null;
//                   });
//                 } catch (e) {
//                   print('Error undoing delete: $e');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error undoing delete: $e')),
//                   );
//                 }
//               }
//             },
//           ),
//           duration: Duration(seconds: 5),
//         ),
//       );

//       Future.delayed(Duration(seconds: 5), () {
//         if (_isUndoPending && _lastDeletedItem != null) {
//           setState(() {
//             _isUndoPending = false;
//             _lastDeletedItem = null;
//           });
//         }
//       });
//     } catch (e) {
//       print('Error deleting item: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting item: $e')),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/mic.dart';
import '../widgets/greet.dart';
import '../service/handle_teams.dart';
import '../pages/account_page.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MicService _micService = MicService();
  bool _micActive = false;
  Map<String, dynamic>? _lastDeletedItem;
  bool _isUndoPending = false;
  bool _isOffline = false;
  List<QueryDocumentSnapshot> _cachedItems = []; // Cache for items

  User? get _currentUser => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _initializeTeamIfNeeded();
    _checkConnectivity();
  }

  Future<void> _initializeTeamIfNeeded() async {
    final teamManager = TeamManager();
    if (teamManager.currentTeamId.isEmpty) {
      final user = _currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('teams')
            .where('admin', isEqualTo: user.uid)
            .where('name', isEqualTo: 'Self')
            .limit(1)
            .get(GetOptions(source: Source.cache)); // Try cache first
        if (snapshot.docs.isNotEmpty) {
          final teamId = snapshot.docs.first.id;
          teamManager.setCurrentTeam(teamId, 'Self', context);
          setState(() {});
        } else {
          // Fall back to server if cache is empty
          final serverSnapshot = await FirebaseFirestore.instance
              .collection('teams')
              .where('admin', isEqualTo: user.uid)
              .where('name', isEqualTo: 'Self')
              .limit(1)
              .get(GetOptions(source: Source.serverAndCache));
          if (serverSnapshot.docs.isNotEmpty) {
            final teamId = serverSnapshot.docs.first.id;
            teamManager.setCurrentTeam(teamId, 'Self', context);
            setState(() {});
          } else if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          }
        }
      }
    }
  }

  Future<void> _checkConnectivity() async {
    // Simplified offline check
    try {
      await FirebaseFirestore.instance
          .collection('teams')
          .limit(1)
          .get(GetOptions(source: Source.server));
      setState(() => _isOffline = false);
    } catch (e) {
      setState(() => _isOffline = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamManager = TeamManager();
    final isSelfTeam = teamManager.currentTeamName == 'Self';
    if (teamManager.currentTeamId.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grocery List',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: isSelfTeam
                          ? FirebaseFirestore.instance
                              .collection('teams')
                              .doc(teamManager.currentTeamId)
                              .collection('self_items')
                              .snapshots()
                          : null,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print('Error loading self_items: ${snapshot.error}');
                          return Text('Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting && _cachedItems.isEmpty) {
                          return Text('Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
                        }
                        if (snapshot.hasData || _cachedItems.isNotEmpty) {
                          final items = snapshot.data?.docs ?? _cachedItems;
                          _cachedItems = items; // Update cache
                          final totalCost = items.fold(0.0, (sum, doc) {
                            final price = double.tryParse((doc.data() as Map<String, dynamic>)['price'].replaceAll('Rs. ', '')) ?? 0.0;
                            final quantity = int.tryParse((doc.data() as Map<String, dynamic>)['quantity']) ?? 1;
                            return sum + (price * quantity);
                          });
                          return Text(
                            'Estimated Cost: ₹${totalCost.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          );
                        }
                        return Text(_isOffline ? 'Offline - No cost' : 'Estimated Cost: ₹0.00', style: TextStyle(fontSize: 16, color: Colors.grey));
                      },
                    ),
                  ],
                ),
              ),
              _buildAddItem(context),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: isSelfTeam
                      ? FirebaseFirestore.instance
                          .collection('teams')
                          .doc(teamManager.currentTeamId)
                          .collection('self_items')
                          .snapshots()
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('Error loading self_items: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting && _cachedItems.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData || _cachedItems.isNotEmpty) {
                      final items = snapshot.data?.docs ?? _cachedItems;
                      _cachedItems = items; // Update cache
                      return ListView(
                        padding: EdgeInsets.all(16.0),
                        children: items.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final docId = doc.id;
                          final itemName = data['item_name'] ?? '';
                          final quantity = data['quantity'] ?? '';
                          final isDone = data['is_done'] ?? false;
                          final addTime = data['add_time']?.toDate() ?? DateTime.now();
                          final isEdited = data['is_edited'] ?? false;
                          final assignedBy = data['assigned_by'] ?? '';
                          final boughtBy = data['bought_by'] ?? '';
                          final editTime = data['edit_time']?.toDate() ?? null;
                          final price = data['price'] ?? 'Rs. 0';
                          return _buildListItem(
                            docId,
                            itemName,
                            quantity,
                            isDone,
                            addTime,
                            isEdited,
                            assignedBy,
                            boughtBy,
                            editTime,
                            price,
                          );
                        }).toList(),
                      );
                    }
                    return Center(child: Text(_isOffline ? 'Offline - No data yet' : 'No items yet'));
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
    DateTime addTime,
    bool isEdited,
    String assignedBy,
    String boughtBy,
    DateTime? editTime,
    String price,
  ) {
    final textLength = (itemName + quantity).length;
    final containerHeight = textLength > 20 ? 120.0 : 100.0;

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
                      SizedBox(height: 4),
                      Text(
                        'Assigned by: $assignedBy',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        'Bought by: $boughtBy',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      if (editTime != null)
                        Text(
                          'Edited: ${editTime.toLocal()}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      Text(
                        'Added: ${addTime.toLocal()}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
                      _showEditItemDialog(context, docId, itemName, quantity, assignedBy, boughtBy, price);
                    },
                  ),
                if (!isDone)
                  IconButton(
                    icon: Icon(Icons.delete, size: 20),
                    onPressed: () {
                      _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, addTime, assignedBy, boughtBy, editTime, price);
                    },
                  ),
              ],
            ),
          ),
          if (isEdited)
            Positioned(
              right: 10,
              top: 50,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Edited',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _addItemToFirestore(String itemName, String quantity) async {
    try {
      final user = _currentUser;
      final userName = user?.displayName ?? user?.email ?? 'rock';
      if (TeamManager().currentTeamName != 'Self') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Can only add items to "Self" team')),
        );
        return;
      }
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

  void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String assignedBy, String boughtBy, String price) {
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
    DateTime addTime,
    String assignedBy,
    String boughtBy,
    DateTime? editTime,
    String price,
  ) async {
    try {
      final deletedItem = {
        'docId': docId,
        'add_time': addTime,
        'assigned_by': assignedBy,
        'bought_by': boughtBy,
        'edit_time': editTime,
        'is_done': isDone,
        'is_edited': true,
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

      _lastDeletedItem = deletedItem;
      _isUndoPending = true;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item "$itemName" deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              if (_isUndoPending && _lastDeletedItem != null) {
                try {
                  await FirebaseFirestore.instance
                      .collection('teams')
                      .doc(TeamManager().currentTeamId)
                      .collection('self_items')
                      .add(_lastDeletedItem!);
                  setState(() {
                    _isUndoPending = false;
                    _lastDeletedItem = null;
                  });
                } catch (e) {
                  print('Error undoing delete: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error undoing delete: $e')),
                  );
                }
              }
            },
          ),
          duration: Duration(seconds: 5),
        ),
      );

      Future.delayed(Duration(seconds: 5), () {
        if (_isUndoPending && _lastDeletedItem != null) {
          setState(() {
            _isUndoPending = false;
            _lastDeletedItem = null;
          });
        }
      });
    } catch (e) {
      print('Error deleting item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }
}