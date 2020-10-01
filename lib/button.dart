import 'package:flutter/material.dart';
import 'package:weather_app/Service.dart';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  String w = "", q;
  AnimationController _mycontroller1;
  Animation _animation1;

  Future<void> check(String a) async {
    try{
      Weather ins = Weather(a);
    await ins.getTemp();
    print("gettemp worked");
    if(ins.temperature != "unable to fetch data"){
      Navigator.pushNamed(context, '/Home', arguments: {
        'temperature': ins.temperature,
        'feel': ins.feel,
        'location': ins.location,
        'iconcode': ins.iconCode,
        'mintemp' : ins.mintemp,
        'maxtemp' : ins.maxtemp,
        'pressure' : ins.pressure,
        'humidity' : ins.humidity,
        'windspeed': ins.windspeed,
      });
    }

    }
    catch(e){
      setState(() {
        w = "Not Found";
      });
      print(e);

    }

  }

  @override
  void initState() {
    _mycontroller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation1 = Tween(
      begin: 0.0 ,
      end: 1.0,
    ).animate(_mycontroller1);
    super.initState();
  }

  @override
  void dispose() {
    _mycontroller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mycontroller1.forward();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[Center(
            child: Container(
              child: TextField(
                     decoration: InputDecoration(
                       fillColor: Colors.white70,
                       hintText: "Enter city name...",

                       suffixIcon: FlatButton(child: Icon(Icons.search),
                         onPressed: () {if(w != "Not Found"){
                           q = q[0].toUpperCase() + q.substring(1);
                           check(q);
                         }}),
                       contentPadding: EdgeInsets.all(20),
                     ),
                      onChanged: (String v){q = v;}
                      ,onSubmitted: (String a) {
                        a = a[0].toUpperCase() + a.substring(1);
                        check(a);
                      },
                    ),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.topCenter,
            ),
          ),
          Text(""+"$w",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
      backgroundColor: Colors.black,

    );
  }
}