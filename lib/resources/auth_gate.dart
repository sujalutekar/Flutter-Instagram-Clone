import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../pages/instagram_pages.dart';
import '../pages/login_or_signup_page.dart';
import '../providers/user_provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    refreshingUser();
  }

  refreshingUser() async {
    UserProvider _userProvider = Provider.of(context, listen: false);

    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // print(snapshot.data);

        // user logged in
        if (snapshot.hasData) {
          return const InstagramPage();
        }

        // user not logged in
        else {
          return const LoginOrSignUpPage();
        }
      },
    );
  }
}
