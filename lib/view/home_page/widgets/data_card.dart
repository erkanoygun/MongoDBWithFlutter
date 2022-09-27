import 'package:flutter/material.dart';
import '../../../view_model/home_page_view_model.dart';
import '../../../custom/showDialog.dart';

class DataCard extends StatelessWidget {
  const DataCard({Key? key, required this.index, required this.myState})
      : super(key: key);
  final int index;
  final HomePageViewModel myState;
  final String titleShowDialog = "Update Person";
  final String buttonText = "Update Person";
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${myState.dataList[index].name} ${myState.dataList[index].surname}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  myState.dataList[index].number,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  MyDialog(
                          conetxt: context,
                          buttonText: buttonText,
                          titleShowDialog: titleShowDialog,
                          initialNameValue: myState.dataList[index].name,
                          initialNumberValue: myState.dataList[index].number,
                          initialSurnameValue: myState.dataList[index].surname,
                          userModel: myState.dataList[index],
                          buttonPressFunc: myState.updateData)
                      .simpleDialog();
                },
                icon: const Icon(Icons.edit),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () async {
                  myState.deleteData(myState.dataList[index].id);
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
