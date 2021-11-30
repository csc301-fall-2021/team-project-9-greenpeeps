import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_peeps_app/homescreen/pie_diagram.dart';

class PieDiagramPopup extends StatefulWidget {
  const PieDiagramPopup({Key? key}) : super(key: key);

  @override
  _PieDiagramPopupState createState() => _PieDiagramPopupState();
}

class _PieDiagramPopupState extends State<PieDiagramPopup> {
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  // This popup includes a more detailed breakdown of carbon emissions
// (you could use tabs or use a scrollable, etc. to fit more visuals)
  Widget _buildEmissionsPopup(BuildContext context, Color boxColor, String maxEmission) {
    return Dialog(
      backgroundColor: boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 535,
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8)),
            PieDiagram(),
            const Padding(padding: EdgeInsets.all(8)),
            const Text(
                "The category where most of your consumptions come from is: ",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Padding(padding: EdgeInsets.all(2)),
            Text(maxEmission,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const Padding(padding: EdgeInsets.all(8)),
            const Text("Some ways to reduce carbon emissions: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: users,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var userData = snapshot.data;
            var carbonEmissions = userData!['carbonEmissions'];
            double thevalue = 0.0;
            var thekey = 'None';
            carbonEmissions.forEach((k, v) {
              if (v > thevalue) {
                thevalue = v;
                thekey = k;
              }
            });
            return _buildEmissionsPopup(context, _boxColor, thekey.replaceFirst(thekey[0], thekey[0].toUpperCase()));
          } else {
            return _buildEmissionsPopup(context, _boxColor, 'None');
          }
        });
  }
}
