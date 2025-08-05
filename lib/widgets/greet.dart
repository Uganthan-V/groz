// // import 'package:flutter/material.dart';
// // import 'dart:async';

// // class GreetWidget extends StatefulWidget {
// //   const GreetWidget({super.key});

// //   @override
// //   _GreetWidgetState createState() => _GreetWidgetState();
// // }

// // class _GreetWidgetState extends State<GreetWidget> {
// //   String _currentDay = '';
// //   String _currentDate = '';


// //   @override
// //   void initState() {
// //     super.initState();
// //     _updateDayDate();
// //     // Update every second
// //     const oneSec = Duration(seconds: 1);
// //     Timer.periodic(oneSec, (Timer t) {
// //       if (mounted) {
// //         setState(() {
// //           _updateDayDate();
// //         });
// //       }
// //     });
// //   }

// //   void _updateDayDate() {
// //     final now = DateTime.now();
// //     final day = now.weekday;
// //     final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
// //     final formattedDay = days[day - 1];
// //     final formattedDate = now.day.toString();

// //     _currentDay = formattedDay;
// //     _currentDate = formattedDate;
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.all(16.0),
// //       child: Row(
// //         children: [
// //           CircleAvatar(
// //             radius: 20,
// //             child: Image.network(
// //               'https://via.placeholder.com/150',
// //               width: 40,
// //               height: 40,
// //               fit: BoxFit.cover,
// //               errorBuilder: (context, error, stackTrace) {
// //                 return Icon(Icons.person, size: 40, color: Colors.grey);
// //               },
// //             ),
// //           ),
// //           SizedBox(width: 10),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Good evening, Ivy',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //             ],
// //           ),
// //           Spacer(),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               CircleAvatar(
// //                 radius: 15,
// //                 backgroundColor: Colors.blue[300],
// //                 child: Text(_currentDate, style: TextStyle(color: Colors.white)),
// //               ),
// //               SizedBox(height: 2),
// //               Text(
// //                 _currentDay,
// //                 style: TextStyle(fontSize: 14, color: Colors.grey),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';

// class GreetWidget extends StatefulWidget {
//   const GreetWidget({super.key});

//   @override
//   _GreetWidgetState createState() => _GreetWidgetState();
// }

// class _GreetWidgetState extends State<GreetWidget> {
//   static String _userName = 'Loading...'; // Static to persist across instances
//   static bool _isNameFetched = false; // Flag to avoid refetching
//   String _currentDay = '';
//   String _currentDate = '';
//   String _greeting = 'Good'; // Default greeting

//   @override
//   void initState() {
//     super.initState();
//     if (!_isNameFetched) {
//       _fetchUserName();
//     }
//     _updateDayDate();
//     _updateGreeting();
//     const oneSec = Duration(seconds: 1);
//     Timer.periodic(oneSec, (Timer t) {
//       if (mounted) {
//         setState(() {
//           _updateDayDate();
//           _updateGreeting(); // Update greeting with time
//         });
//       }
//     });
//   }

//   Future<void> _fetchUserName() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null && !_isNameFetched) {
//       try {
//         final userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();
//         if (userDoc.exists) {
//           setState(() {
//             _userName = userDoc.data()?['name'] ?? 'User';
//             _isNameFetched = true; // Set flag after successful fetch
//           });
//         }
//       } catch (e) {
//         print('Error fetching user name: $e');
//         setState(() {
//           _userName = 'User'; // Fallback if fetch fails
//           _isNameFetched = true; // Set flag to avoid retrying
//         });
//       }
//     }
//   }

//   void _updateDayDate() {
//     final now = DateTime.now();
//     final day = now.weekday;
//     final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     final formattedDay = days[day - 1];
//     final formattedDate = now.day.toString();

//     _currentDay = formattedDay;
//     _currentDate = formattedDate;
//   }

//   void _updateGreeting() {
//     final now = DateTime.now();
//     final hour = now.hour;

//     if (hour >= 5 && hour < 12) {
//       _greeting = 'Good morning';
//     } else if (hour >= 12 && hour < 17) {
//       _greeting = 'Good afternoon';
//     } else {
//       _greeting = 'Good evening';
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             child: Image.network(
//               'https://via.placeholder.com/150',
//               width: 40,
//               height: 40,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Icon(Icons.person, size: 40, color: Colors.grey);
//               },
//             ),
//           ),
//           SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '$_greeting, $_userName',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 15,
//                 backgroundColor: Colors.blue[300],
//                 child: Text(_currentDate, style: TextStyle(color: Colors.white)),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 _currentDay,
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../service/handle_teams.dart'; // Adjust the import path as necessary

class GreetWidget extends StatefulWidget {
  const GreetWidget({super.key});

  @override
  _GreetWidgetState createState() => _GreetWidgetState();
}

class _GreetWidgetState extends State<GreetWidget> {
  static String _userName = 'Loading...';
  static bool _isNameFetched = false;
  String _currentDay = '';
  String _currentDate = '';
  String _greeting = 'Good';

  @override
  void initState() {
    super.initState();
    if (!_isNameFetched) {
      _fetchUserName();
    }
    _updateDayDate();
    _updateGreeting();
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      if (mounted) {
        setState(() {
          _updateDayDate();
          _updateGreeting();
        });
      }
    });
  }

  Future<void> _fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !_isNameFetched) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.data()?['name'] ?? 'User';
            _isNameFetched = true;
          });
        }
      } catch (e) {
        print('Error fetching user name: $e');
        setState(() {
          _userName = 'User';
          _isNameFetched = true;
        });
      }
    }
  }

  void _updateDayDate() {
    final now = DateTime.now();
    final day = now.weekday;
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final formattedDay = days[day - 1];
    final formattedDate = now.day.toString();

    _currentDay = formattedDay;
    _currentDate = formattedDate;
  }

  void _updateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _greeting = 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      _greeting = 'Good afternoon';
    } else {
      _greeting = 'Good evening';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamManager = TeamManager();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: Image.network(
              'https://via.placeholder.com/150',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, size: 40, color: Colors.grey);
              },
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_greeting, $_userName (Current: ${teamManager.currentTeamName})',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue[300],
                child: Text(_currentDate, style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 2),
              Text(
                _currentDay,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}