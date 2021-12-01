import 'package:flutter/material.dart';
import 'package:green_peeps_app/articles/article_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
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

  Widget _articles(Stream<QuerySnapshot> articles) {
    //CollectionReference articles = FirebaseFirestore.instance.collection('articles');

    return StreamBuilder<QuerySnapshot>(
      stream: articles,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // ignore: todo
        // TODO: style come back later text
        if (!snapshot.hasData)
          return const Text("Come back later for more articles!");
        return ListView(
          //padding: const EdgeInsets.all(10),
          children: _getArticles(snapshot),
        );
      },
    );
  }

  _getArticles(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => ArticleItem(
              title: doc["title"],
              link: doc["link"],
              randImg: images[_rand.nextInt(images.length)],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> articles =
        FirebaseFirestore.instance.collection('articles').snapshots();
    return _articles(articles);
  }
}
