import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResourcesBox extends StatefulWidget {
  const ResourcesBox({Key? key}) : super(key: key);

  @override
  _ResourcesBoxState createState() => _ResourcesBoxState();
}

class _ResourcesBoxState extends State<ResourcesBox> {
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildResourcesBox(
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
                "Resources: Learn about climate change",
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

    return _buildResourcesBox(context, _boxPadding, _boxElevation, _boxColor);
  }
}

