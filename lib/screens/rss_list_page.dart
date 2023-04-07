// ignore_for_file: prefer_const_constructors, dead_code, unused_local_variable, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rrs_okuyucu_app/models/rss_model.dart';
import 'package:rrs_okuyucu_app/screens/home_page.dart';
import 'package:rrs_okuyucu_app/screens/rss_add_page.dart';



import '../components/search_bar.dart';
import '../core/init/locale_keys.g.dart';
import '../data/db_helper_database.dart';




class RssListPage extends StatefulWidget {
  const RssListPage({super.key});

  @override
  State<RssListPage> createState() => _RssListPageState();
}

class _RssListPageState extends State<RssListPage> {
  

  late DbHelperDatabase dbHelper;
  
  TextEditingController rssController = TextEditingController();
  Future<List<RssModel>>? rssList;
    @override
  void initState() {
    super.initState();
    rssList = DbHelperDatabase.instance.getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () 
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RssAddPage(),));
        },
        child: const Icon(Icons.add),),
      appBar: AppBar
      (
        title: SearchBar
        (
          onSearched : (text) 
          {
            setState(() {
              rssList = DbHelperDatabase.instance.search(text);
            });
          }
        ),
        //title: Text("Rss Follower", style: GoogleFonts.taiHeritagePro(fontSize: 30,),),/*Text (LocaleKeys.rss_list_title).tr(),*/
      ),

      body: FutureBuilder<List<RssModel>>(
        future: rssList,
        builder: (context, snapshot) 
        {
          if (snapshot.connectionState == ConnectionState.waiting) 
          {
            //print("rss sayfası : 1");
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasData) 
          {
            //print("rss sayfası : 2");
            if(snapshot.data!.isEmpty) 
            {
              return Center(child: Text(LocaleKeys.rss_list_RssListNull.tr() , style: TextStyle(color: Colors.red),));
            }
            return ListView.builder
            (
              
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) 
              {
                 RssModel rss = snapshot.data![index];
                 return Card
                 (
                  child: ListTile
                  (
                    subtitle: Text(rss.url.toString()),
                    title: Text(rss.title.toString()),
                    trailing: IconButton(
                      onPressed: () async
                      {
                          AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: LocaleKeys.rss_list_RssListAwesomeDialog_Title.tr(),
                          desc: LocaleKeys.rss_list_RssListAwesomeDialog_Desc.tr(),
                          btnCancelOnPress: () {},
                          btnCancelText: LocaleKeys.rss_list_RssListAwesomeDialog_No.tr(),
                          btnOkText: LocaleKeys.rss_list_RssListAwesomeDialog_Yes.tr(),
                          btnOkOnPress: () async
                          {
                            final dbHelperResult = await DbHelperDatabase.instance.delete(rss.id!);
                            setState(() 
                            {
                              rssList = DbHelperDatabase.instance.getTodoList();
                            });
                          },
                          )..show();

                      }, 
                      icon: Icon(Icons.delete, color: Colors.red,),),
                      onTap: () 
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RssHomePage(rss: rss,),));
                      },
                  ),
                 );
              },
            );
          }
          else
          {
            return Text("Hata Oluştu.");
            
          }
        },
        // future: rssList,
        // builder: (context, snapshot)
        // {
        //   if(snapshot.hasData) 
        //   {
        //     return ListView.builder
        //     (
        //       itemCount: snapshot.data!.length,
        //       itemBuilder: (context, index) 
        //       {
        //           RssModel rss = snapshot.data![index];
                  
        //           return Card(
        //             child: ListTile
        //             (
                      
        //               subtitle: Text(rss.url.toString()),
        //               title: Text(rss.title.toString()),
        //               trailing: IconButton(
        //                 onPressed: () async
        //                 {
                         
        //                  final dbHelperResult = await DbHelperDatabase.instance.delete(rss.id!);
        //                  setState(() 
        //                  {
        //                     rssList = DbHelperDatabase.instance.getTodoList();
        //                  });
        //                 }, 
        //                 icon: Icon(Icons.delete, color: Colors.red,),
        //                 ),
        //               // trailing: Icon(Icons.delete, color: Colors.red,),
        //               onTap: () 
        //               {
        //                 read.setUrl=rss.url.toString();
        //                 Navigator.push(context, MaterialPageRoute(builder: (context) => RssHomePage(),));
        //               },
        //             ),
        //           );
        //       },
              
        //     );

        //   }
        //   else 
        //   {
        //     return Center(child: CircularProgressIndicator());
        //   }
        // }
        )
    );
  }
}

class CustomSearchDelegate extends SearchDelegate 
{
      List<String> searchTerms = 
    [
      
    ];
  @override
  List<Widget> buildActions(BuildContext context) 
  {
    DbHelperDatabase.instance.getTodoList().then((value) => 
    {

    }
    );
    return 
    [
      IconButton(
        onPressed: () 
        {
          query = "" ;
        }, 
        icon: Icon(Icons.clear))
    ];
  }
  @override
  Widget buildLeading(BuildContext context) 
  {
    return IconButton(
      onPressed: () 
      {
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back));
    
  }
    @override
  Widget buildResults(BuildContext context) 
  {
    List<String> matchQuery = [];
    for(var fruit in searchTerms) 
    {
      if(fruit.toLowerCase().contains(query.toLowerCase())) 
      {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context , index) 
      {
        var result = matchQuery[index];
        return ListTile
        (
          title: Text(result),
        );
      }
      );
  }
    @override
  Widget buildSuggestions(BuildContext context) 
  {
    List<String> matchQuery = [];
    for(var fruit in searchTerms) 
    {
      if(fruit.toLowerCase().contains(query.toLowerCase()))
      {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context , index)
      {
        var result = matchQuery[index];
        return ListTile
        (
          title: Text(result),
        );
      });
  }
}