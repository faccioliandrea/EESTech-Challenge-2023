import 'package:eestech_challenge_2023/learning.dart';
import 'package:eestech_challenge_2023/profile.dart';
import 'package:eestech_challenge_2023/views/Challenges/challenges_view.dart';
import 'package:eestech_challenge_2023/views/Trivia/trivia_view.dart';
import 'package:flutter/material.dart';

class Page {
  final String name;
  final IconData iconData;
  final Widget view;

  Page(this.name, this.iconData, this.view);
}

final list = [
  Page("Challenge", Icons.home, challengesView()),
  Page("Learn", Icons.school, Learning()),
  Page("Leaderboard", Icons.school, View()),
  Page("Profile", Icons.school, Profile()),
  Page("Trivia", Icons.question_mark, TriviaView()),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
      ),
      body: list.elementAt(selectedIndex).view,
      bottomNavigationBar: BottomNavigationBar(
        items: list
            .map((e) =>
                BottomNavigationBarItem(icon: Icon(e.iconData), label: e.name))
            .toList(),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}

class View extends StatelessWidget {
  const View({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Hi");
  }
}
