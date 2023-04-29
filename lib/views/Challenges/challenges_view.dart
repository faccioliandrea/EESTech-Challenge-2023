import 'package:eestech_challenge_2023/views/Challenges/challenge_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class challengesView extends StatefulWidget {
  const challengesView({Key? key}) : super(key: key);

  @override
  State<challengesView> createState() => _challengesView();
}

class _challengesView extends State<challengesView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference challenges =
        FirebaseFirestore.instance.collection('Challenges');
    return Scaffold(
      body: FutureBuilder(
          future: challenges.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return ChallengeCard(
                  title: snapshot.data!.docs[index]["title"],
                  clovers: snapshot.data!.docs[index]["clovers"],
                  target: snapshot.data!.docs[index]["target"],
                  date: snapshot.data!.docs[index]["date"],
                  description: snapshot.data!.docs[index]["description"],
                );
              },
            );
          }),
    );
  }
}
