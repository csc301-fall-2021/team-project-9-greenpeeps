// an individual resource widget
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatefulWidget {
  final String title;
  final String link;
  
  const ArticleItem({Key? key, required this.title, required this.link}) : super(key: key);

  @override 
  _ArticleItem createState() => _ArticleItem();
}

class _ArticleItem extends State<ArticleItem> {
  @override 
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: 
          Text(widget.title),
          onTap: () => launch(widget.link)
      ),
        
    );
  }
}