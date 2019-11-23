import 'package:flutter/material.dart';
import 'package:yq/page/explore_page/recommends_page.dart';
import 'package:yq/page/explore_page/selections_page.dart';
import 'docs_page.dart';

class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  final List<String> _tabTitles = [
    "Editor's pick",
    'Headlines',
    'Top docs',
    'Top reps',
  ];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _tabTitles.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        bottom: TabBar(
          isScrollable: true,
          tabs: _tabTitles.map((f) => Tab(text: f)).toList(),
          controller: _controller,
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          SelectionsPage(),
          RecommendsPage(),
          DocsPage(),
          Text('333'),
        ],
      ),
    );
  }
}
