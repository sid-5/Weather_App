import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    String bg = data['feel'] == "cloudy" || data['feel'] == "haze"
        || data['feel'] == "clear sky" ? 'cloudy.jpg' : 'night.jpg';
    String e = data['iconcode'];


    return Scaffold(
      body: Stack(
        children: [Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$bg'),
                  fit: BoxFit.cover,
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image(
                image: NetworkImage(
                    "http://openweathermap.org/img/wn/$e@2x.png"),
              ),
                Text("" + data['location'],
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      fontSize: 55,
                      fontFamily: "Brooklyn"
                  ),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text("" + data['temperature'],
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 60,
                    ),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("o",
                        style: TextStyle(fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: Text("C",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),),
                  ],
                ),
                Text("" + data['feel'],
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.white54,
                    fontSize: 15,
                  ),),

              ],
            ),
          ),
        ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.09,
            maxChildSize: 0.38,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                ),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0 , 0, 0, 20),
                              child: Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.tealAccent,
                            ),),
                            Text(("Min. Temperature: "+data['mintemp']+"°C"),
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                letterSpacing: 2.0,
                                fontSize:20,
                                wordSpacing: 4,
                                  fontFamily: "Brooklyn"
                              ),),
                            Text(("Max. Temperature: "+ data['maxtemp']+"°C"),
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                letterSpacing: 2.0,
                                fontSize: 20,
                                  wordSpacing: 4,
                                  fontFamily: "Brooklyn"
                              ),),
                            Text(("Wind Speed: " + data['windspeed']),
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                letterSpacing: 2.0,
                                fontSize: 20,
                                  wordSpacing: 4,
                                  fontFamily: "Brooklyn"
                              ),),
                            Text(("Pressure: "+ data['pressure']),
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                letterSpacing: 2.0,
                                fontSize: 20,  wordSpacing: 4,
                                  fontFamily: "Brooklyn"
                              ),),
                            Text(("Humidity: "+ data['humidity']),
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                letterSpacing: 2.0,
                                fontSize: 20,  wordSpacing: 4,
                                  fontFamily: "Brooklyn",
                                shadows: [Shadow(color: Colors.black )]
                              ),)],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(context, "/button");
          if (result != null) {
            setState(() {
              data = {
                'temperature': result['temperature'],
                'feel': result['feel'],
                'location': result['location'],
                'iconcode': result['iconcode'],
                'mintemp' : result['mintemp'],
                'maxtemp' : result['maxtemp'],
                'pressure' : result['pressure'],
                'humidity' : result['humidity'],
                'windspeed': result['windspeed'],
              };
            });
          }
        },
      ),

    );
  }
}

