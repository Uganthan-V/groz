import 'package:flutter/material.dart';

class NaviBar extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;
  final List<Widget> pages;

  const NaviBar({super.key, 
    required this.onTap,
    required this.currentIndex,
    required this.pages,
  });

  @override
  _NaviBarState createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda), label: ''),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          widget.onTap(index); // Notify parent to update _selectedIndex
        },
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}