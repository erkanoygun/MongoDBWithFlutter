import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../Model/user_model.dart';
import '../dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

class HomePageViewModel extends ChangeNotifier {
  bool isDataLoading = false;
  List<UserModel> dataList = [];
  List<UserModel> queryAllData = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  /* Datanın databas'e eklenme işlemi gerçekleştiriliyor ekleme işlemi tamamlandıktan sonda dialog penceresi
  kapatılıyor. */
  void insertData(BuildContext context) async {
    final navigator = Navigator.of(context);
    ObjectId _id = m.ObjectId();
    UserModel createUserModel = UserModel(
        id: _id,
        name: nameController.value.text,
        surname: surnameController.value.text,
        number: numberController.value.text);

    DataProcess result = await MongoDatabase.insert(createUserModel);
    if (result == DataProcess.addDataSuccessfull) {
      dataList.insert(0, createUserModel);
      if (kDebugMode) {
        print("DATA ADDING SUCCESSFULL");
      }
      textFieldClear();
      if (navigator.mounted) {
        navigator.pop();
      }
    } else {
      if (kDebugMode) {
        print("ERROR WHILE DATA ADDING");
      }
    }
    notifyListeners();
  }

  /* Datanın _id'ye göre gerçekleştiriliyor */
  void updateData(BuildContext context, UserModel userModel) async {
    final navigator = Navigator.of(context);
    UserModel updateUserModel = UserModel(
        id: userModel.id,
        name: nameController.value.text,
        surname: surnameController.value.text,
        number: numberController.value.text);
    DataProcess result = await MongoDatabase.updateData(updateUserModel);
    textFieldClear();

    /*Bu kısımda data güncelleme işleminin mongo database tarafında başarılı olması durumunda güncellenen user model
    _id değerine göre bellekte tutulan liste içerisinde bulunarak siliniyor ve bulunduğu index'e güncel hali tekrar
    ekleniyor bu şekile user model bellekte tutulan liste içerisinde de güncellenmiş oluyor. */
    if (result == DataProcess.updateDataSuccessfull) {
      int dataIndex =
          dataList.indexWhere((element) => element.id == userModel.id);
      dataList.removeAt(dataIndex);
      dataList.insert(dataIndex, updateUserModel);
    }
    else if(result == DataProcess.updateDataError){
      if (kDebugMode) {
        print("**************** DATA UPDATE ERROR ******************");
      }
    }

    if (navigator.mounted) {
      navigator.pop();
    }
    notifyListeners();
  }

  /* Data _id değerine göre mongo database den ve bellekte tutulan listeden siliniyor. */
  void deleteData(ObjectId userId) async {
    await MongoDatabase.deleteData(userId);
    int dataIndex = dataList.indexWhere((element) => element.id == userId);
    dataList.removeAt(dataIndex);
    notifyListeners();
  }

  /* Bu metod ile user model'in name değerine göre mongo database'de sorgulama yapılıyor ve bulunan user modeller
  queryAllData adlı listeye ekleniyor data bulunamaması durumunda listeye herhangi bir şey eklenmiyor. Ayrıca
  her arama işleminden önce liste içerisi temizleniyor bu şekile liste sürekli olarak yeni sorgular ile 
  dolduruluyor. */
  void queryData(String name) async {
    queryAllData.clear();
    isDataLoading = true;
    List<Map<String, dynamic>> queryData = await MongoDatabase.queryData(name);
    for (Map<String, dynamic> i in queryData) {
      queryAllData.add(UserModel.fromJson(i));
    }
    isDataLoading = false;
    notifyListeners();
  }

  /* Bu metod ile mongo database'de bulunan data List<Map<String, dynamic>> tipinde alınıyor ve UserModel sınıfının
  fromJson metodu ile  Map<String, dynamic> tipine dönüştürülerek dataList adlı listeye ekleniyor*/
  void getData() async {
    isDataLoading = true;
    dataList.clear();
    List<Map<String, dynamic>> allData = await MongoDatabase.getData();
    for (Map<String, dynamic> i in allData) {
      dataList.add(UserModel.fromJson(i));
    }
    /* Bu kısımda mongo database'den çekilen datalar herhangi bir şarta göre sıralanarak çekilmediği için default
    olarak son eklenen değer en son geliyor bu durumda son eklenen değerin listenin en başına gelecek şekilde sıralanmasını
    istediğimiz için dataList'i ters çeviriyoruz. */
    dataList =
        dataList.reversed.toList();
    isDataLoading = false;
    notifyListeners();
  }

  /* Bu metod çağrıldığı yerde dialog penceresinin içerisinde buluna TextField'ların içerisini temizliyor. */
  void textFieldClear(){
    nameController.clear();
    surnameController.clear();
    numberController.clear();
  }

}
