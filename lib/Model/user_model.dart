import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.name,
        required this.surname,
        required this.number,
    });

    ObjectId id;
    String name;
    String surname;
    String number;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        surname: json["surname"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "surname": surname,
        "number": number,
    };
}