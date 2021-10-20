import 'package:flutter/material.dart';

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: const Color.fromRGBO(248, 244, 219, 1),
    title: const Text('TBD'),
    content: const Text("what"),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.close),
      ),
    ],
  );
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
                height: 140,
                child: ElevatedButton(
                    child: const Text("hi"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(248, 244, 219, 1),
                        fixedSize: const Size(330, 140),
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
                height: 510,
                child: ElevatedButton(
                    child: const Text("hi"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(248, 244, 219, 1),
                        fixedSize: const Size(330, 441),
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
