import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/homescreen/pie_diagram.dart';
import 'package:green_peeps_app/homescreen/pie_diagram_popup.dart';

class PieDiagramBox extends StatefulWidget {
  const PieDiagramBox({Key? key}) : super(key: key);

  @override
  _PieDiagramBoxState createState() => _PieDiagramBoxState();
}

class _PieDiagramBoxState extends State<PieDiagramBox> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  Widget _buildThirdBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.all(boxPadding),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Use the minimum space necessary to fit all widgets
                children: <Widget>[
                  const Text(
                    "My Carbon Emissions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  PieDiagram(),
                ],
              ),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible:
                    true, // User can click off the screen to close popup
                context: context,
                builder: (BuildContext context) =>
                    const PieDiagramPopup(),
                useRootNavigator: false,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: boxColor,
              elevation: boxElevation,
              padding: const EdgeInsets.all(0),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildThirdBox(context, _boxPadding, _boxElevation, _boxColor);
  }
}
