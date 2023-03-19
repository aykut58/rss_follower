// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_single_cascade_in_expression_statements
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rrs_okuyucu_app/core/init/locale_keys.g.dart';
import 'package:rrs_okuyucu_app/models/rss_model.dart';
import 'package:http/http.dart' as http;
import 'package:rrs_okuyucu_app/screens/splash_page.dart';
import 'dart:convert' show utf8;
import '../core/extensions/log_extensions.dart';

import 'package:webfeed/domain/rss_feed.dart';

import '../core/utils/snackbar_utils.dart';
import '../data/db_helper_database.dart';


class RssAddPage extends StatefulWidget {
  const RssAddPage({super.key});

  @override
  State<RssAddPage> createState() => _RssAddPageState();
}

class _RssAddPageState extends State<RssAddPage> {
  TextEditingController rssController = TextEditingController();
final dbHelper = DbHelperDatabase.instance;
 RssModel? rssModel;
 RssFeed? _feed;
GlobalKey<FormState> globalKey = GlobalKey();
  
  
  Future<RssFeed?> loadFeed() async { 
   
      final client = http.Client();
      final response = await client.get(Uri.parse(rssController.text));
      final responseBody = utf8.decode(response.bodyBytes);
      print("response${response.body}");
      
      return RssFeed.parse(responseBody);
    
  }
  @override
  void initState() 
  {
    super.initState();
    rssModel = RssModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(title: const Text(LocaleKeys.rss_add_title).tr(),),
      body: Form
      (
        autovalidateMode: AutovalidateMode.disabled,
        key: globalKey,
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Container(
              padding: EdgeInsets.all(5),
              child: TextFormField
              (
                validator: ((value) 
                {/// validator ile boş olup olmadığı kontrol ediliyor.
                  if (value!.isEmpty) {
                    return LocaleKeys.rss_add_TextFormFiled.tr();
                  } else {
                    return null;
                  } 
                }),
                controller: rssController,
                decoration: InputDecoration(       
                labelText: LocaleKeys.rss_add_labelText.tr(),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                                    ),
            
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () 
              async {
               if(globalKey.currentState!.validate())
               {
                /// veritabanı kontrol. //TODO
                
                final result =await dbHelper.rssControl(rssController.text);
                if(result)
                {
                    try 
                    {
                     await loadFeed().then((result) async {
                     if (null == result || result.toString().isEmpty) {
                     return;
                    }
                                    
                      rssModel!.url = rssController.text;
                      rssModel!.title = result.title;
                      final dbHelperResult = await dbHelper.insert(rssModel!);
                      SnackBarUtils.showSnackBar(context: context, message: LocaleKeys.rss_add_snackBarBasarili.tr());
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) =>  SplashPage()), (route) => false);

                    });
                    }
                    catch (e)
                    { 
                      print("hata verdi");
                      SnackBarUtils.showSnackBar(context: context, message: LocaleKeys.rss_add_snackBarBasarisiz.tr());
                     //hata mesajı yap.
                    }
                }

                
                
                
                 
                 logInfo("title : ${rssController.text}");
                 logInfo("title : ${rssModel!.title}");
                 logInfo("url : ${rssModel!.url}");
               } 
               else
               {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: LocaleKeys.rss_add_RssAddAwesomeDialog_Title.tr(),
                    desc: LocaleKeys.rss_add_RssAddtAwesomeDialog_Desc.tr(),
                    )..show();
               }


              }, 
              child: const Text(LocaleKeys.rss_add_buttonText).tr())
          ],
        ),
      ),
    );
  }
}