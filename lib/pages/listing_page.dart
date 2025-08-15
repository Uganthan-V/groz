// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import '../service/mic.dart';
// // // // import '../widgets/greet.dart';
// // // // import '../service/handle_teams.dart';

// // // // class ListingPage extends StatefulWidget {
// // // //   const ListingPage({super.key});

// // // //   @override
// // // //   _ListingPageState createState() => _ListingPageState();
// // // // }

// // // // class _ListingPageState extends State<ListingPage> {
// // // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// // // //   final MicService _micService = MicService();
// // // //   bool _micActive = false;
// // // //   Map<String, Map<String, dynamic>> _teamData = {}; // Store team data (id, name, isSelf)
// // // //   Map<String, List<QueryDocumentSnapshot>> _teamItems = {}; // Store items per team
// // // //   String? _expandedTeamId; // Track the currently expanded team
// // // //   bool _isLoading = true;
// // // //   final User? _currentUser = FirebaseAuth.instance.currentUser;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _fetchAllTeamData();
// // // //   }

// // // //   Future<void> _fetchAllTeamData() async {
// // // //     final user = _currentUser;
// // // //     if (user == null) {
// // // //       setState(() => _isLoading = false);
// // // //       return;
// // // //     }

// // // //     try {
// // // //       // Fetch teams from current_teams
// // // //       final currentTeamsSnapshot = await FirebaseFirestore.instance
// // // //           .collection('users')
// // // //           .doc(user.uid)
// // // //           .collection('current_teams')
// // // //           .get();

// // // //       final teamData = <String, Map<String, dynamic>>{};
// // // //       final teamItems = <String, List<QueryDocumentSnapshot>>{};

// // // //       // Process current_teams
// // // //       for (final doc in currentTeamsSnapshot.docs) {
// // // //         final data = doc.data();
// // // //         teamData[doc.id] = {
// // // //           'teamId': doc.id,
// // // //           'name': data['name'] ?? 'Unnamed Team',
// // // //           'isSelf': false,
// // // //         };
// // // //       }

// // // //       // Check for "Self" team if not in current_teams
// // // //       final selfTeamSnapshot = await FirebaseFirestore.instance
// // // //           .collection('teams')
// // // //           .where('admin', isEqualTo: user.uid)
// // // //           .where('isSelf', isEqualTo: true)
// // // //           .get();

// // // //       if (selfTeamSnapshot.docs.isNotEmpty) {
// // // //         final selfTeam = selfTeamSnapshot.docs.first;
// // // //         final selfTeamId = selfTeam.id;
// // // //         if (!teamData.containsKey(selfTeamId)) {
// // // //           teamData[selfTeamId] = {
// // // //             'teamId': selfTeamId,
// // // //             'name': selfTeam['name'] ?? 'Self',
// // // //             'isSelf': true,
// // // //           };
// // // //         }
// // // //       }

// // // //       // Fetch items for each team
// // // //       for (final teamId in teamData.keys) {
// // // //         final itemsSnapshot = await FirebaseFirestore.instance
// // // //             .collection('teams')
// // // //             .doc(teamId)
// // // //             .collection('self_items')
// // // //             .get();
// // // //         teamItems[teamId] = itemsSnapshot.docs;
// // // //       }

// // // //       setState(() {
// // // //         _teamData = teamData;
// // // //         _teamItems = teamItems;
// // // //         _isLoading = false;
// // // //       });
// // // //     } catch (e) {
// // // //       print('Error fetching team data: $e');
// // // //       setState(() => _isLoading = false);
// // // //     }
// // // //   }

// // // //   void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
// // // //     setState(() {
// // // //       if (_expandedTeamId == teamId) {
// // // //         _expandedTeamId = null; // Collapse if already expanded
// // // //       } else {
// // // //         _expandedTeamId = teamId; // Expand new team
// // // //         TeamManager().setCurrentTeam(teamId, teamName, context);
// // // //       }
// // // //     });
// // // //   }

// // // //   Widget _buildAddItem(BuildContext context) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         _showAddItemDialog(context);
// // // //       },
// // // //       child: Container(
// // // //         margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
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

// // // //   Widget _buildListItem(
// // // //     String docId,
// // // //     String itemName,
// // // //     String quantity,
// // // //     bool isDone,
// // // //     String price,
// // // //   ) {
// // // //     final textLength = (itemName + quantity).length;
// // // //     final containerHeight = textLength > 20 ? 80.0 : 60.0;

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
// // // //                         await FirebaseFirestore.instance
// // // //                             .collection('teams')
// // // //                             .doc(TeamManager().currentTeamId)
// // // //                             .collection('self_items')
// // // //                             .doc(docId)
// // // //                             .update({
// // // //                               'is_done': value,
// // // //                               'edit_time': Timestamp.now(),
// // // //                               'is_edited': true,
// // // //                             });
// // // //                         _fetchAllTeamData(); // Refresh data
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
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Text(
// // // //                         '$itemName - $quantity',
// // // //                         style: TextStyle(
// // // //                           decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
// // // //                           fontSize: 16,
// // // //                         ),
// // // //                         overflow: TextOverflow.ellipsis,
// // // //                       ),
// // // //                     ],
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
// // // //                 '$price',
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
// // // //                       _showEditItemDialog(context, docId, itemName, quantity, price);
// // // //                     },
// // // //                   ),
// // // //                 if (!isDone)
// // // //                   IconButton(
// // // //                     icon: Icon(Icons.delete, size: 20),
// // // //                     onPressed: () {
// // // //                       _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
// // // //                     },
// // // //                   ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _addItemToFirestore(String itemName, String quantity) async {
// // // //     try {
// // // //       final user = _currentUser;
// // // //       final userName = user?.displayName ?? user?.email ?? 'Unknown';
// // // //       final teamId = TeamManager().currentTeamId;
// // // //       await FirebaseFirestore.instance
// // // //           .collection('teams')
// // // //           .doc(teamId)
// // // //           .collection('self_items')
// // // //           .add({
// // // //         'add_time': Timestamp.now(),
// // // //         'assigned_by': userName,
// // // //         'bought_by': userName,
// // // //         'edit_time': null,
// // // //         'is_done': false,
// // // //         'is_edited': false,
// // // //         'item_name': itemName,
// // // //         'price': 'Rs. 299',
// // // //         'quantity': quantity,
// // // //       });
// // // //       _fetchAllTeamData(); // Refresh data
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

// // // //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
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
// // // //                     await FirebaseFirestore.instance
// // // //                         .collection('teams')
// // // //                         .doc(TeamManager().currentTeamId)
// // // //                         .collection('self_items')
// // // //                         .doc(docId)
// // // //                         .update({
// // // //                           'item_name': editedItemName,
// // // //                           'quantity': editedQuantity,
// // // //                           'edit_time': Timestamp.now(),
// // // //                           'is_edited': true,
// // // //                         });
// // // //                     Navigator.pop(context);
// // // //                     _fetchAllTeamData(); // Refresh data
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
// // // //     BuildContext context,
// // // //     String docId,
// // // //     String itemName,
// // // //     String quantity,
// // // //     bool isDone,
// // // //     String price,
// // // //   ) async {
// // // //     try {
// // // //       final deletedItem = {
// // // //         'add_time': Timestamp.now(),
// // // //         'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// // // //         'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// // // //         'edit_time': null,
// // // //         'is_done': isDone,
// // // //         'is_edited': false,
// // // //         'item_name': itemName,
// // // //         'price': price,
// // // //         'quantity': quantity,
// // // //       };

// // // //       await FirebaseFirestore.instance
// // // //           .collection('teams')
// // // //           .doc(TeamManager().currentTeamId)
// // // //           .collection('self_items')
// // // //           .doc(docId)
// // // //           .delete();

// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(
// // // //           content: Text('Item "$itemName" deleted'),
// // // //           action: SnackBarAction(
// // // //             label: 'Undo',
// // // //             onPressed: () async {
// // // //               try {
// // // //                 await FirebaseFirestore.instance
// // // //                     .collection('teams')
// // // //                     .doc(TeamManager().currentTeamId)
// // // //                     .collection('self_items')
// // // //                     .add(deletedItem);
// // // //                 _fetchAllTeamData(); // Refresh data
// // // //               } catch (e) {
// // // //                 print('Error undoing delete: $e');
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   SnackBar(content: Text('Error undoing delete: $e')),
// // // //                 );
// // // //               }
// // // //             },
// // // //           ),
// // // //           duration: Duration(seconds: 5),
// // // //         ),
// // // //       );
// // // //       _fetchAllTeamData(); // Refresh data
// // // //     } catch (e) {
// // // //       print('Error deleting item: $e');
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Error deleting item: $e')),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       key: _scaffoldKey,
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
// // // //               GreetWidget(),
// // // //               Padding(
// // // //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: TextField(
// // // //                   decoration: InputDecoration(
// // // //                     hintText: 'Search',
// // // //                     prefixIcon: Icon(Icons.search),
// // // //                     filled: true,
// // // //                     fillColor: Colors.white,
// // // //                     border: OutlineInputBorder(
// // // //                       borderRadius: BorderRadius.circular(10),
// // // //                       borderSide: BorderSide.none,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               SizedBox(height: 20),
// // // //               Expanded(
// // // //                 child: _isLoading
// // // //                     ? Center(child: CircularProgressIndicator())
// // // //                     : _teamData.isEmpty
// // // //                         ? Center(child: Text('No gatherings yet'))
// // // //                         : ListView.builder(
// // // //                             padding: EdgeInsets.all(16.0),
// // // //                             itemCount: _teamData.length,
// // // //                             itemBuilder: (context, index) {
// // // //                               final teamId = _teamData.keys.elementAt(index);
// // // //                               final team = _teamData[teamId]!;
// // // //                               final teamName = team['name'] as String;
// // // //                               final isSelf = team['isSelf'] as bool;
// // // //                               final items = _teamItems[teamId] ?? [];
// // // //                               return Column(
// // // //                                 children: [
// // // //                                   GestureDetector(
// // // //                                     onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
// // // //                                     child: Container(
// // // //                                       padding: EdgeInsets.all(12),
// // // //                                       decoration: BoxDecoration(
// // // //                                         color: Colors.white,
// // // //                                         borderRadius: BorderRadius.circular(10),
// // // //                                         boxShadow: [
// // // //                                           BoxShadow(
// // // //                                             color: Colors.grey.withOpacity(0.3),
// // // //                                             spreadRadius: 2,
// // // //                                             blurRadius: 5,
// // // //                                             offset: Offset(0, 3),
// // // //                                           ),
// // // //                                         ],
// // // //                                       ),
// // // //                                       child: Row(
// // // //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                                         children: [
// // // //                                           Text(
// // // //                                             teamName,
// // // //                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                                           ),
// // // //                                           Icon(
// // // //                                             _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
// // // //                                           ),
// // // //                                         ],
// // // //                                       ),
// // // //                                     ),
// // // //                                   ),
// // // //                                   AnimatedSize(
// // // //                                     duration: Duration(milliseconds: 300),
// // // //                                     curve: Curves.easeInOut,
// // // //                                     child: _expandedTeamId == teamId
// // // //                                         ? Container(
// // // //                                             padding: EdgeInsets.all(16),
// // // //                                             child: Column(
// // // //                                               children: [
// // // //                                                 _buildAddItem(context),
// // // //                                                 Column(
// // // //                                                   children: items.map<Widget>((doc) {
// // // //                                                     final data = doc.data() as Map<String, dynamic>;
// // // //                                                     final docId = doc.id;
// // // //                                                     final itemName = data['item_name'] ?? '';
// // // //                                                     final quantity = data['quantity'] ?? '';
// // // //                                                     final isDone = data['is_done'] ?? false;
// // // //                                                     final price = data['price'] ?? 'Rs. 0';
// // // //                                                     return _buildListItem(
// // // //                                                       docId,
// // // //                                                       itemName,
// // // //                                                       quantity,
// // // //                                                       isDone,
// // // //                                                       price,
// // // //                                                     );
// // // //                                                   }).toList(),
// // // //                                                 ),
// // // //                                               ],
// // // //                                             ),
// // // //                                           )
// // // //                                         : SizedBox.shrink(),
// // // //                                   ),
// // // //                                   SizedBox(height: 16), // Add spacing between teams
// // // //                                 ],
// // // //                               );
// // // //                             },
// // // //                           ),
// // // //               ),
// // // //             ],
// // // //           ),
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
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../service/mic.dart';
// // // import '../widgets/greet.dart';
// // // import '../service/handle_teams.dart';

// // // class ListingPage extends StatefulWidget {
// // //   const ListingPage({super.key});

// // //   @override
// // //   _ListingPageState createState() => _ListingPageState();
// // // }

// // // class _ListingPageState extends State<ListingPage> {
// // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// // //   final MicService _micService = MicService();
// // //   bool _micActive = false;
// // //   Map<String, Map<String, dynamic>> _teamData = {}; // Store team data (id, name, isSelf)
// // //   Map<String, List<QueryDocumentSnapshot>> _teamItems = {}; // Store items per team
// // //   String? _expandedTeamId; // Track the currently expanded team
// // //   bool _isLoading = true;
// // //   final User? _currentUser = FirebaseAuth.instance.currentUser;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchAllTeamData();
// // //   }

// // //   Future<void> _fetchAllTeamData() async {
// // //     final user = _currentUser;
// // //     if (user == null) {
// // //       setState(() => _isLoading = false);
// // //       return;
// // //     }

// // //     try {
// // //       // Fetch teams from current_teams
// // //       final currentTeamsSnapshot = await FirebaseFirestore.instance
// // //           .collection('users')
// // //           .doc(user.uid)
// // //           .collection('current_teams')
// // //           .get();

// // //       final teamData = <String, Map<String, dynamic>>{};
// // //       final teamItems = <String, List<QueryDocumentSnapshot>>{};

// // //       // Process current_teams
// // //       for (final doc in currentTeamsSnapshot.docs) {
// // //         final data = doc.data();
// // //         teamData[doc.id] = {
// // //           'teamId': doc.id,
// // //           'name': data['name'] ?? 'Unnamed Team',
// // //           'isSelf': false,
// // //         };
// // //       }

// // //       // Check for "Self" team if not in current_teams
// // //       final selfTeamSnapshot = await FirebaseFirestore.instance
// // //           .collection('teams')
// // //           .where('admin', isEqualTo: user.uid)
// // //           .where('isSelf', isEqualTo: true)
// // //           .get();

// // //       if (selfTeamSnapshot.docs.isNotEmpty) {
// // //         final selfTeam = selfTeamSnapshot.docs.first;
// // //         final selfTeamId = selfTeam.id;
// // //         if (!teamData.containsKey(selfTeamId)) {
// // //           teamData[selfTeamId] = {
// // //             'teamId': selfTeamId,
// // //             'name': selfTeam['name'] ?? 'Self',
// // //             'isSelf': true,
// // //           };
// // //         }
// // //       }

// // //       // Fetch items for each team
// // //       for (final teamId in teamData.keys) {
// // //         final itemsSnapshot = await FirebaseFirestore.instance
// // //             .collection('teams')
// // //             .doc(teamId)
// // //             .collection('self_items')
// // //             .get();
// // //         teamItems[teamId] = itemsSnapshot.docs;
// // //       }

// // //       setState(() {
// // //         _teamData = teamData;
// // //         _teamItems = teamItems;
// // //         _isLoading = false;
// // //       });
// // //     } catch (e) {
// // //       print('Error fetching team data: $e');
// // //       setState(() => _isLoading = false);
// // //     }
// // //   }

// // //   void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
// // //     setState(() {
// // //       if (_expandedTeamId == teamId) {
// // //         _expandedTeamId = null; // Collapse if already expanded
// // //       } else {
// // //         _expandedTeamId = teamId; // Expand new team
// // //         TeamManager().setCurrentTeam(teamId, teamName, context);
// // //       }
// // //     });
// // //   }

// // //   double _calculateEstimatedCost(String teamId) {
// // //     final items = _teamItems[teamId] ?? [];
// // //     return items.fold(0.0, (sum, doc) {
// // //       final data = doc.data() as Map<String, dynamic>;
// // //       final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
// // //       final price = double.tryParse(priceStr) ?? 0.0;
// // //       return sum + price;
// // //     });
// // //   }

// // //   Widget _buildAddItem(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         _showAddItemDialog(context);
// // //       },
// // //       child: Container(
// // //         margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
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
// // //     String price,
// // //   ) {
// // //     final textLength = (itemName + quantity).length;
// // //     final containerHeight = textLength > 20 ? 80.0 : 60.0;

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
// // //                               'is_done': value,
// // //                               'edit_time': Timestamp.now(),
// // //                               'is_edited': true,
// // //                             });
// // //                         _fetchAllTeamData(); // Refresh data
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
// // //                       _showEditItemDialog(context, docId, itemName, quantity, price);
// // //                     },
// // //                   ),
// // //                 if (!isDone)
// // //                   IconButton(
// // //                     icon: Icon(Icons.delete, size: 20),
// // //                     onPressed: () {
// // //                       _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
// // //                     },
// // //                   ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   void _addItemToFirestore(String itemName, String quantity) async {
// // //     try {
// // //       final user = _currentUser;
// // //       final userName = user?.displayName ?? user?.email ?? 'Unknown';
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
// // //       _fetchAllTeamData(); // Refresh data
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

// // //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
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
// // //                           'item_name': editedItemName,
// // //                           'quantity': editedQuantity,
// // //                           'edit_time': Timestamp.now(),
// // //                           'is_edited': true,
// // //                         });
// // //                     Navigator.pop(context);
// // //                     _fetchAllTeamData(); // Refresh data
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
// // //     String price,
// // //   ) async {
// // //     try {
// // //       final deletedItem = {
// // //         'add_time': Timestamp.now(),
// // //         'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// // //         'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// // //         'edit_time': null,
// // //         'is_done': isDone,
// // //         'is_edited': false,
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

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           content: Text('Item "$itemName" deleted'),
// // //           action: SnackBarAction(
// // //             label: 'Undo',
// // //             onPressed: () async {
// // //               try {
// // //                 await FirebaseFirestore.instance
// // //                     .collection('teams')
// // //                     .doc(TeamManager().currentTeamId)
// // //                     .collection('self_items')
// // //                     .add(deletedItem);
// // //                 _fetchAllTeamData(); // Refresh data
// // //               } catch (e) {
// // //                 print('Error undoing delete: $e');
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   SnackBar(content: Text('Error undoing delete: $e')),
// // //                 );
// // //               }
// // //             },
// // //           ),
// // //           duration: Duration(seconds: 5),
// // //         ),
// // //       );
// // //       _fetchAllTeamData(); // Refresh data
// // //     } catch (e) {
// // //       print('Error deleting item: $e');
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Error deleting item: $e')),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
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
// // //               Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// // //                 child: TextField(
// // //                   decoration: InputDecoration(
// // //                     hintText: 'Search',
// // //                     prefixIcon: Icon(Icons.search),
// // //                     filled: true,
// // //                     fillColor: Colors.white,
// // //                     border: OutlineInputBorder(
// // //                       borderRadius: BorderRadius.circular(10),
// // //                       borderSide: BorderSide.none,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               SizedBox(height: 20),
// // //               Expanded(
// // //                 child: _isLoading
// // //                     ? Center(child: CircularProgressIndicator())
// // //                     : _teamData.isEmpty
// // //                         ? Center(child: Text('No gatherings yet'))
// // //                         : ListView.builder(
// // //                             padding: EdgeInsets.all(16.0),
// // //                             itemCount: _teamData.length,
// // //                             itemBuilder: (context, index) {
// // //                               final teamId = _teamData.keys.elementAt(index);
// // //                               final team = _teamData[teamId]!;
// // //                               final teamName = team['name'] as String;
// // //                               final isSelf = team['isSelf'] as bool;
// // //                               final items = _teamItems[teamId] ?? [];
// // //                               final estimatedCost = _calculateEstimatedCost(teamId);
// // //                               return Column(
// // //                                 children: [
// // //                                   GestureDetector(
// // //                                     onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
// // //                                     child: Container(
// // //                                       padding: EdgeInsets.all(12),
// // //                                       decoration: BoxDecoration(
// // //                                         color: Colors.white,
// // //                                         borderRadius: BorderRadius.circular(10),
// // //                                         boxShadow: [
// // //                                           BoxShadow(
// // //                                             color: Colors.grey.withOpacity(0.3),
// // //                                             spreadRadius: 2,
// // //                                             blurRadius: 5,
// // //                                             offset: Offset(0, 3),
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                       child: Row(
// // //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                                         children: [
// // //                                           Text(
// // //                                             teamName,
// // //                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                                           ),
// // //                                           Icon(
// // //                                             _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                   AnimatedSize(
// // //                                     duration: Duration(milliseconds: 300),
// // //                                     curve: Curves.easeInOut,
// // //                                     child: _expandedTeamId == teamId
// // //                                         ? Container(
// // //                                             padding: EdgeInsets.all(16),
// // //                                             child: Column(
// // //                                               children: [
// // //                                                 Row(
// // //                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                                                   children: [
// // //                                                     Text(
// // //                                                       'Grocery List',
// // //                                                       style: TextStyle(fontSize: 14, color: Colors.grey),
// // //                                                     ),
// // //                                                     Text(
// // //                                                       'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
// // //                                                       style: TextStyle(fontSize: 14, color: Colors.black),
// // //                                                     ),
// // //                                                   ],
// // //                                                 ),
// // //                                                 SizedBox(height: 8),
// // //                                                 _buildAddItem(context),
// // //                                                 Column(
// // //                                                   children: items.map<Widget>((doc) {
// // //                                                     final data = doc.data() as Map<String, dynamic>;
// // //                                                     final docId = doc.id;
// // //                                                     final itemName = data['item_name'] ?? '';
// // //                                                     final quantity = data['quantity'] ?? '';
// // //                                                     final isDone = data['is_done'] ?? false;
// // //                                                     final price = data['price'] ?? 'Rs. 0';
// // //                                                     return _buildListItem(
// // //                                                       docId,
// // //                                                       itemName,
// // //                                                       quantity,
// // //                                                       isDone,
// // //                                                       price,
// // //                                                     );
// // //                                                   }).toList(),
// // //                                                 ),
// // //                                               ],
// // //                                             ),
// // //                                           )
// // //                                         : SizedBox.shrink(),
// // //                                   ),
// // //                                   SizedBox(height: 16), // Add spacing between teams
// // //                                 ],
// // //                               );
// // //                             },
// // //                           ),
// // //               ),
// // //             ],
// // //           ),
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
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../service/mic.dart';
// // import '../widgets/greet.dart';
// // import '../service/handle_teams.dart';

// // class ListingPage extends StatefulWidget {
// //   const ListingPage({super.key});

// //   @override
// //   _ListingPageState createState() => _ListingPageState();
// // }

// // class _ListingPageState extends State<ListingPage> {
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// //   final MicService _micService = MicService();
// //   bool _micActive = false;
// //   Map<String, Map<String, dynamic>> _teamData = {}; // Store team data (id, name, isSelf)
// //   Map<String, List<QueryDocumentSnapshot>> _teamItems = {}; // Store items per team
// //   String? _expandedTeamId; // Track the currently expanded team
// //   bool _isLoading = true;
// //   final User? _currentUser = FirebaseAuth.instance.currentUser;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchAllTeamData();
// //   }

// //   Future<void> _fetchAllTeamData() async {
// //     final user = _currentUser;
// //     if (user == null) {
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     try {
// //       // Fetch teams from current_teams
// //       final currentTeamsSnapshot = await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(user.uid)
// //           .collection('current_teams')
// //           .get();

// //       final teamData = <String, Map<String, dynamic>>{};
// //       final teamItems = <String, List<QueryDocumentSnapshot>>{};

// //       // Process current_teams
// //       for (final doc in currentTeamsSnapshot.docs) {
// //         final data = doc.data();
// //         teamData[doc.id] = {
// //           'teamId': doc.id,
// //           'name': data['name'] ?? 'Unnamed Team',
// //           'isSelf': false,
// //         };
// //       }

// //       // Check for "Self" team if not in current_teams
// //       final selfTeamSnapshot = await FirebaseFirestore.instance
// //           .collection('teams')
// //           .where('admin', isEqualTo: user.uid)
// //           .where('isSelf', isEqualTo: true)
// //           .get();

// //       if (selfTeamSnapshot.docs.isNotEmpty) {
// //         final selfTeam = selfTeamSnapshot.docs.first;
// //         final selfTeamId = selfTeam.id;
// //         if (!teamData.containsKey(selfTeamId)) {
// //           teamData[selfTeamId] = {
// //             'teamId': selfTeamId,
// //             'name': selfTeam['name'] ?? 'Self',
// //             'isSelf': true,
// //           };
// //         }
// //       }

// //       // Fetch items for each team
// //       for (final teamId in teamData.keys) {
// //         final itemsSnapshot = await FirebaseFirestore.instance
// //             .collection('teams')
// //             .doc(teamId)
// //             .collection('self_items')
// //             .get();
// //         teamItems[teamId] = itemsSnapshot.docs;
// //       }

// //       setState(() {
// //         _teamData = teamData;
// //         _teamItems = teamItems;
// //         _isLoading = false;
// //       });
// //     } catch (e) {
// //       print('Error fetching team data: $e');
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
// //     setState(() {
// //       if (_expandedTeamId == teamId) {
// //         _expandedTeamId = null; // Collapse if already expanded
// //       } else {
// //         _expandedTeamId = teamId; // Expand new team
// //         TeamManager().setCurrentTeam(teamId, teamName, context);
// //       }
// //     });
// //   }

// //   double _calculateEstimatedCost(String teamId) {
// //     final items = _teamItems[teamId] ?? [];
// //     return items.fold(0.0, (sum, doc) {
// //       final data = doc.data() as Map<String, dynamic>;
// //       final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
// //       final price = double.tryParse(priceStr) ?? 0.0;
// //       return sum + price;
// //     });
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
// //           crossAxisAlignment: CrossAxisAlignment.center,
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
// //     String price,
// //   ) {
// //     final textLength = (itemName + quantity).length;
// //     final containerHeight = textLength > 20 ? 80.0 : 60.0;

// //     return Container(
// //       margin: EdgeInsets.only(bottom: 10),
// //       height: containerHeight,
// //       padding: EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: isDone ? Colors.green[200] : Colors.blue[100],
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Checkbox(
// //             value: isDone,
// //             onChanged: (value) async {
// //               if (value != null) {
// //                 try {
// //                   await FirebaseFirestore.instance
// //                       .collection('teams')
// //                       .doc(TeamManager().currentTeamId)
// //                       .collection('self_items')
// //                       .doc(docId)
// //                       .update({
// //                         'is_done': value,
// //                         'edit_time': Timestamp.now(),
// //                         'is_edited': true,
// //                       });
// //                   _fetchAllTeamData(); // Refresh data
// //                 } catch (e) {
// //                   print('Error updating is_done: $e');
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(content: Text('Error updating item: $e')),
// //                   );
// //                 }
// //               }
// //             },
// //           ),
// //           Expanded(
// //             child: Text(
// //               '$itemName - $quantity',
// //               style: TextStyle(
// //                 decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
// //                 fontSize: 16,
// //               ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //           ),
// //           SizedBox(width: 10),
// //           Text(
// //             '$price',
// //             style: TextStyle(fontSize: 14, color: Colors.black),
// //           ),
// //           if (!isDone)
// //             Row(
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.edit, size: 20),
// //                   onPressed: () {
// //                     _showEditItemDialog(context, docId, itemName, quantity, price);
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.delete, size: 20),
// //                   onPressed: () {
// //                     _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
// //                   },
// //                 ),
// //               ],
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _addItemToFirestore(String itemName, String quantity) async {
// //     try {
// //       final user = _currentUser;
// //       final userName = user?.displayName ?? user?.email ?? 'Unknown';
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
// //       _fetchAllTeamData(); // Refresh data
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

// //   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
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
// //                     _fetchAllTeamData(); // Refresh data
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
// //     String price,
// //   ) async {
// //     try {
// //       final deletedItem = {
// //         'add_time': Timestamp.now(),
// //         'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// //         'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// //         'edit_time': null,
// //         'is_done': isDone,
// //         'is_edited': false,
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

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Item "$itemName" deleted'),
// //           action: SnackBarAction(
// //             label: 'Undo',
// //             onPressed: () async {
// //               try {
// //                 await FirebaseFirestore.instance
// //                     .collection('teams')
// //                     .doc(TeamManager().currentTeamId)
// //                     .collection('self_items')
// //                     .add(deletedItem);
// //                 _fetchAllTeamData(); // Refresh data
// //               } catch (e) {
// //                 print('Error undoing delete: $e');
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Error undoing delete: $e')),
// //                 );
// //               }
// //             },
// //           ),
// //           duration: Duration(seconds: 5),
// //         ),
// //       );
// //       _fetchAllTeamData(); // Refresh data
// //     } catch (e) {
// //       print('Error deleting item: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error deleting item: $e')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
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
// //               Expanded(
// //                 child: _isLoading
// //                     ? Center(child: CircularProgressIndicator())
// //                     : _teamData.isEmpty
// //                         ? Center(child: Text('No gatherings yet'))
// //                         : ListView.builder(
// //                             padding: EdgeInsets.all(16.0),
// //                             itemCount: _teamData.length,
// //                             itemBuilder: (context, index) {
// //                               final teamId = _teamData.keys.elementAt(index);
// //                               final team = _teamData[teamId]!;
// //                               final teamName = team['name'] as String;
// //                               final isSelf = team['isSelf'] as bool;
// //                               final items = _teamItems[teamId] ?? [];
// //                               final estimatedCost = _calculateEstimatedCost(teamId);
// //                               return Column(
// //                                 children: [
// //                                   GestureDetector(
// //                                     onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
// //                                     child: Container(
// //                                       padding: EdgeInsets.all(12),
// //                                       decoration: BoxDecoration(
// //                                         color: Colors.white,
// //                                         borderRadius: BorderRadius.circular(10),
// //                                         boxShadow: [
// //                                           BoxShadow(
// //                                             color: Colors.grey.withOpacity(0.3),
// //                                             spreadRadius: 2,
// //                                             blurRadius: 5,
// //                                             offset: Offset(0, 3),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       child: Row(
// //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           Text(
// //                                             teamName,
// //                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                                           ),
// //                                           Icon(
// //                                             _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   AnimatedSize(
// //                                     duration: Duration(milliseconds: 300),
// //                                     curve: Curves.easeInOut,
// //                                     child: _expandedTeamId == teamId
// //                                         ? Container(
// //                                             padding: EdgeInsets.all(16),
// //                                             child: Expanded(
// //                                               child: SingleChildScrollView(
// //                                                 child: Column(
// //                                                   children: [
// //                                                     Row(
// //                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                                       children: [
// //                                                         Text(
// //                                                           'Grocery List',
// //                                                           style: TextStyle(fontSize: 14, color: Colors.grey),
// //                                                         ),
// //                                                         Text(
// //                                                           'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
// //                                                           style: TextStyle(fontSize: 14, color: Colors.black),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     SizedBox(height: 8),
// //                                                     _buildAddItem(context),
// //                                                     Column(
// //                                                       children: items.map<Widget>((doc) {
// //                                                         final data = doc.data() as Map<String, dynamic>;
// //                                                         final docId = doc.id;
// //                                                         final itemName = data['item_name'] ?? '';
// //                                                         final quantity = data['quantity'] ?? '';
// //                                                         final isDone = data['is_done'] ?? false;
// //                                                         final price = data['price'] ?? 'Rs. 0';
// //                                                         return _buildListItem(
// //                                                           docId,
// //                                                           itemName,
// //                                                           quantity,
// //                                                           isDone,
// //                                                           price,
// //                                                         );
// //                                                       }).toList(),
// //                                                     ),
// //                                                   ],
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           )
// //                                         : SizedBox.shrink(),
// //                                   ),
// //                                   SizedBox(height: 16), // Add spacing between teams
// //                                 ],
// //                               );
// //                             },
// //                           ),
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
//   Map<String, Map<String, dynamic>> _teamData = {}; // Store team data (id, name, isSelf)
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
//       // Fetch teams from current_teams
//       final currentTeamsSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('current_teams')
//           .get();

//       final teamData = <String, Map<String, dynamic>>{};
//       final teamItems = <String, List<QueryDocumentSnapshot>>{};

//       // Process current_teams
//       for (final doc in currentTeamsSnapshot.docs) {
//         final data = doc.data();
//         teamData[doc.id] = {
//           'teamId': doc.id,
//           'name': data['name'] ?? 'Unnamed Team',
//           'isSelf': false,
//         };
//       }

//       // Check for "Self" team if not in current_teams
//       final selfTeamSnapshot = await FirebaseFirestore.instance
//           .collection('teams')
//           .where('admin', isEqualTo: user.uid)
//           .where('isSelf', isEqualTo: true)
//           .get();

//       if (selfTeamSnapshot.docs.isNotEmpty) {
//         final selfTeam = selfTeamSnapshot.docs.first;
//         final selfTeamId = selfTeam.id;
//         if (!teamData.containsKey(selfTeamId)) {
//           teamData[selfTeamId] = {
//             'teamId': selfTeamId,
//             'name': selfTeam['name'] ?? 'Self',
//             'isSelf': true,
//           };
//         }
//       }

//       // Fetch items for each team
//       for (final teamId in teamData.keys) {
//         final itemsSnapshot = await FirebaseFirestore.instance
//             .collection('teams')
//             .doc(teamId)
//             .collection('self_items')
//             .get();
//         teamItems[teamId] = itemsSnapshot.docs;
//       }

//       setState(() {
//         _teamData = teamData;
//         _teamItems = teamItems;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching team data: $e');
//       setState(() => _isLoading = false);
//     }
//   }

//   void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
//     setState(() {
//       if (_expandedTeamId == teamId) {
//         _expandedTeamId = null; // Collapse if already expanded
//       } else {
//         _expandedTeamId = teamId; // Expand new team
//         TeamManager().setCurrentTeam(teamId, teamName, context);
//       }
//     });
//   }

//   double _calculateEstimatedCost(String teamId) {
//     final items = _teamItems[teamId] ?? [];
//     return items.fold(0.0, (sum, doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
//       final price = double.tryParse(priceStr) ?? 0.0;
//       return sum + price;
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
//           crossAxisAlignment: CrossAxisAlignment.center,
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
//     String price,
//   ) {
//     final textLength = (itemName + quantity).length;
//     final containerHeight = textLength > 20 ? 80.0 : 60.0;
//     final maxItemNameLength = 10;
//     final truncatedItemName = itemName.length > maxItemNameLength
//         ? '${itemName.substring(0, maxItemNameLength)}x...'
//         : itemName;

//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       height: containerHeight,
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: isDone ? Colors.green[200] : Colors.blue[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Checkbox(
//             value: isDone,
//             onChanged: (value) async {
//               if (value != null) {
//                 try {
//                   await FirebaseFirestore.instance
//                       .collection('teams')
//                       .doc(TeamManager().currentTeamId)
//                       .collection('self_items')
//                       .doc(docId)
//                       .update({
//                         'is_done': value,
//                         'edit_time': Timestamp.now(),
//                         'is_edited': true,
//                       });
//                   _fetchAllTeamData(); // Refresh data
//                 } catch (e) {
//                   print('Error updating is_done: $e');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error updating item: $e')),
//                   );
//                 }
//               }
//             },
//           ),
//           Expanded(
//             child: Text(
//               '$truncatedItemName - $quantity',
//               style: TextStyle(
//                 decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
//                 fontSize: 16,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           SizedBox(width: 10),
//           Text(
//             '$price',
//             style: TextStyle(fontSize: 14, color: Colors.black),
//           ),
//           if (!isDone)
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit, size: 20),
//                   onPressed: () {
//                     _showEditItemDialog(context, docId, itemName, quantity, price);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete, size: 20),
//                   onPressed: () {
//                     _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
//                   },
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   void _addItemToFirestore(String itemName, String quantity) async {
//     try {
//       final user = _currentUser;
//       final userName = user?.displayName ?? user?.email ?? 'Unknown';
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

//   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
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
//     String price,
//   ) async {
//     try {
//       final deletedItem = {
//         'add_time': Timestamp.now(),
//         'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
//         'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
//         'edit_time': null,
//         'is_done': isDone,
//         'is_edited': false,
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
//                     : _teamData.isEmpty
//                         ? Center(child: Text('No gatherings yet'))
//                         : ListView.builder(
//                             padding: EdgeInsets.all(16.0),
//                             itemCount: _teamData.length,
//                             itemBuilder: (context, index) {
//                               final teamId = _teamData.keys.elementAt(index);
//                               final team = _teamData[teamId]!;
//                               final teamName = team['name'] as String;
//                               final isSelf = team['isSelf'] as bool;
//                               final items = _teamItems[teamId] ?? [];
//                               final estimatedCost = _calculateEstimatedCost(teamId);
//                               return Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
//                                     child: Container(
//                                       padding: EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.3),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             teamName,
//                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                           ),
//                                           Icon(
//                                             _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   AnimatedSize(
//                                     duration: Duration(milliseconds: 300),
//                                     curve: Curves.easeInOut,
//                                     child: _expandedTeamId == teamId
//                                         ? Container(
//                                             padding: EdgeInsets.all(16),
//                                             child: SingleChildScrollView(
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         'Grocery List',
//                                                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                                                       ),
//                                                       Text(
//                                                         'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
//                                                         style: TextStyle(fontSize: 14, color: Colors.black),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   SizedBox(height: 8),
//                                                   _buildAddItem(context),
//                                                   Column(
//                                                     children: items.map<Widget>((doc) {
//                                                       final data = doc.data() as Map<String, dynamic>;
//                                                       final docId = doc.id;
//                                                       final itemName = data['item_name'] ?? '';
//                                                       final quantity = data['quantity'] ?? '';
//                                                       final isDone = data['is_done'] ?? false;
//                                                       final price = data['price'] ?? 'Rs. 0';
//                                                       return _buildListItem(
//                                                         docId,
//                                                         itemName,
//                                                         quantity,
//                                                         isDone,
//                                                         price,
//                                                       );
//                                                     }).toList(),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         : SizedBox.shrink(),
//                                   ),
//                                   SizedBox(height: 16), // Add spacing between teams
//                                 ],
//                               );
//                             },
//                           ),
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

  double _calculateEstimatedCost(String teamId) {
    final items = _teamItems[teamId] ?? [];
    return items.fold(0.0, (sum, doc) {
      final data = doc.data() as Map<String, dynamic>;
      final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
      final price = double.tryParse(priceStr) ?? 0.0;
      return sum + price;
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
    final maxItemNameLength = 10;
    final truncatedItemName = itemName.length > maxItemNameLength
        ? '${itemName.substring(0, maxItemNameLength)}x...'
        : itemName;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: containerHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDone ? Colors.green[200] : Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isDone,
            onChanged: (value) async {
              if (value == null) return;
              final currentUserId = _currentUser?.uid;
              if (currentUserId == null) return;

              try {
                final itemRef = FirebaseFirestore.instance
                    .collection('teams')
                    .doc(TeamManager().currentTeamId)
                    .collection('self_items')
                    .doc(docId);
                final itemSnap = await itemRef.get();
                final data = itemSnap.data() as Map<String, dynamic>;
                final lastCheckedBy = data['checked_by'] ?? '';

                if (value && !isDone) {
                  // Checking the item
                  await itemRef.update({
                    'is_done': true,
                    'edit_time': Timestamp.now(),
                    'is_edited': true,
                    'checked_by': currentUserId,
                  });
                } else if (!value && isDone) {
                  // Unchecking the item
                  if (lastCheckedBy == currentUserId) {
                    await itemRef.update({
                      'is_done': false,
                      'edit_time': Timestamp.now(),
                      'is_edited': true,
                      'checked_by': null,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Only the user who checked can uncheck this item.')),
                    );
                    return;
                  }
                }
                _fetchAllTeamData(); // Refresh data
              } catch (e) {
                print('Error updating is_done: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating item: $e')),
                );
              }
            },
          ),
          Expanded(
            child: Text(
              '$truncatedItemName - $quantity',
              style: TextStyle(
                decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$price',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          if (!isDone)
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20),
                  onPressed: () {
                    _showEditItemDialog(context, docId, itemName, quantity, price);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20),
                  onPressed: () {
                    _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
                  },
                ),
              ],
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
        'checked_by': null,
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
                              final estimatedCost = _calculateEstimatedCost(teamId);
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
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Grocery List',
                                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                                      ),
                                                      Text(
                                                        'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
                                                        style: TextStyle(fontSize: 14, color: Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8),
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