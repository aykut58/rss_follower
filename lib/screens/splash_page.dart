// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// ignore: implementation_imports, unused_import
import 'package:flutter/src/widgets/container.dart';
// ignore: unnecessary_import, implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:rrs_okuyucu_app/screens/settings_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../data/db_helper_database.dart';
import '../models/rss_model.dart';
import 'rss_list_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
   DbHelperDatabase? dbHelper;

  Future<List<RssModel>>? rssList;
    @override
  void initState() {
    super.initState();
    rssList = DbHelperDatabase.instance.getTodoList();
  }

//   // List deneme = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 2, 
      child: Scaffold
      (
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar
        (
          // color: Colors.blue,
          child: TabBar(
            
            tabs: 
            // ignore: prefer_const_literals_to_create_immutables
            [
              Tab(icon: Icon(Icons.home),),
              //Tab(icon: Icon(Icons.favorite),),
              Tab(icon: Icon(Icons.settings),),
            ]
            ),
        ),
        body: TabBarView(children: 
        // ignore: prefer_const_literals_to_create_immutables
        [
          RssListPage(),
          SettingsPage(),
        ],
        )
      )
      );
  
  }
}