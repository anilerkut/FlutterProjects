import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.brown[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/kahve.jpg"),
                  radius: 70,
                  backgroundColor: Colors.brown,
                ),
                Text(
                  "Flutter Kahvecisi",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      color: Colors.brown[900],
                      fontSize: 45),
                ),
                Text(
                  "Bir Fincan Uzağınızda",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Container(
                  width: 200,
                  child: Divider(
                    height: 30,
                    color: Colors.brown[900],
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 45.0),
                  color: Color(0xFF563936),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    title: Text(
                      "erkut.dinc@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 45.0),
                  color: Color(0xFF563936),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: Text(
                      "+4965619816569",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
