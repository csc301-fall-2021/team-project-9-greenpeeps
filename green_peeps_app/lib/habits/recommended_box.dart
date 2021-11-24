import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedBox extends StatefulWidget {
  const RecommendedBox({Key? key}) : super(key: key);

  @override
  _RecommendedBoxState createState() => _RecommendedBoxState();
}

class _RecommendedBoxState extends State<RecommendedBox> {
  @override 
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
            left: 30, right: 30, top: 15, bottom: 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Recommended",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: const <Widget>[
                      Text("test"),
                      Text("Test2"),
                      Text("test3"),
                    ],
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ),
    );
  }
}