// import 'package:flutter/material.dart';

// class TeamManager {
//   static final TeamManager _instance = TeamManager._internal();
//   factory TeamManager() => _instance;
//   TeamManager._internal();

//   String _currentTeamId = '';
//   String _currentTeamName = 'Self'; // Default to "Self"

//   String get currentTeamId => _currentTeamId;
//   String get currentTeamName => _currentTeamName;

//   void setCurrentTeam(String teamId, String teamName, BuildContext context) {
//     _currentTeamId = teamId;
//     _currentTeamName = teamName;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Switched to $teamName mode')),
//     );
//   }

//   void resetTeam() {
//     _currentTeamId = '';
//     _currentTeamName = 'Self'; // Reset to default
//   }
// }

import 'package:flutter/material.dart';

class TeamManager {
  static final TeamManager _instance = TeamManager._internal();
  factory TeamManager() => _instance;
  TeamManager._internal();

  String _currentTeamId = '';
  String _currentTeamName = 'Self'; // Default to "Self"

  String get currentTeamId => _currentTeamId;
  String get currentTeamName => _currentTeamName;

  void setCurrentTeam(String teamId, String teamName, BuildContext context) {
    _currentTeamId = teamId;
    _currentTeamName = teamName;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Switched to $teamName mode')),
    );
  }

  void resetTeam() {
    _currentTeamId = '';
    _currentTeamName = 'Self'; // Reset to default
  }
}