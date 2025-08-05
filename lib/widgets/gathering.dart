// // import 'package:flutter/material.dart';

// // class GatheringWidget extends StatelessWidget {
// //   final String teamId;
// //   final String teamName;
// //   final bool isAdmin;
// //   final VoidCallback onTap;

// //   const GatheringWidget({
// //     super.key,
// //     required this.teamId,
// //     required this.teamName,
// //     required this.isAdmin,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //         padding: EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: isAdmin ? Colors.blue[200] : Colors.green[100],
// //           borderRadius: BorderRadius.circular(10),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.3),
// //               spreadRadius: 2,
// //               blurRadius: 5,
// //               offset: Offset(0, 3),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Text(
// //               teamName,
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //             ),
// //             if (isAdmin)
// //               Container(
// //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                 decoration: BoxDecoration(
// //                   color: Colors.blue[600],
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Text(
// //                   'Admin',
// //                   style: TextStyle(color: Colors.white, fontSize: 12),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class GatheringWidget extends StatelessWidget {
//   final String teamId;
//   final String teamName;
//   final bool isAdmin;
//   final bool isSelf; // Added isSelf parameter
//   final VoidCallback onTap;

//   const GatheringWidget({
//     super.key,
//     required this.teamId,
//     required this.teamName,
//     required this.isAdmin,
//     required this.isSelf, // Required parameter
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: isSelf ? Colors.green[100] : Colors.blue[100], // Different color for "Self"
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         title: Text(
//           teamName,
//           style: TextStyle(fontSize: 18),
//         ),
//         trailing: isAdmin && !isSelf
//             ? Icon(Icons.settings, color: Colors.blue[600]) // Manage icon for admin, not "Self"
//             : (isSelf ? null : Icon(Icons.exit_to_app, color: Colors.red[600])), // Leave icon, not for "Self"
//         onTap: onTap,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class GatheringWidget extends StatelessWidget {
  final String teamId;
  final String teamName;
  final bool isAdmin;
  final bool isSelf;
  final bool isCurrent; // Added isCurrent parameter
  final VoidCallback onTap;

  const GatheringWidget({
    super.key,
    required this.teamId,
    required this.teamName,
    required this.isAdmin,
    required this.isSelf,
    required this.isCurrent, // Required parameter
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.green[100] : Colors.blue[100], // Highlight current team
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
      child: ListTile(
        title: Text(
          teamName,
          style: TextStyle(fontSize: 18),
        ),
        trailing: isAdmin && !isSelf
            ? Icon(Icons.settings, color: Colors.blue[600])
            : (!isSelf ? Icon(Icons.exit_to_app, color: Colors.red[600]) : null),
        onTap: onTap,
      ),
    );
  }
}