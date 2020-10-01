import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Service.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void settemp() async{
    Weather instance = Weather("London");
    await instance.getTemp();
    Navigator.pushReplacementNamed(context, '/Home', arguments: {
      'temperature': instance.temperature,
      'feel': instance.feel,
      'location': instance.location,
      'iconcode': instance.iconCode,
      'mintemp' : instance.mintemp,
      'maxtemp' : instance.maxtemp,
      'pressure' : instance.pressure,
      'humidity' : instance.humidity,
      'windspeed': instance.windspeed,
    });


    }
  @override
  void initState(){
    settemp();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
        )
      ),
    );
  }
}

