import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Provider.of<Auth>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Home Page e WELCOMEEE"),
      ),
    );
  }
}
