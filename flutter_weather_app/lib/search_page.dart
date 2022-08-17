import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCity = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Black.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                onChanged: (value) {
                  selectedCity = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: Color(0xDCD5D4D4),
                  hintText: "Choose City",
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
              onPressed: () async {
                http.Response response = await http.get(
                  Uri.parse(
                      "https://api.openweathermap.org/data/2.5/weather?q=$selectedCity&appid=4013cd47401e2631a16b57e7b9eed292&units=metric'"),
                );
                if (response.statusCode == 200) {
                  Navigator.pop(context, selectedCity);
                } else {
                  //Alert dialog from flutter website.
                  _showMyDialog();
                }
              },
              child: const Text("Select City"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location not found'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please select a valid location'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
