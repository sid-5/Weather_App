import 'package:flutter/material.dart';
import 'package:weather_app/Home.dart';
import 'package:weather_app/Loadingscreen.dart';
import 'package:weather_app/LocationSelect.dart';
import 'package:weather_app/button.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/Home': (context) => Home(),
      '/button': (context) => MyHomePage(),
    }

  ));
}