import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(DrumMachine());
}

class DrumMachine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DrumPage(),
      ),
    );
  }
}

class DrumPage extends StatelessWidget {
  DrumPage({Key? key}) : super(key: key);
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              onPressed: () {
                player.play(AssetSource("assets/bip.wav"));
              },
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () {
                player.setSource(AssetSource("assets/bip.wav"));
              },
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
