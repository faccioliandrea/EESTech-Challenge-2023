import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eestech_challenge_2023/home.dart';
import 'package:eestech_challenge_2023/views/Leaderboard/leaderboard.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      providers: [EmailAuthProvider()],
      actions: [
        AuthStateChangeAction<UserCreated>((context, state) async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
          final currentUser = FirebaseAuth.instance.currentUser!.uid;
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser)
              .set({
            'clovers': 0,
            'cloversToday': 0,
            'cloversWeek': 0,
            'cloverMonth': 0
          });
        }),
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }),
      ],
    );
  }
}
