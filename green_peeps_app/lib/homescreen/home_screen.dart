import 'package:flutter/material.dart';
import 'package:green_peeps_app/homescreen/welcome_box.dart';
import 'package:green_peeps_app/homescreen/articles_box.dart';
import 'package:green_peeps_app/homescreen/progress_box.dart';
import 'package:green_peeps_app/homescreen/daily_questions_box.dart';
import 'package:green_peeps_app/homescreen/daily_habits_box.dart';
import 'package:green_peeps_app/homescreen/pie_diagram_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Center(
      // List of scrollable widgets
      // You can customize to space between each widget/ box

      child: Scrollbar(
        controller: _controller,
        child: CustomScrollView(
          controller: _controller,
          slivers: const <Widget>[
            SliverSafeArea(
              sliver: SliverPadding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
                sliver: WelcomeBox(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: ProgressBox(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: DailyQuestionsBox(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: DailyLogsBox(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 0),
              sliver: PieDiagramBox(),
            ),
            SliverPadding(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 25),
              sliver: ArticlesBox(),
            ),
          ],
        ),
      ),
    );
  }
}
