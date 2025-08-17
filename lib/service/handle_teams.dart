
// // import 'package:flutter/material.dart';

// // class TeamManager {
// //   static final TeamManager _instance = TeamManager._internal();
// //   factory TeamManager() => _instance;
// //   TeamManager._internal();

// //   String _currentTeamId = '';
// //   String _currentTeamName = 'Self'; // Default to "Self"

// //   String get currentTeamId => _currentTeamId;
// //   String get currentTeamName => _currentTeamName;

// //   void setCurrentTeam(String teamId, String teamName, BuildContext context) {
// //     _currentTeamId = teamId;
// //     _currentTeamName = teamName;
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Switched to $teamName mode')),
// //     );
// //   }

// //   void resetTeam() {
// //     _currentTeamId = '';
// //     _currentTeamName = 'Self'; // Reset to default
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class TeamManager {
//   static final TeamManager _instance = TeamManager._internal();
//   factory TeamManager() => _instance;
//   TeamManager._internal();

//   String? _currentTeamId;
//   String? _currentTeamName;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final User? _currentUser = FirebaseAuth.instance.currentUser;

//   // Map to store team data (teamId -> {name: String, isSelf: bool})
//   final Map<String, Map<String, dynamic>> _teamData = {};

//   // Getter for teamData
//   Map<String, Map<String, dynamic>> get teamData => _teamData;

//   Future<void> setCurrentTeam(String teamId, String teamName, BuildContext context) async {
//     _currentTeamId = teamId;
//     _currentTeamName = teamName;
//     await _updateUserTeamData(teamId);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Switched to team: $teamName')),
//     );
//   }

//   String? get currentTeamId => _currentTeamId;
//   String? get currentTeamName => _currentTeamName;

//   Future<void> _updateUserTeamData(String teamId) async {
//     if (_currentUser == null) return;

//     try {
//       final currentTeamsSnapshot = await _firestore
//           .collection('users')
//           .doc(_currentUser!.uid)
//           .collection('current_teams')
//           .get();

//       _teamData.clear();
//       for (final doc in currentTeamsSnapshot.docs) {
//         final data = doc.data();
//         _teamData[doc.id] = {
//           'name': data['name'] ?? 'Unnamed Team',
//           'isSelf': false,
//         };
//       }

//       final selfTeamSnapshot = await _firestore
//           .collection('teams')
//           .where('admin', isEqualTo: _currentUser!.uid)
//           .where('isSelf', isEqualTo: true)
//           .get();

//       if (selfTeamSnapshot.docs.isNotEmpty) {
//         final selfTeam = selfTeamSnapshot.docs.first;
//         final selfTeamId = selfTeam.id;
//         if (!_teamData.containsKey(selfTeamId)) {
//           _teamData[selfTeamId] = {
//             'name': selfTeam['name'] ?? 'Self',
//             'isSelf': true,
//           };
//         }
//       }
//     } catch (e) {
//       print('[ERROR] Error updating team data: $e');
//     }
//   }

//   // Extension to get team name
//   String getTeamName(String teamId) {
//     return _teamData[teamId]?['name'] ?? 'Unknown Team';
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamManager {
  static final TeamManager _instance = TeamManager._internal();
  factory TeamManager() => _instance;
  TeamManager._internal();

  String? _currentTeamId;
  String? _currentTeamName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  // Map to store team data (teamId -> {name: String, isSelf: bool})
  final Map<String, Map<String, dynamic>> _teamData = {};

  // Getter for teamData
  Map<String, Map<String, dynamic>> get teamData => _teamData;

  Future<void> setCurrentTeam(String teamId, String teamName, BuildContext context) async {
    _currentTeamId = teamId;
    _currentTeamName = teamName;
    await _updateUserTeamData(teamId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Switched to team: $teamName')),
    );
  }

  String? get currentTeamId => _currentTeamId;
  String? get currentTeamName => _currentTeamName;

  // Public method to update team data
  Future<void> updateTeamData([String? teamId]) async {
    await _updateUserTeamData(teamId ?? _currentTeamId ?? '');
  }

  Future<void> _updateUserTeamData(String teamId) async {
    if (_currentUser == null) return;

    try {
      final currentTeamsSnapshot = await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('current_teams')
          .get();

      _teamData.clear();
      for (final doc in currentTeamsSnapshot.docs) {
        final data = doc.data();
        _teamData[doc.id] = {
          'name': data['name'] ?? 'Unnamed Team',
          'isSelf': false,
        };
      }

      final selfTeamSnapshot = await _firestore
          .collection('teams')
          .where('admin', isEqualTo: _currentUser!.uid)
          .where('isSelf', isEqualTo: true)
          .get();

      if (selfTeamSnapshot.docs.isNotEmpty) {
        final selfTeam = selfTeamSnapshot.docs.first;
        final selfTeamId = selfTeam.id;
        if (!_teamData.containsKey(selfTeamId)) {
          _teamData[selfTeamId] = {
            'name': selfTeam['name'] ?? 'Self',
            'isSelf': true,
          };
        }
      }
    } catch (e) {
      print('[ERROR] Error updating team data: $e');
    }
  }

  // Extension to get team name
  String getTeamName(String teamId) {
    return _teamData[teamId]?['name'] ?? 'Unknown Team';
  }
}