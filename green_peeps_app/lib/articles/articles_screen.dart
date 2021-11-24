import 'package:flutter/material.dart';
import 'package:green_peeps_app/articles/article_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  Widget _articles(Stream<QuerySnapshot> articles) {
    //CollectionReference articles = FirebaseFirestore.instance.collection('articles');

    return StreamBuilder<QuerySnapshot>(
      stream: articles,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text("Come back later for more articles!");
        return ListView(children: getArticles(snapshot));
      }

    );
  }

  getArticles(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((doc) => ArticleItem(title: doc["title"], link: doc["link"])).toList();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> articles = FirebaseFirestore.instance.collection('articles').snapshots();
    return _articles(articles);
  }
}
