


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/listing_page.dart';
import 'pages/notify_page.dart';
import 'pages/account_page.dart';
import 'widgets/navibar.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable Firestore offline persistence
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // Set transparent status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
    statusBarIconBrightness: Brightness.light, // Light icons for gradient
    statusBarBrightness: Brightness.dark, // iOS specific, use dark for contrast
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthCheck(), debugShowCheckedModeBanner: false);
  }
}

class AuthCheck extends StatefulWidget {
  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _isLoading = true;
  Widget? _initialScreen;
  int _selectedIndex = 0; // Start with HomePage (index 0)

  final List<Widget> _pages = <Widget>[
    HomePage(),
    ListingPage(),
    NotifyPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentUser = FirebaseAuth.instance.currentUser;
      final deviceId = await _getDeviceId();

      print('Current User: $currentUser, Device ID: $deviceId'); // Debug log

      if (currentUser == null) {
        setState(() {
          _initialScreen = LoginPage(onLogin: _onLogin);
          _isLoading = false;
        });
        return;
      }

      final storedDeviceId = prefs.getString('device_id');
      final loginTimestamp = prefs.getInt('login_timestamp');

      print('Stored Device ID: $storedDeviceId, Login Timestamp: $loginTimestamp'); // Debug log

      if (storedDeviceId == null || storedDeviceId != deviceId) {
        await FirebaseAuth.instance.signOut();
        await prefs.clear();
        setState(() {
          _initialScreen = LoginPage(onLogin: _onLogin);
          _isLoading = false;
        });
        return;
      }

      if (loginTimestamp != null) {
        final loginDate = DateTime.fromMillisecondsSinceEpoch(loginTimestamp);
        final now = DateTime.now();
        final difference = now.difference(loginDate).inDays;

        print('Days since login: $difference'); // Debug log

        if (difference > 30) {
          // Refresh timestamp to extend session
          await prefs.setInt('login_timestamp', now.millisecondsSinceEpoch);
        }
      } else {
        // Set initial timestamp if none exists
        await prefs.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);
      }

      // Force token refresh to ensure session validity
      await currentUser.getIdToken(true);

      setState(() {
        _initialScreen = NaviBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          pages: _pages,
        );
        _isLoading = false;
      });
    } catch (e) {
      print('Error checking auth status: $e');
      setState(() {
        _initialScreen = LoginPage(onLogin: _onLogin);
        _isLoading = false;
      });
    }
  }

  Future<String> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? 'unknown_android_${DateTime.now().millisecondsSinceEpoch}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown_ios_${DateTime.now().millisecondsSinceEpoch}';
      } else {
        return 'web_${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (e) {
      print('Error getting device ID: $e');
      return 'unknown_device_${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  void _onLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final deviceId = await _getDeviceId();
      await prefs.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);
      await prefs.setString('device_id', deviceId);

      setState(() {
        _selectedIndex = 0; // Start with HomePage
        _initialScreen = NaviBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          pages: _pages,
        );
      });
    } catch (e) {
      print('Error saving login data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error after login: $e')));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
        ),
      ),
      child: SafeArea(
        child: _initialScreen!,
        top: true,
        bottom: false,
        maintainBottomViewPadding: false,
      ),
    );
  }
}
