import 'package:eestech_challenge_2023/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});

  final board = ListView.builder(
      itemCount: people.length,
      itemBuilder: (context, index) {
        return Card(
          color: index < 3 ? const Color(red) : null,
          child: ListTile(
            title: Row(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        people.elementAt(index).clovers.toString(),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Icon(
                          FontAwesomeIcons.clover,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(people.elementAt(index).username),
              ],
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TabBarView(
        children: [board, board, board],
      ),
    );
  }
}

final people = [
  Person("reindeerflute", 180),
  Person("thethingdiehard", 166),
  Person("sweetlybeetuba", 120),
  Person("grantorinoflourishing", 111),
  Person("pioneer10romanholiday", 100),
  Person("peaspiecat", 95),
  Person("peasfloral", 65),
  Person("whitebreadintothewild", 58),
  Person("flatbass", 25),
  Person("flatcharon", 24),
];

class Person {
  final String username;
  final int clovers;
  Person(this.username, this.clovers);
}
