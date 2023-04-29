import 'package:eestech_challenge_2023/achievements.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void openLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return Column(
        children: [
          ElevatedButton(
              onPressed: () {
                openLogin(context);
              },
              child: const Text("Login"))
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("List of achievements"),
            ],
          ),
          SizedBox(height: 100, child: Achievements()),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                openLogin(context);
              },
              child: Text("Logout"))
        ],
      );
    }
  }
}
