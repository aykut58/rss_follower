// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rrs_okuyucu_app/screens/splash_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
// double imageOpacity = 0;
// @override
// void initState() {
//     super.initState();
//     Future.microtask(() 
//     {
//       /// ekran çizimi bittikten sonra çalışmasını sağlar bu method.
//       setState(() {
//         imageOpacity = 1;
//       });
      
//     });
//   }

@override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/splash');
      });
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold
    (
      body: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children :
        [
          Lottie.asset("assets/lottie/start.json"),
          Text("RSS FOLLOWER",style: GoogleFonts.bigshotOne(fontSize: 20,),)
        ] 
      ),
      // body: Column(
      //   children: [
      //       Spacer(flex: 3,),
            
      //       Expanded(
      //         flex: 7,
      //         child: AnimatedOpacity
      //         (
      //           opacity: imageOpacity,
      //           duration: Duration(seconds: 1),
      //           child: SvgPicture.asset("assets/svg/start.svg"),
      //         ),
              
      //       ),
      //       Expanded(flex:5, child: Text("RSS FOLLOWER",style: GoogleFonts.bigshotOne(fontSize: 30,),),),
          
      //   ],
      //   ),
    
    );
  }
}