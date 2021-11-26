import 'package:flutter/material.dart';

class HabitTiles extends StatefulWidget {
  const HabitTiles({Key? key}) : super(key: key);

  @override
  _HabitTilesState createState() => _HabitTilesState();
}

class _HabitTilesState extends State<HabitTiles> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    "1) Log",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Divider()),
                  IconButton(
                    splashRadius: 15,
                    onPressed: () {},
                    icon: Icon(
                      Icons.short_text_rounded,
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  ClipRRect(
                    // Used to make the bar round
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      value: 0.2,
                      minHeight: 16,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "1/5",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class HabitTileItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HabitInProgressTileItem implements HabitTileItem {
  final String heading;

  HabitInProgressTileItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return const Text(
      "1) Log",
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// A ListItem that contains data to display a message.
class MyHabitTileItem implements HabitTileItem {
  final String sender;
  final String body;

  MyHabitTileItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) {
    return const Text(
      "1) Log",
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget buildProgressBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          // Used to make the bar round
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: const Color.fromRGBO(180, 180, 180, 1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            value: 0.2,
            minHeight: 16,
          ),
        ),
        Container(
          width: double.infinity,
          child: Text(
            "1/5",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
