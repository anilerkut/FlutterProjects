import 'package:flutter/material.dart';
import 'package:flutter_lifetime_app/result_page.dart';
import 'package:flutter_lifetime_app/user_data.dart';
import './custom_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String cinsiyet = "";
  double exercise = 0.0;
  double cigarette = 0.0;
  int height = 170;
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIFETIME APP"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: MyContainer(
                      child: buildRow("HEIGHT"),
                    ),
                  ),
                  Expanded(
                    child: MyContainer(
                      child: buildRow("WEIGHT"),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: MyContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "How many cigarette do you smoke in a day?",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      cigarette.toInt().toString(),
                      style: TextStyle(
                          color: Colors.lightBlue[600],
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    Slider(
                        min: 0,
                        max: 30,
                        value: cigarette,
                        onChanged: (double value) {
                          setState(() {
                            cigarette = value;
                          });
                        })
                  ],
                ),
              ),
            ),
            Expanded(
              child: MyContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "How many days do you exercise in week?",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      exercise.toInt().toString(),
                      style: TextStyle(
                          color: Colors.lightBlue[600],
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    Slider(
                      min: 0,
                      max: 7,
                      value: exercise,
                      onChanged: (double value) {
                        setState(() {
                          exercise = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: MyContainer(
                      onPress: () {
                        setState(() {
                          cinsiyet = "female";
                        });
                      },
                      renk: cinsiyet == "female"
                          ? Colors.lightBlueAccent
                          : Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: Icon(
                              FontAwesomeIcons.venus,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text(
                              "FEMALE",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MyContainer(
                      onPress: () {
                        setState(() {
                          cinsiyet = "male";
                        });
                      },
                      renk: cinsiyet == "male"
                          ? Colors.lightBlueAccent
                          : Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: Icon(
                              FontAwesomeIcons.mars,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text(
                              "MALE",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ButtonTheme(
              child: TextButton(
                onPressed: () {
                  UserData user =
                      UserData(cinsiyet, exercise, cigarette, height, weight);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(user)));
                },
                child: Text("CALCULATE", style: TextStyle(fontSize: 18)),
                style: TextButton.styleFrom(
                    primary: Colors.blueAccent[700],
                    backgroundColor: Colors.white),
              ),
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  Row buildRow(String section) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            section,
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: 8),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            section == "HEIGHT" ? height.toString() : weight.toString(),
            style: TextStyle(
                color: Colors.lightBlue[600],
                fontSize: 23,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: 14),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (section == "HEIGHT") {
                      height++;
                    } else if (section == "WEIGHT") {
                      weight++;
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue)),
                child: Icon(Icons.add),
              ),
            ),
            ButtonTheme(
              minWidth: 36,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (section == "HEIGHT") {
                      height--;
                    } else if (section == "WEIGHT") {
                      weight--;
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue)),
                child: Icon(Icons.remove),
              ),
            )
          ],
        )
      ],
    );
  }
}
