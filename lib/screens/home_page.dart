// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:rrs_okuyucu_app/models/rss_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import 'package:cached_network_image/cached_network_image.dart';

import '../core/utils/date_util.dart';


class RssHomePage extends StatefulWidget {
  RssModel rss;

  // ignore: prefer_const_constructors_in_immutables
  RssHomePage({Key? key, required this.rss}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _RssHomePageState createState() => _RssHomePageState(rss);
}

class _RssHomePageState extends State<RssHomePage> {
  RssModel rss;
      /// Değişimini dinleyeceğimiz değişkene erişim için

  RssFeed? _feed;
  GlobalKey<RefreshIndicatorState>? _refreshKey; // yukarıdan çektiğimiz sayfanın yenilenmesi için kullanacağımız key
  // ignore: unused_field
  
  _RssHomePageState( this.rss); 
  
  Future<void> load() async { 
    await loadFeed().then((result) async {
      if (null == result || result.toString().isEmpty) {
        return;
      }
      setState(() {
        _feed = result;
      });
    });
  }

  Future<RssFeed?> loadFeed() async { 
    
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(rss.url.toString()));
      final responseBody = utf8.decode(response.bodyBytes);
      return RssFeed.parse(responseBody);
     
    } on Exception {
    
     // ignore: avoid_print
     print("hata var looo");
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  
    _refreshKey = GlobalKey<RefreshIndicatorState>();
     Future.delayed( Duration.zero, () {
      load();
   });
   
  }

  bool isFeedEmpty() { // rssten veri gelip gelmediğinin kontrolü
    return null == _feed || null == _feed!.items;
  }

  Widget body() { // Gelmediyse ortada yükleniyor işareti dönüyor. Geldiyse oluşturduğumuz list() yükleniyor.
    return isFeedEmpty() // kontrol
        ? const Center(child: CircularProgressIndicator(),)
        : RefreshIndicator(
            key: _refreshKey,
            child:  List1(),
            onRefresh: () async => load(), //ekranı yukarıdan çektiğimizde yeni veri geldiyse ana sayfamızın güncellenmesien yarar.
          );
  }

  @override
  Widget build(BuildContext context) { // standart kullanım
    return Scaffold(
      appBar: AppBar(
        
        title:  Text(rss.title.toString()), // seçilen kaynak adı gelecek. 
        
      ),
    //   endDrawer: Drawer(
    //     child: ListView(
    //   padding: EdgeInsets.zero,
    //   children: [
    //     // ignore: prefer_const_constructors
    //     SizedBox(
    //       height: 25,
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.list),
    //       title: const Text("Rss Listesi"),
    //       onTap: () async
    //       {
    //         Navigator.push(context, MaterialPageRoute(builder: (context) => const RssListPage(),));
    //       },
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.settings),
    //       title: const Text("Ayarlar"),
    //       onTap: () 
    //       {
    //        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SettingsPage(),));
    //       },
    //     ),
    //   ],
    // )),
      body:body(),
      
    );
  }
  Widget List1() 
{
  
  return ListView.builder(
    itemCount: _feed!.items!.length,
    itemBuilder: (BuildContext context, int index)
    {
      
        final item = _feed!.items![index];
        
        final url = Uri.parse(_feed!.items![index].link.toString());
        String subTitle = "Şimdi";
        if(item.pubDate != null) 
        {
          subTitle = DateUtil.setSubTitleText(item.pubDate!);
        }
        return Card
        (

         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),
           ),
          child: ListTile
          (
            //subtitle: Text(subTitle),
            leading: CachedNetworkImage(errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_rounded , color: Colors.red,),
            imageUrl: item.enclosure?.url  ?? "hata" ,
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width / 4, 
            // alignment: Alignment.center,
            // fit: BoxFit.fill,
            ),

            title: Text(
              item.title ?? "title gelecek", // haber ilk girildiğinde title bazen boş olabiliyor, hata almamak için bu şeklide bir kullanım tercih ettim
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle
              (
                 fontSize: 16,
                 fontWeight: FontWeight.bold),
              ),
              onTap: () async
              {
                
                
                
                if(!await launchUrl(url))
                {
                   throw 'Could not launch $url';
                }
              },
              onLongPress: () 
              {
                share(context ,url );
              },
            ),
        );
    }
    );
}


}

share(BuildContext context, Uri url) 
{
  final String text = url.toString();
  Share.share(text);
}

