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
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            //color: Colors.amber[500],
          ),
          Container(
            padding: const EdgeInsets.all(80),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.0),
              image: const DecorationImage(
                image: NetworkImage('https://images.ctfassets.net/hrltx12pl8hq/6TOyJZTDnuutGpSMYcFlfZ/4dfab047c1d94bbefb0f9325c54e08a2/01-nature_668593321.jpg?fit=fill&w=480&h=270'),
                fit: BoxFit.cover,
              ),
            ),
            //color: Colors.amber[500],
            child: Center(
              child: InkWell(
                child: 
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => launch(widget.link)
              ),
            ),
          ),
          
        ], 
      )
      
        
    );
  }
}