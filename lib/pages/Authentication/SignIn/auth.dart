import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../DashBoard/dashboard.dart';
import '../Home/home.dart';
import 'SignIn/PhoneNumberSignIn.dart';
import 'SignIn/sign_in.dart';

class SignInWrapper extends StatefulWidget {
  const SignInWrapper({Key? key}) : super(key: key);

  @override
  State<SignInWrapper> createState() => _SignInWrapperState();
}

class _SignInWrapperState extends State<SignInWrapper> {
  Future<DocumentSnapshot>? _userDataFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user != null) {
              // Fetch user data from Firestore
              _userDataFuture = FirebaseFirestore.instance.collection('users').doc(user.uid).get();

              return FutureBuilder<DocumentSnapshot>(
                future: _userDataFuture,
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (userSnapshot.hasData) {
                    final userData = userSnapshot.data;
                    if (userData != null) {
                      return DashboardScreen(userData: userData);
                    }
                  }

                  return Center(child: Text('No user data available'));
                },
              );
            }
          }

          return SignIn();
        },
      ),
    );
  }
}