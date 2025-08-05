// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'signup_page.dart';
// // import 'listing_page.dart';

// // class LoginPage extends StatefulWidget {
// //   final VoidCallback? onLogin;

// //   const LoginPage({Key? key, this.onLogin}) : super(key: key);

// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   void _handleLogin() async {
// //     if (_formKey.currentState!.validate()) {
// //       try {
// //         await FirebaseAuth.instance.signInWithEmailAndPassword(
// //           email: _emailController.text.trim(),
// //           password: _passwordController.text.trim(),
// //         );
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text('Login Successful')));
// //         widget.onLogin?.call(); // Optional callback for navigation
// //         // Navigate to ListingPage
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => ListingPage()),
// //         );
// //       } catch (e) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Login Failed: ${e.toString()}')),
// //         );
// //       }
// //     }
// //   }

// //   void _navigateToSignUp() {
// //     Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// //           ),
// //         ),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             padding: EdgeInsets.symmetric(horizontal: 30.0),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     'Welcome baaaaaaack!',
// //                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text(
// //                     'Log in to existing GROZ account',
// //                     style: TextStyle(color: Colors.grey[600]),
// //                   ),
// //                   SizedBox(height: 40),
// //                   TextFormField(
// //                     controller: _emailController,
// //                     decoration: InputDecoration(
// //                       prefixIcon: Icon(Icons.person),
// //                       hintText: 'Email',
// //                       filled: true,
// //                       fillColor: Colors.grey[200],
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                     ),
// //                     validator: (value) => value == null || value.isEmpty
// //                         ? 'Enter email'
// //                         : (!value.contains('@') ? 'Invalid email' : null),
// //                   ),
// //                   SizedBox(height: 20),
// //                   TextFormField(
// //                     controller: _passwordController,
// //                     obscureText: true,
// //                     decoration: InputDecoration(
// //                       prefixIcon: Icon(Icons.lock),
// //                       hintText: 'Password',
// //                       filled: true,
// //                       fillColor: Colors.grey[200],
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       suffixText: 'Forgot Password?',
// //                       suffixStyle: TextStyle(color: Colors.blue),
// //                     ),
// //                     validator: (value) => value == null || value.length < 6
// //                         ? 'Min 6 chars required'
// //                         : null,
// //                   ),
// //                   SizedBox(height: 30),
// //                   ElevatedButton(
// //                     onPressed: _handleLogin,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.lightBlue[200],
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       padding: EdgeInsets.symmetric(
// //                         horizontal: 100,
// //                         vertical: 15,
// //                       ),
// //                     ),
// //                     child: Text(
// //                       'LOG IN',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Text(
// //                     'Or sign up using',
// //                     style: TextStyle(color: Colors.grey[600]),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       IconButton(
// //                         icon: Image.asset('assets/facebook.png', width: 30),
// //                         onPressed: () {},
// //                       ),
// //                       IconButton(
// //                         icon: Image.asset('assets/google.png', width: 30),
// //                         onPressed: () {},
// //                       ),
// //                       IconButton(
// //                         icon: Image.asset('assets/apple.png', width: 30),
// //                         onPressed: () {},
// //                       ),
// //                     ],
// //                   ),
// //                   TextButton(
// //                     onPressed: _navigateToSignUp,
// //                     child: Text(
// //                       "Don't have an account? Sign Up",
// //                       style: TextStyle(color: Colors.blue),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'signup_page.dart';
// import '../widgets/navibar.dart';
// import 'home_page.dart';
// import 'listing_page.dart';
// import 'notify_page.dart';
// import 'account_page.dart';

// class LoginPage extends StatefulWidget {
//   final VoidCallback? onLogin;

//   const LoginPage({Key? key, this.onLogin}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _handleLogin() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Login Successful')));
//         widget.onLogin
//             ?.call(); // Trigger persistence and navigation in main.dart
//         // Navigate to NaviBar with HomePage as default
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => NaviBar(
//               onTap: (index) {},
//               currentIndex: 0,
//               pages: [HomePage(), ListingPage(), NotifyPage(), AccountPage()],
//             ),
//           ),
//         );
//       } catch (e) {
//         print('Login error: $e');
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Login Failed: $e')));
//       }
//     }
//   }

//   void _navigateToSignUp() {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 30.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Welcome baaaaaaack!',
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Log in to existing GROZ account',
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 40),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.person),
//                       hintText: 'Email',
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Enter email'
//                         : (!value.contains('@') ? 'Invalid email' : null),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.lock),
//                       hintText: 'Password',
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                       suffixText: 'Forgot Password?',
//                       suffixStyle: TextStyle(color: Colors.blue),
//                     ),
//                     validator: (value) => value == null || value.length < 6
//                         ? 'Min 6 chars required'
//                         : null,
//                   ),
//                   SizedBox(height: 30),
//                   ElevatedButton(
//                     onPressed: _handleLogin,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lightBlue[200],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 100,
//                         vertical: 15,
//                       ),
//                     ),
//                     child: Text(
//                       'LOG IN',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Or sign up using',
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Image.asset('assets/facebook.png', width: 30),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: Image.asset('assets/google.png', width: 30),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: Image.asset('assets/apple.png', width: 30),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                   TextButton(
//                     onPressed: _navigateToSignUp,
//                     child: Text(
//                       "Don't have an account? Sign Up",
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import '../widgets/navibar.dart';
import 'home_page.dart';
import 'listing_page.dart';
import 'notify_page.dart';
import 'account_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onLogin;

  const LoginPage({Key? key, this.onLogin}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successful')));
        widget.onLogin?.call(); // Trigger persistence and navigation in main.dart
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NaviBar(
              onTap: (index) {},
              currentIndex: 0,
              pages: [HomePage(), ListingPage(), NotifyPage(), AccountPage()],
            ),
          ),
        );
      } catch (e) {
        print('Login error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: $e')));
      }
    }
  }

  void _navigateToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Add SafeArea to respect notification bar
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome baaaaaaack!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Log in to existing GROZ account',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter email'
                          : (!value.contains('@') ? 'Invalid email' : null),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixText: 'Forgot Password?',
                        suffixStyle: TextStyle(color: Colors.blue),
                      ),
                      validator: (value) => value == null || value.length < 6
                          ? 'Min 6 chars required'
                          : null,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Or sign up using',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/facebook.png', width: 30),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset('assets/google.png', width: 30),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset('assets/apple.png', width: 30),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}