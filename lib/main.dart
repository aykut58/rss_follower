// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rrs_okuyucu_app/providers/lang_provider.dart';
import 'package:rrs_okuyucu_app/screens/splash_page.dart';
import 'package:rrs_okuyucu_app/screens/start_page.dart';



import 'providers/theme_provider.dart';


import 'ui/custom_theme.dart';
import 'ui/custom_theme_dark.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
  FlutterError.dumpErrorToConsole(details);
};
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  
  LangProvider langProvider = LangProvider();
  await langProvider.loadLocale();
  ThemeProvider themeProvider = ThemeProvider();
  themeProvider.loadTheme();
  
  
  

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

   PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    
    };


  runApp
  (
    
        EasyLocalization(
          fallbackLocale: Locale('tr'),
          supportedLocales: [Locale('en'), Locale('tr')],
          startLocale: langProvider.getLocale,
          
          path: "assets/lang",
          child: 
        MultiProvider(
        providers: 
        [
 
          ChangeNotifierProvider<ThemeProvider>
          (
            create: (context) => themeProvider,
          ),
          ChangeNotifierProvider<LangProvider>
          (
            create: (context) => langProvider,
          ),
          
          
        ],
          child: MyApp(), 
        
        )
        )
        );   
  
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    

    
    return Consumer2<ThemeProvider,LangProvider>(
      builder: (context, themeProvider,langProvider,_,)
      {
        print("dil : ${langProvider.getLocale}");
        print("tema değeri :  ${themeProvider.isDarkModeEnabled}");
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        
      theme: themeProvider.isDarkModeEnabled
      
        
        ? myThemeDark
        : myThemeLight,
      routes: 
      {
        "/":(context) => StartPage(),
        "/splash":(context) => SplashPage()
      },
       initialRoute: "/",
      );
      }

    );
    }
  }


