import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_peeps_app/articles/article_item.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ArticlesBox extends StatefulWidget {
  const ArticlesBox({Key? key}) : super(key: key);

  @override
  _ArticlesBoxState createState() => _ArticlesBoxState();
}

class _ArticlesBoxState extends State<ArticlesBox> {
  final double _boxPadding = 10.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);
  _getRandomArticle(AsyncSnapshot<QuerySnapshot> snapshot) {
    final List<String> images = [
      'https://images.pexels.com/photos/1179229/pexels-photo-1179229.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/1592119/pexels-photo-1592119.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/5092153/pexels-photo-5092153.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/10269148/pexels-photo-10269148.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/5948944/pexels-photo-5948944.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/6762338/pexels-photo-6762338.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/9064239/pexels-photo-9064239.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260'
    ];

    final _rand = Random();

    List<ArticleItem> allArticles = snapshot.data!.docs
        .map((doc) => ArticleItem(
              title: doc["title"],
              link: doc["link"],
              randImg: images[_rand.nextInt(images.length)],
            ))
        .toList();

    return allArticles[Random().nextInt(allArticles.length)];
  }

  Widget _randomArticle(Stream<QuerySnapshot> articles) {
    return StreamBuilder<QuerySnapshot>(
        stream: articles,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return const Text("Come back later for more articles!");
          return Container(child: _getRandomArticle(snapshot));
        });
  }

  Widget _buildArticlesBox(BuildContext context, double boxPadding,
      double boxElevation, Color boxColor, Stream<QuerySnapshot> articles) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
            color: boxColor,
            elevation: boxElevation,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
                padding: EdgeInsets.all(boxPadding),
                child: Column(children: <Widget>[
                  const Text(
                    "Today's Article (Learn About Climate Change):",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _randomArticle(articles),
                  ),
                ])),
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> articles =
        FirebaseFirestore.instance.collection('articles').snapshots();
    return _buildArticlesBox(
        context, _boxPadding, _boxElevation, _boxColor, articles);
  }
}
