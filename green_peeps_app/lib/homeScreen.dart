import 'package:flutter/material.dart';

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    backgroundColor: Color.fromRGBO(248, 244, 219, 1),
    title: Text('TBD'),
    content: Text("what"),
    actions: <Widget>[
      new IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.close),
      ),
    ],
  );
}

class homeScreen extends StatelessWidget {
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
                        padding: EdgeInsets.all(7.0),
                        width: 330,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(248, 244, 219, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Text("Welcome Guy!",
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
                    child: Text("hi"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(248, 244, 219, 1),
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
                    child: Text("hi"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(248, 244, 219, 1),
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
                  height: 230,
                  child: AlertDialog(
                    elevation: 5,
                    backgroundColor: Color.fromRGBO(248, 244, 219, 1),
                    title: Text('Fun Fact of the Day',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Nunito")),
                    content: Container(
                        width: 330,
                        height: 140,
                        child: SingleChildScrollView(
                            child: RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: 'Did you know that',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Nunito")),
                        ))),
                    actions: <Widget>[
                      new TextButton(
                        child: const Text('Learn More'),
                        onPressed: () {},
                      ),
                    ],
                  ));
            },
            childCount: 1,
          ),
        ),
      ]),
    );
  }
}
