import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> dataMap = {
  "Food": 5,
  "Electricity": 3,
  "Water": 2,
  "Transportation": 2,
  ":)": 2,
  ":(": 30,
  ":/": 10,
  ":O": 4
};

List<Color> colorList = <Color>[
  Colors.teal.shade200,
  Colors.teal.shade300,
  Colors.teal.shade400,
  Colors.teal,
  Colors.teal.shade600,
  Colors.teal.shade700,
  Colors.teal.shade800,
  Colors.teal.shade900
];

Widget _buildPopupDialog(BuildContext context) {
  return Dialog(
      backgroundColor: const Color.fromRGBO(248, 244, 219, 1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, //todo: Get width resizing to work"
          height: 535,
          child: Column(children: <Widget>[
            AppBar(
                backgroundColor: const Color.fromRGBO(248, 244, 219, 1),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                height: 125,
                child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                        padding: const EdgeInsets.all(7.0),
                        width: 330,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color.fromRGBO(248, 244, 219, 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: const Text("Welcome Guy!",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            )))),
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                height: 145,
                child: ElevatedButton(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 330,
                        height: 145,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text("You are x points away from your next leaf!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: "Nunito")),
                              Divider(color: Color.fromRGBO(248, 244, 219, 1)),
                              Text("Answer More Questions",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Nunito")),
                              Divider(color: Color.fromRGBO(248, 244, 219, 1)),
                              LinearProgressIndicator(
                                backgroundColor:
                                    Color.fromRGBO(180, 180, 180, 1),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                                value: 0.5,
                                minHeight: 5,
                              )
                            ])),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        primary: const Color.fromRGBO(248, 244, 219, 1),
                        fixedSize: const Size(330, 145),
                        elevation: 5)),
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                height: 700,
                child: ElevatedButton(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 330,
                        height: 600,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("My Carbon Emissions",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Nunito")),
                              PieChart(
                                dataMap: dataMap,
                                chartLegendSpacing: 50,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 2,
                                colorList: colorList,
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
                        primary: const Color.fromRGBO(248, 244, 219, 1),
                        fixedSize: const Size(330, 600),
                        elevation: 5)),
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          // todo: box resizes with text
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                  alignment: Alignment.center,
                  height: 140,
                  child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          width: 330,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color.fromRGBO(248, 244, 219, 1),
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
                                        color: Colors.black,
                                        fontFamily: "Nunito")),
                                RichText(
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    text: const TextSpan(
                                        text: 'Did you know that',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: "Nunito"))),
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
                              ]))));
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                height: 50,
              );
            },
            childCount: 1,
          ),
        ),
      ]),
    );
  }
}
