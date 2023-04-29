import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eestech_challenge_2023/views/Trivia/trivia_play.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class TriviaCard extends StatefulWidget {
  const TriviaCard({
    Key? key,

    required this.snapshot,

  }) : super(key: key);


  final QueryDocumentSnapshot snapshot;

  @override
  State<TriviaCard> createState() => _TriviaCardState();
}

class _TriviaCardState extends State<TriviaCard> {
  @override
  Widget build(BuildContext context) {
    DocumentReference user = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    return SizedBox(
      height: 75,
      child: FutureBuilder(
        future: user.get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return ElevatedButton(


              style: ButtonStyle(
                  backgroundColor: data["trivia"].contains(widget.snapshot.id)  ? MaterialStatePropertyAll<Color>(Color(0xffFF9914)) : MaterialStatePropertyAll<Color>(Color(0xff08BDBD)),

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.snapshot["title"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                        if(data["trivia"].contains(widget.snapshot.id) )
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Completato",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),
                            ),
                          ),

                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.snapshot["clovers"].toString(),
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
            );
          }

          return Text("loading");

        }
      ),
    );

  }
}
