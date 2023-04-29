import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eestech_challenge_2023/views/Trivia/trivia_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:convert';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    final learning = FirebaseFirestore.instance.collection('Learning');
    return FutureBuilder<QuerySnapshot>(
      future: learning.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //final data = snapshot.data.docs.
          return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Lesson(
                                    text: snapshot.data!.docs[index]['text'],
                                    trivia: snapshot.data!.docs[index]
                                        ['trivia'],
                                    title: snapshot.data!.docs[index].id,
                                  )),
                        );
                      },
                      child:
                          ListTile(title: Text(snapshot.data!.docs[index].id))),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Lesson extends StatelessWidget {
  const Lesson(
      {super.key,
      required this.text,
      required this.trivia,
      required this.title});

  final String title;
  final String text;
  final String trivia;

  @override
  Widget build(BuildContext context) {
    final decodedText = utf8.decode(base64.decode(text));

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              MarkdownBody(
                data: decodedText,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TriviaView()),
                  );
                },
                child: Text("Start Trivia about this lesson!"),
                style: ButtonStyle(
                    backgroundColor:  MaterialStatePropertyAll<Color>(Color(0xffF21B3F)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),

                        )
                    )
                ),
              )
            ],
          ),
        ));
  }
}
