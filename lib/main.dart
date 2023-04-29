import 'package:eestech_challenge_2023/home.dart';
import 'package:eestech_challenge_2023/views/Leaderboard/leaderboard.dart';
import 'package:eestech_challenge_2023/login.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //routes: {
      //  '/loaderboard': (context) => const Leaderboard(user, punteggio),
      //},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : const Home(),
    );
  }
}
