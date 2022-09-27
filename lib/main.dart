import 'package:flutter/material.dart';
import 'package:mongo_app/dbHelper/mongodb.dart';
import 'package:mongo_app/view/mainPage/main_page.dart';
import 'package:mongo_app/view_model/home_page_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  await MongoDatabase.connectDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: MaterialApp(
        title: 'MongoDataBase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}
