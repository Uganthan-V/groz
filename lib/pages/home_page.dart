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