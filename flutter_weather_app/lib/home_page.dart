import 'dart:convert';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'search_page.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'widgets/daily_weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = "İzmir";
  double? temperature;
  final String key = "4013cd47401e2631a16b57e7b9eed292";
  var locationData;
  String code = "Black";
  String? icon = "";
  Position? devicePosition;

  List<String> icons = [];
  List<double> temperatures = [];
  List<String> dates = [];
  List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  Future<void> getLocaitonData() async {
    locationData = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric'));
    final locationDataParse = jsonDecode(locationData.body);

    setState(() {
      temperature = locationDataParse["main"]["temp"];
      location = locationDataParse["name"];
      code = locationDataParse["weather"][0]["main"];
      icon = locationDataParse["weather"][0]["icon"];
    });
  }

  Future<void> getDeviceLocation() async {
    devicePosition = await _determinePosition();
  }

  Future<void> getLocaitonDataWithLatLon() async {
    if (devicePosition != null) {
      locationData = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${devicePosition!.latitude}&lon=${devicePosition!.longitude}&appid=$key&units=metric'));
      final locationDataParse = jsonDecode(locationData.body);

      setState(() {
        temperature = locationDataParse["main"]["temp"];
        location = locationDataParse["name"];
        code = locationDataParse["weather"][0]["main"];
        icon = locationDataParse["weather"][0]["icon"];
      });
    }
  }

  Future<void> getDailyForecastbyLatLon() async {
    var forecastData = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${devicePosition!.latitude}&lon=${devicePosition!.longitude}&appid=$key&units=metric'));
    var forecastDataParse = jsonDecode(forecastData.body);
    temperatures.clear();
    icons.clear();
    dates.clear();

    setState(() {
      for (int i = 7; i <= 39; i = i + 8) {
        temperatures.add(forecastDataParse["list"][i]["main"]["temp"]);
        icons.add(forecastDataParse["list"][i]["weather"][0]["icon"]);
        DateTime date = DateTime.parse(forecastDataParse["list"][i]["dt_txt"]);
        dates.add(weekdays[date.weekday - 1]);
      }
    });
  }

  Future<void> getDailyCityForecastbyLatLon() async {
    var forecastData = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$key&units=metric"));
    var forecastDataParse = jsonDecode(forecastData.body);
    temperatures.clear();
    icons.clear();
    dates.clear();

    setState(() {
      for (int i = 7; i <= 39; i = i + 8) {
        temperatures.add(forecastDataParse["list"][i]["main"]["temp"]);
        icons.add(forecastDataParse["list"][i]["weather"][0]["icon"]);
        DateTime date = DateTime.parse(forecastDataParse["list"][i]["dt_txt"]);
        dates.add(weekdays[date.weekday - 1]);
      }
    });
  }

  void getInitialData() async {
    await getDeviceLocation();
    await getLocaitonDataWithLatLon(); //Current Weather
    await getDailyForecastbyLatLon(); //5 Day Weather
  }

  @override
  void initState() {
    // TODO: implement initState
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/$code.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: (temperature == null || devicePosition == null || icons.isEmpty)
          ? Center(
              child: const LoadingIndicator(
                  indicatorType: Indicator.ballScaleMultiple),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.5),
                            blurRadius: 8.0)
                      ],
                      color: Color(0xE5EAE9E9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.network(
                              "http://openweathermap.org/img/wn/$icon@2x.png"),
                          flex: 1,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "$temperature° C",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$location",
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 7),
                      IconButton(
                        onPressed: () async {
                          final selectCity = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                          location = selectCity;
                          await getLocaitonData();
                          getDailyCityForecastbyLatLon();
                        },
                        icon: Icon(Icons.search, size: 35),
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  buildWeatherCard(context),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await getDeviceLocation();
                  await getLocaitonDataWithLatLon(); //Current Weather
                  await getDailyForecastbyLatLon();
                },
                backgroundColor: Colors.deepOrange,
                child: const Icon(Icons.navigation),
              ),
            ),
    );
  }

  Widget buildWeatherCard(BuildContext context) {
    List<Widget> cards = [];

    for (int i = 0; i < 5; i++) {
      cards.add(DailyWeatherCard(
          icon: icons[i], temperature: temperatures[i], date: dates[i]));
      cards.add(SizedBox(width: 4));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cards,
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
