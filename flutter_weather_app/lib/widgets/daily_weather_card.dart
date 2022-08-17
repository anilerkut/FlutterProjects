import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyWeatherCard extends StatelessWidget {
  const DailyWeatherCard(
      {Key? key,
      required this.icon,
      required this.temperature,
      required this.date})
      : super(key: key);
  final String icon;
  final double temperature;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color(0xEAE9E9E5),
      child: SizedBox(
        width: 110,
        height: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("http://openweathermap.org/img/wn/$icon.png"),
            Text("$temperature° C",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(date)
          ],
        ),
      ),
    );
  }
}
