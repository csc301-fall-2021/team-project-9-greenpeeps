// an individual resource widget
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatefulWidget {
  final String title;
  final String link;
  final String randImg;

  const ArticleItem(
      {Key? key,
      required this.title,
      required this.link,
      required this.randImg})
      : super(key: key);

  @override
  _ArticleItem createState() => _ArticleItem();
}

class _ArticleItem extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 200,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                image: NetworkImage(widget.randImg),
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.85)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.95],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        //color: Colors.amber[500],
      ),
      onTap: () => launch(widget.link),
    );
  }
}
