import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tintin_app/screen/gridview.dart';
import 'package:tintin_app/screen/titles.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Titles()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// class SplashPage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     // return SplashScreen(
//     //   seconds: 2,
//     //   title:new Text(
//     //       'Please Wait',
//     //     style:TextStyle(
//     //       fontSize: 40,
//     //       color: Colors.white
//     //     ),
//     //   ),
//     //   imageBackground: new AssetImage('assets/bg.jpg'),
//     //   photoSize: 80.00,
//     //
//     //   loaderColor: Colors.white,
//     //   navigateAfterSeconds: Titles(),
//     // );
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('flutter_splash_screen'),
//         ),
//         body: Center(
//
//           child: Text('by CrazyCodeBoy',style: TextStyle(fontSize: 20),),
//         ),
//       ),
//     );
//   }
// }
