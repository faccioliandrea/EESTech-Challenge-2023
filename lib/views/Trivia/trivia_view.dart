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
    CollectionReference trivia =
        FirebaseFirestore.instance.collection('Trivia');
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FutureBuilder(
          future: trivia.get(),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TriviaCard(

                    snapshot: snapshot.data!.docs[index],
                  ),
                );
              },
            );
          }),
    );
  }
}
