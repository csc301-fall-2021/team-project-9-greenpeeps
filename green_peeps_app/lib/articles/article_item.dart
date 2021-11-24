// an individual resource widget
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatefulWidget {
  final String title;
  final String link;
  final String randImg;
  
  const ArticleItem({Key? key, required this.title, required this.link, required this.randImg}) : super(key: key);

  @override 
  _ArticleItem createState() => _ArticleItem();
}

class _ArticleItem extends State<ArticleItem> {

  @override 
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(widget.randImg),
              fit: BoxFit.cover,
            ),
          ),
          //color: Colors.amber[500],
          child: Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                backgroundColor: Colors.black.withOpacity(0.6),
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () => launch(widget.link)
      )

    );
  }
}