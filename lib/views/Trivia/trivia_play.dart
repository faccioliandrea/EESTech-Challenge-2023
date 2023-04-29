import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../dialogs/generic_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class TriviaPlay extends StatefulWidget {
  const TriviaPlay({Key? key,
    required this.snapshot

  }) : super(key: key);
  final QueryDocumentSnapshot snapshot;

  @override
  State<TriviaPlay> createState() => _TriviaPlayState();
}

class _TriviaPlayState extends State<TriviaPlay> {
  int? answer = null;
  Color selectedColor = Colors.blue;
  bool answered = false;
  int points= 0;
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: widget.snapshot["questions"].length,
                physics: NeverScrollableScrollPhysics(),
                controller: controller,

              itemBuilder: (context, index) {

                int correct = widget.snapshot["questions"][index]["answer"];




                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.snapshot["questions"][index]["question"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder:(context, index2){


                        return RadioListTile(
                          activeColor: selectedColor,

                        value: index2,
                        groupValue: answer,
                        onChanged: (value) {
                            if(!answered){
                              setState(() => answer = value);
                            }

                        },

                            title: Text(widget.snapshot["questions"][index]["answers"][index2].toString()),

                        );

                      },
                ),
                  if(!answered)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: answer!= null ? MaterialStatePropertyAll<Color>(Colors.blue) : MaterialStatePropertyAll<Color>(Colors.grey),

                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),

                                      )
                                  )
                              ),
                              onPressed: (){
                                answered=true;

                                if(correct==answer){


                                  setState(() {
                                    selectedColor= Colors.green;
                                    points++;
                                  });


                                } else{
                                  setState(() {
                                    selectedColor= Colors.red;
                                  });
                                }


                              },
                              child: Text("Conferma",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if(answered)
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(

                              style: ButtonStyle(

                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),


                                      )
                                  )
                              ),
                              onPressed: (){

                                // update user balance and completed trivia
                                if(controller.page==widget.snapshot["questions"].length-1){
                                  FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                      {"clovers":  FieldValue.increment(widget.snapshot["clovers"]),
                                        "trivia": {
                                          "${widget.snapshot.id}" ,
                                        }
                                      });
                                  showGenericDialog(
                                    context: context,
                                    title: "Trivia completato!",
                                    content: "Hai risposto correttamente a ${points} domanda. Ti abbiamo accreditato ${widget.snapshot["clovers"]} quadrifogli.",
                                    optionsBuilder: ()=>{
                                      "Chiudi":false,

                                    },
                                  ).then((value)  {
                                    value ?? false;
                                    Navigator.pop(context);
                                  });
                                }
                                // reset answer state for next question
                                 answer = null;
                                 selectedColor = Colors.blue;
                                 answered = false;
                                controller.nextPage(duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);


                              },
                              child: Text("Avanti",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Risposte esatte:",
                        style: TextStyle(
                          fontSize: 19
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 8)),
                      Text(points.toString(),
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                            fontSize: 19
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
