
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:tintin_app/screen/gridview.dart';
import 'package:tintin_app/screen/splash.dart';
import 'package:tintin_app/service/tintinimages_services.dart';

void setupLocator(){
  GetIt.instance.registerLazySingleton(() => TintinServeces());
}

void main(){
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    setupLocator();
    runApp(new MyApp());


   // runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//
//    ]);

    return MaterialApp(
      title:"Tin Tin App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: SplashPage(),
    );
  }
}