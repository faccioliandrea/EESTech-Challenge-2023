import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eestech_challenge_2023/profile.dart';
import 'package:eestech_challenge_2023/views/Challenges/challenges_view.dart';
import 'package:eestech_challenge_2023/views/Learn/learn_view.dart';
import 'package:eestech_challenge_2023/views/Trivia/trivia_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class Page {
  final String name;
  final IconData iconData;
  final Widget view;

  Page(this.name, this.iconData, this.view);
}

final list = [
  Page("Challenge", Icons.home, challengesView()),
  Page("Learn", Icons.school, LearnView()),
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
  late final user = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(list.elementAt(selectedIndex).name),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ElevatedButton(

                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(2),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(right: 8, left: 8)),


                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8) , bottomLeft: Radius.circular(8)),
                          ))),
                  onPressed: () {
                    setState(() {
                      selectedIndex=4;
                    });

                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 15, maxHeight: 15),
                            child: Icon(FontAwesomeIcons.clover, color: Colors.green, size: 16,),
                          ),
                        ),
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: user,
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                              if (snapshot.hasError) {
                                return const Text('error');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;





                              return Text(
                                data['clovers'].toString(),
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade700,
                                  fontSize: data['clovers'] > 10000000 ? 12 : 14,
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: ElevatedButton(


                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(1)),

                        elevation: MaterialStateProperty.all<double>(2),

                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF0197F6)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8) , bottomRight: Radius.circular(8)),
                            ))),
                    onPressed: () {
                      setState(() {
                        selectedIndex=4;
                      });

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
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
