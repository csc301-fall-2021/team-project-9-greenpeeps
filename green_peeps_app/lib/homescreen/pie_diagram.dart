import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Map<String, double> carbonEmissions = {
  "Food": 0,
  "Electricity": 0,
  "Water": 0,
  "Transportation": 0,
};

class PieDiagram extends StatelessWidget {
  PieDiagram({Key? key}) : super(key: key);

  final List<Color> _pieChartColors = <Color>[
    Colors.red,
    Colors.yellow.shade700,
    Colors.teal,
    Colors.purple,
    Colors.pink.shade200,
    Colors.green,
    Colors.brown,
    Colors.grey,
  ];

  Map<String, double> carbonEmissions = {
    "Food": 0,
    "Electricity": 0,
    "Transportation": 0,
  };

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

          // Load user data into pie chart
          if (userData!.data().toString().contains('carbonEmissions') ==
              false) {
            carbonEmissions = {
              "Food": 0,
              "Electricity": 0,
              "Transportation": 0,
            };
          } else {
            carbonEmissions = {};
            Map<String, num> temp =
                Map<String, num>.from(userData['carbonEmissions']);
            for (String keyName in temp.keys) {
              carbonEmissions[keyName] = temp[keyName]!.toDouble();
            }
          }

          return PieChart(
            dataMap: carbonEmissions,
            chartLegendSpacing: 25,
            chartRadius: MediaQuery.of(context).size.width /
                2, // Half the width of the screen
            colorList: _pieChartColors,
            legendOptions: const LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              legendTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          );
        } else {
          return PieChart(
            dataMap: carbonEmissions,
            chartLegendSpacing: 25,
            chartRadius: MediaQuery.of(context).size.width /
                2, // Half the width of the screen
            colorList: _pieChartColors,
            legendOptions: const LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              legendTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          );
        }
      },
    );
  }
}
