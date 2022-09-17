import 'package:flutter/material.dart';

import 'dbHelper/mongodb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mongo Test"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await MongoDatabase.connect();
            },
            child: const Text("Connect"),
          ),
        ],
      ),
    );
  }
}
