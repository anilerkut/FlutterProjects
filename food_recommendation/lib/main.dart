import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Food Recommendation",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FoodPage(),
      ),
    );
  }
}

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int corbaNo = 1;
  int yemekNo = 1;
  int tatliNo = 1;

  List<String> corbaAdlari = [
    "Mercimek",
    "Tarhana",
    "Tavuksuyu",
    "Düğün Çorbası",
    "Yayla Çorbası"
  ];
  List<String> yemekAdlari = [
    'Karnıyarık',
    'Mantı',
    'Kuru Fasulye',
    'İçli Köfte',
    'Izgara Balık'
  ];
  List<String> tatliAdlari = [
    'Kadayıf',
    'Baklava',
    'Sütlaç',
    'Kazandibi',
    'Dondurma'
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      corbaNo = Random().nextInt(5) + 1;
                    });
                  },
                  child: Image.asset("assets/images/corba_$corbaNo.jpg")),
            ),
          ),
          Text("${corbaAdlari[corbaNo - 1]}"),
          Divider(color: Colors.black, height: 5),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      yemekNo = Random().nextInt(5) + 1;
                    });
                  },
                  child: Image.asset("assets/images/yemek_$yemekNo.jpg")),
            ),
          ),
          Text("${yemekAdlari[yemekNo - 1]}"),
          Divider(color: Colors.black, height: 5),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      tatliNo = Random().nextInt(5) + 1;
                    });
                  },
                  child: Image.asset("assets/images/tatli_$tatliNo.jpg")),
            ),
          ),
          Text("${tatliAdlari[tatliNo - 1]}"),
          Divider(color: Colors.black, height: 5),
        ],
      ),
    );
    ;
  }
}
