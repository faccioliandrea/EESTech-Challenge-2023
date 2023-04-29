import 'package:flutter/material.dart';

class TriviaCard extends StatefulWidget {
  const TriviaCard({
    Key? key,
    required this.clovers,
    required this.title,

  }) : super(key: key);

  final String clovers;
  final String title;

  @override
  State<TriviaCard> createState() => _TriviaCardState();
}

class _TriviaCardState extends State<TriviaCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title),
    );

  }
}
