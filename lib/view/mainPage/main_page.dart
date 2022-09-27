import 'package:flutter/material.dart';
import 'package:mongo_app/view/home_page/home_page.dart';
import 'package:provider/provider.dart';
import '../../view_model/home_page_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late HomePageViewModel myState;

  @override
  void initState() {
    myState = Provider.of<HomePageViewModel>(context, listen: false);
    myState.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      myState: myState,
    );
  }
}
