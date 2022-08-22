import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tenor_api/app_colors.dart';
import 'package:http/http.dart' as http;

class GifPage extends StatefulWidget {
  const GifPage({Key? key}) : super(key: key);

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  List<Widget> gifUrls = [];
  final int gifLimit = 10;
  final searchText = "Type GIF...";
  final searchButtonText = "Search";
  final apiKey = "AIzaSyAwB95a_fnmnNIibdZGGjKQALCktdl_e4c";
  String typedGif = "";
  var gif_data;
  @override
  void initState() {
    // TODO: implement initState
    getGifsForStart();
    super.initState();
  }

  Future<void> getGifsForStart() async {
    gif_data = await http.get(Uri.parse(
        "https://tenor.googleapis.com/v2/search?q=excited&key=$apiKey&client_key=my_test_app&limit=$gifLimit"));
    var gifDataParse = jsonDecode(gif_data.body);

    gifUrls.clear();
    for (int i = 0; i < gifLimit; i++) {
      gifUrls.add(Image.network(
          gifDataParse["results"][i]["media_formats"]["tinygif"]["url"]));
    }
    setState(() {});
  }

  Future<void> getGifsForSearch() async {
    gif_data = await http.get(Uri.parse(
        "https://tenor.googleapis.com/v2/search?q=$typedGif&key=$apiKey&client_key=my_test_app&limit=$gifLimit"));
    var gifDataParse = jsonDecode(gif_data.body);

    gifUrls.clear();
    for (int i = 0; i < gifLimit; i++) {
      gifUrls.add(Image.network(
          gifDataParse["results"][i]["media_formats"]["tinygif"]["url"]));
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              typedGif = value;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.graniteGray)),
                border: OutlineInputBorder(),
                icon: Icon(Icons.search),
                hintText: searchText),
          ),
          SizedBox(height: 5),
          ElevatedButton(
              onPressed: () async {
                await getGifsForSearch();
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  primary: AppColors.royalGreen),
              child: Text(searchButtonText)),
          Divider(color: AppColors.graniteGray),
          SingleChildScrollView(
            child: SizedBox(height: 10),
          ),
          gifUrls.isEmpty
              ? CircularProgressIndicator()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: gifUrls,
                  ),
                )
        ],
      ),
    );
  }
}
