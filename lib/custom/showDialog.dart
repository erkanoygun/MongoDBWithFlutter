import 'package:flutter/material.dart';
import 'package:mongo_app/Model/user_model.dart';
import 'package:mongo_app/view/home_page/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../view_model/home_page_view_model.dart';

class MyDialog {
  BuildContext conetxt;
  String titleShowDialog;
  String nameLabel = "Name";
  String surnameLabel = "Surname";
  String numberLabel = "Number";
  String buttonText;
  String? initialNameValue;
  String? initialSurnameValue;
  String? initialNumberValue;
  Function buttonPressFunc;
  UserModel? userModel;
  MyDialog(
      {required this.conetxt,
      required this.titleShowDialog,
      required this.buttonText,
      this.initialNameValue,
      this.initialSurnameValue,
      this.initialNumberValue,
      this.userModel,
      required this.buttonPressFunc});

  simpleDialog() {
    return showDialog(
      context: conetxt,
      builder: (BuildContext context) {
        return Consumer<HomePageViewModel>(
          builder: (context, mystate, child) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.all(10),
              title: Text(titleShowDialog),
              children: <Widget>[
                MyTextField(
                  controller: mystate.nameController,
                  labelText: nameLabel,
                  textInputType: TextInputType.text,
                  initialValue: initialNameValue,
                ),
                MyTextField(
                  controller: mystate.surnameController,
                  labelText: surnameLabel,
                  textInputType: TextInputType.text,
                  initialValue: initialSurnameValue,
                ),
                MyTextField(
                  controller: mystate.numberController,
                  labelText: numberLabel,
                  textInputType: TextInputType.number,
                  initialValue: initialNumberValue,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (userModel != null) {
                      return buttonPressFunc(context,userModel);
                    } else {
                      return buttonPressFunc(context);
                    }
                  },
                  child: Text(buttonText),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
