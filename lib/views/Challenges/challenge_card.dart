
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;


class ChallengeCard extends StatefulWidget {
  const ChallengeCard({
    Key? key,
    required this.clovers,
    required this.title,
    required this.date,
    required this.target,
    required this.description,

  }) : super(key: key);

  final int clovers;
  final String title;
  final Timestamp date;
  final int target;
  final String description;

  @override
  State<ChallengeCard> createState() => _ChallengeCard();
}

class _ChallengeCard extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
  DocumentReference user = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            return Card(
              color: data["challenges"].contains(widget.title)  ? Color(0xffFF9914): Color(0xff08BDBD),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.title,
                                    style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.description),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container( width: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                  value: widget.target/11,
                                  semanticsLabel: 'Linear progress indicator',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ),            
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                    children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.clovers.toString()),
                        ),
                        Icon(FontAwesomeIcons.clover,
                        color: Colors.green,),
                      ],
                    ),
                  ),
                  
                  Text((widget.date.toDate().difference(DateTime.now()).inDays+1).toString() + " days"),
                ],
              ),   
            ],
          ),
          );   
          }

          return Text("loading");

        }
    ),
    );
  }
}