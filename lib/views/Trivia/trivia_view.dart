import 'package:eestech_challenge_2023/views/Trivia/trivia_card_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TriviaView extends StatefulWidget {
  const TriviaView({Key? key}) : super(key: key);

  @override
  State<TriviaView> createState() => _TriviaViewState();
}

class _TriviaViewState extends State<TriviaView> {

  @override
  Widget build(BuildContext context) {
    CollectionReference trivia = FirebaseFirestore.instance.collection('Trivia');
    return Scaffold(
      body: FutureBuilder(
        future: trivia.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return TriviaCard(
                title: snapshot.data!.docs[0]["title"],
                clovers: snapshot.data!.docs[0]["clovers"],

              );
            },
          );






        }
      ),
    );
  }
}
