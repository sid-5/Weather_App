import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class Weather {
  String location;
  String temperature;
  String feel;
  String iconCode;
  String mintemp;
  String maxtemp;
  String pressure;
  String humidity;
  String windspeed;

  Weather(this.location);

  Future<void> getTemp() async{
    try{

      Response obj = await get('http://api.openweathermap.org/data/2.5/weather?q=$location&appid=YOUR_API_ID');

      Map data = jsonDecode(obj.body);
      print(data);

      temperature = (((data['main']['temp'])-273.15).round()).toString();
      feel = data['weather'][0]['description'];
      iconCode = data['weather'][0]['icon'];
      mintemp = (((data['main']['temp_min'])-273.15).round()).toString();
      maxtemp = (((data['main']['temp_max'])-273.15).round()).toString();
      pressure = (data['main']['pressure']).toString();
      humidity =(data['main']['humidity']).toString();
      windspeed= (data['wind']['speed']).toString();


    }
    catch(e){
      print("HTTP call failed"+e);
      temperature = "unable to fetch data";
    }
  }
}
