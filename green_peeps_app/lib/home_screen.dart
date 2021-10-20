import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// todo: text overflow/ expanding boxes

Map<String, double> pieChartCategories = {
  "Food": 5,
  "Electricity": 3,
  "Water": 2,
  "Transportation": 2,
  ":)": 2,
  ":(": 30,
  ":/": 10,
  ":O": 4
};

List<Color> pieChartColors = <Color>[
  Colors.teal.shade200,
  Colors.teal.shade300,
  Colors.teal.shade400,
  Colors.teal,
  Colors.teal.shade600,
  Colors.teal.shade700,
  Colors.teal.shade800,
  Colors.teal.shade900
];

Widget _buildPopupDialog(BuildContext context, Color boxColor) {
  return Dialog(
      backgroundColor: boxColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 535,
          child: Column(children: <Widget>[
            AppBar(
                backgroundColor: boxColor,
                elevation: 0,
                toolbarHeight: 30,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      color: Colors.black)
                ]),
          ])));
}

Widget _buildFirstWidget(
    BuildContext context,
    double boxHeight,
    double boxPadding,
    double boxElevation,
    Color boxColor,
    String userFirstName) {
  return SliverList(
      delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      return Material(
        elevation: boxElevation,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
            padding: EdgeInsets.all(boxPadding),
            height: boxHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: boxColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Text("Welcome " + userFirstName + "!",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ))),
      );
    },
    childCount: 1,
  ));
}

Widget _buildSecondWidget(
    BuildContext context,
    double boxHeight,
    double boxPadding,
    double boxElevation,
    Color boxColor,
    double progressCompleted,
    int progressLeft) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return ElevatedButton(
            child: Container(
                padding: EdgeInsets.all(boxPadding),
                height: boxHeight,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "You are " +
                              progressLeft.toString() +
                              " points away from your next leaf!",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black)),
                      Divider(color: boxColor),
                      const Text("Answer More Questions",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "Nunito")),
                      Divider(color: boxColor),
                      LinearProgressIndicator(
                        backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                        value: progressCompleted,
                        minHeight: 5,
                      )
                    ])),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, boxColor),
              );
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: boxColor,
                fixedSize: const Size(330, 145),
                elevation: boxElevation));
      },
      childCount: 1,
    ),
  );
}

Widget _buildThirdWidget(BuildContext context, double boxPadding,
    double boxElevation, Color boxColor) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return ElevatedButton(
            child: Container(
                padding: EdgeInsets.all(boxPadding),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("My Carbon Emissions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      PieChart(
                        dataMap: pieChartCategories,
                        chartLegendSpacing: 50,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        colorList: pieChartColors,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.bottom,
                            legendTextStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                      )
                    ])),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: boxColor,
                elevation: boxElevation));
      },
      childCount: 1,
    ),
  );
}

Widget _buildFourthWidget(BuildContext context, double boxPadding,
    double boxElevation, Color boxColor, String funFact) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Material(
            elevation: boxElevation,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
                padding: EdgeInsets.all(boxPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: boxColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Fun Fact of the Day',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(funFact,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black)),
                      Divider(color: boxColor),
                      Row(children: <Widget>[
                        const Spacer(),
                        TextButton(
                          child: const Text('Learn More'),
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(2, 152, 89, 1),
                              elevation: 5,
                              fixedSize: const Size(146, 42)),
                        )
                      ])
                    ])));
      },
      childCount: 1,
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Box Variables
  double boxPadding = 10.0;
  double boxElevation = 5.0; // The height of shadow beneath box
  Color boxColor = const Color.fromRGBO(248, 244, 219, 1);

  // Database Information
  String userFirstName = "Human";
  double progressCompleted = 0.5; // Must be from 0 to 1
  int progressLeft = 50; // Represented in amount of points
  String funFact =
      "Did you know that some house centipedes are poisonous. Additionally, house centipedes can sometimes regenerate their legs if they have been cut off. Trust me, I know from experience!";

  @override
  Widget build(BuildContext context) {
    return Center(
      // List of scrollable widgets
      // You can customize to space between widgets and height of each widget
      child: CustomScrollView(slivers: <Widget>[
        SliverSafeArea(
            sliver: SliverPadding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 15, bottom: 0),
                sliver: _buildFirstWidget(context, 55.0, boxPadding,
                    boxElevation, boxColor, userFirstName))),
        SliverPadding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 0),
            sliver: _buildSecondWidget(context, 145, boxPadding, boxElevation,
                boxColor, progressCompleted, progressLeft)),
        SliverPadding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 0),
            sliver:
                _buildThirdWidget(context, boxPadding, boxElevation, boxColor)),
        SliverPadding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 25),
            sliver: _buildFourthWidget(
                context, boxPadding, boxElevation, boxColor, funFact)),
      ]),
    );
  }
}
