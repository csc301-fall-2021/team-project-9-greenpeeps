import 'package:flutter/material.dart';

class LearnMore extends StatefulWidget {
  const LearnMore({Key? key}) : super(key: key);

  @override
  _LearnMoreState createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        title: const Text("Article of the Day"),
        backgroundColor: Colors.teal.shade900,
      ),
    );
  }
}
