import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:green_peeps_app/question_popup.dart';

// todo:

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Box Variables
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  // Database Information
  final String _userFirstName = "Human";
  double _progressCompleted = 0.5; // Must be from 0 to 1
  int _progressLeft = 50; // Represented in amount of points
  final String _funFact =
      "Did you know that some house centipedes are poisonous. Additionally, house centipedes can sometimes regenerate their legs if they have been cut off. Trust me, I know from experience!";

  // User's carbon emmissions breakdown from database
  final Map<String, double> _pieChartCategories = {
    "Food": 5,
    "Electricity": 3,
    "Water": 2,
    "Transportation": 2,
    ":)": 2,
    ":(": 30,
    ":/": 10,
    ":O": 4
  };

  final List<Color> _pieChartColors = <Color>[
    Colors.teal.shade200,
    Colors.teal.shade300,
    Colors.teal.shade400,
    Colors.teal,
    Colors.teal.shade600,
    Colors.teal.shade700,
    Colors.teal.shade800,
    Colors.teal.shade900
  ];

  void _setProgressBar(double newProgressCompleted) {
    setState(
      () {
        _progressCompleted = newProgressCompleted;
        _progressLeft = _progressLeft - 1;
      },
    );
  }

  void _setPieChart() {
    setState(
      () {},
    );
  }

// This includes a more detailed breakdown of carbon emissions
// You could use tabs?
  Widget _buildEmissionsPopup(BuildContext context, Color boxColor) {
    return Dialog(
      backgroundColor: boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 535,
        child: const Text("Input Work Here"),
      ),
    );
  }

  Widget _buildFirstWidget(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, String userFirstName) {
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
              child: Text(
                "Welcome " + userFirstName + "!",
                textAlign: TextAlign.left,
                style: const TextStyle(
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

  Widget _buildSecondWidget(
      BuildContext context,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "You are " +
                        progressLeft.toString() +
                        " points away from your next leaf!",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Divider(color: boxColor),
                  const Text(
                    "Answer More Questions",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(color: boxColor),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      value: progressCompleted,
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const QuestionPopup();
                },
              );
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: boxColor,
                fixedSize: const Size(330, 145),
                elevation: boxElevation),
          );
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
                  const Text(
                    "My Carbon Emissions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  PieChart(
                    dataMap: _pieChartCategories,
                    chartLegendSpacing: 50,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    colorList: _pieChartColors,
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.bottom,
                      legendTextStyle: TextStyle(
                          fontSize: 18,
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
                  ),
                ],
              ),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) =>
                    _buildEmissionsPopup(context, boxColor),
              );
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: boxColor,
                elevation: boxElevation),
          );
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
                  const Text(
                    'Fun Fact of the Day',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    funFact,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Divider(color: boxColor),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      TextButton(
                        child: const Text('Learn More'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/learn_more');
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: const Color.fromRGBO(2, 152, 89, 1),
                          elevation: 5,
                          fixedSize: const Size(146, 42),
                        ),
                      ),
                    ],
                  ),
                ],
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
    return Center(
      // List of scrollable widgets
      // You can customize to space between widgets
      child: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(
            sliver: SliverPadding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 15, bottom: 0),
              sliver: _buildFirstWidget(context, _boxPadding, _boxElevation,
                  _boxColor, _userFirstName),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 0),
            sliver: _buildSecondWidget(context, _boxPadding, _boxElevation,
                _boxColor, _progressCompleted, _progressLeft),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 0),
            sliver: _buildThirdWidget(
                context, _boxPadding, _boxElevation, _boxColor),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 25),
            sliver: _buildFourthWidget(
                context, _boxPadding, _boxElevation, _boxColor, _funFact),
          ),
        ],
      ),
    );
  }
}
