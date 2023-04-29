import 'package:eestech_challenge_2023/design.dart';
import 'package:eestech_challenge_2023/profile.dart';
import 'package:eestech_challenge_2023/views/Challenges/challenges_view.dart';
import 'package:eestech_challenge_2023/views/Leaderboard/leaderboard.dart';
import 'package:eestech_challenge_2023/views/Learn/learn_view.dart';
import 'package:eestech_challenge_2023/views/Trivia/trivia_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Page {
  final String name;
  final IconData iconData;
  final Widget view;
  final int color;

  Page(this.name, this.iconData, this.view, this.color);
}

final list = [
  Page("Challenges", FontAwesomeIcons.rocket, challengesView(), 0xFF29BF12),
  Page("Learn", FontAwesomeIcons.book, LearnView(), 0xFFABFF4F),
  Page("Trivia", FontAwesomeIcons.feather, TriviaView(), 0xFFFF9914),
  Page("Leaderboard", FontAwesomeIcons.bullseye, Leaderboard(), 0xFFF21B3F),
  Page("Profile", FontAwesomeIcons.user, Profile(), 0xFF08BDBD),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final tabBar = const [
    Tab(icon: Icon(Icons.directions_car)),
    Tab(icon: Icon(Icons.directions_transit)),
    Tab(icon: Icon(Icons.directions_bike)),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBar.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(green),
          automaticallyImplyLeading: false,
          title: Text(list.elementAt(selectedIndex).name),
          bottom: list.elementAt(selectedIndex).name == "Leaderboard"
              ? TabBar(
                  tabs: tabBar,
                  isScrollable: true,
                )
              : null,
        ),
        body: list.elementAt(selectedIndex).view,
        bottomNavigationBar: BottomNavigationBar(
          items: list
              .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData), label: e.name))
              .toList(),
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
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
