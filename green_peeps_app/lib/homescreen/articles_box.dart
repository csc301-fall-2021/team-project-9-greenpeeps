import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ArticlesBox extends StatefulWidget {
  const ArticlesBox({Key? key}) : super(key: key);

  @override
  _ArticlesBoxState createState() => _ArticlesBoxState();
}

class _ArticlesBoxState extends State<ArticlesBox> {
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildArticlesBox(
    BuildContext context, 
    double boxPadding,
    double boxElevation, 
    Color boxColor) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
            color: boxColor,
            elevation: boxElevation,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: const Text(
                "Articles: Learn about climate change",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return _buildArticlesBox(context, _boxPadding, _boxElevation, _boxColor);
  }
}

