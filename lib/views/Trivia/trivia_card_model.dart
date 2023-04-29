import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eestech_challenge_2023/views/Trivia/trivia_play.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TriviaCard extends StatefulWidget {
  const TriviaCard({
    Key? key,
    required this.clovers,
    required this.title,
    required this.snapshot,

  }) : super(key: key);

  final int clovers;
  final String title;
  final QueryDocumentSnapshot snapshot;

  @override
  State<TriviaCard> createState() => _TriviaCardState();
}

class _TriviaCardState extends State<TriviaCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ElevatedButton(

          style: ButtonStyle(

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                  )
              )
          ),


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
              Row(
                children: [
                  Text(widget.clovers.toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(FontAwesomeIcons.clover,
                      color: Colors.green,


                    ),
                  ),

                ],
              )

            ],




          ),
        ),

        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  TriviaPlay(snapshot: widget.snapshot),
            ),
          );
        },
      ),
    );

  }
}
