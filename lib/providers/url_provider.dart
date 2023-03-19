import 'package:flutter/material.dart';

class UrlProvider with ChangeNotifier 
{
  String url="";

  String get setUrl => url;

  set setUrl(String newUrl) 
  {
    url = newUrl;
    notifyListeners();
  }
}