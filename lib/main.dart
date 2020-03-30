import 'package:doyinapplication/pages/home_page.dart';
import 'package:doyinapplication/provider/DouYin.dart';
import 'package:doyinapplication/test/test.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DouYin(),
        )
      ],
      child: MaterialApp(
        home: HomeTestPage(),
      ),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  List<String> choices = ["关注", "推荐"];
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: choices.length,initialIndex: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int pageState = Provider.of<DouYin>(context).state;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: <Widget>[
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
              PageView(
                controller: new PageController(keepPage: false),
                physics: pageState == 1
                    ? new NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  HomePage("assets/1584668998696478.mp4"),
                  HomePage("assets/1584669002050837.mp4"),
                  HomePage("assets/1584669004846880.mp4"),
                ],
              ),

            ],
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(flex:4,child: Align(alignment:Alignment.centerLeft,child: Icon(Icons.menu,color: Colors.white))),
                  Expanded(
                    flex: 4,
                    child: Material(
                      color: Colors.transparent,
                      child: TabBar(
                        controller: _tabController,
                        tabs: choices.map((val)=> Tab(text: val,)).toList()
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                      child: Align(alignment:Alignment.centerRight,child: Icon(Icons.search,color: Colors.white))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
