import 'package:flutter/material.dart';
import 'package:mongo_app/view/home_page/widgets/data_card.dart';
import 'package:provider/provider.dart';
import '../../view_model/home_page_view_model.dart';
import '../../custom/showDialog.dart';
import '../search_page/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key,required this.myState}) : super(key: key);
  final String titleShowDialog = "Add Person";
  final String buttonText = "Add Person";
  final String notFoundData = "Data Not Found";
  final String appBarTitle = "MongoDataBase";
  final HomePageViewModel myState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyDialog(
                  buttonText: buttonText,
                  conetxt: context,
                  titleShowDialog: titleShowDialog,
                  buttonPressFunc: myState.insertData)
              .simpleDialog();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    myState: myState
                  ),
                );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              myState.getData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        title: Text(appBarTitle),
      ),
      body: Consumer<HomePageViewModel>(
        builder: (context, mystate, child) {
          return mystate.isDataLoading
              ? const Center(child: CircularProgressIndicator())
              : mystate.dataList.isNotEmpty
                  ? ListView.builder(
                      itemCount: mystate.dataList.length,
                      itemBuilder: (context, index) {
                        return DataCard(
                          index: index,
                          myState: mystate,
                        );
                      },
                    )
                  : Center(
                      child: Text(notFoundData),
                    );
        },
      ),
    );
  }
}