import 'package:mongo_app/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../Model/user_model.dart';

class MongoDatabase {
  static late DbCollection userCollection;
  static late Db db;
  static String userNameKey = "name";
  static String userSurNameKey = "surname";
  static String userNumberKey = "number";

  // MongoDataBase ile bağlantı sağlıyoruz ve DataBase'i açıyoruz.
  static connectDatabase() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    // inspect(db);
    userCollection = db.collection(USER_COLLECTION); // DataBase'imizde bulunan Collection'na bağlantı sağlıyoruz.
  }

  // Datamızı DataBase ekliyoruz.
  static Future<DataProcess> insert(UserModel userData) async {
    try {
      WriteResult result = await userCollection.insertOne(userData.toJson());
      if (result.isSuccess) {
        return DataProcess.addDataSuccessfull;
      } else {
        return DataProcess.addDataError;
      }
    } catch (e) {
      /*if (kDebugMode) {
        print(e.toString());
      }*/
      return DataProcess.addDataError;
    }
  }

  // _id'ye göre datamızı güncelliyoruz.
  static Future<DataProcess> updateData(UserModel modelData) async {
    try {
      var result = await userCollection.findOne({"_id": modelData.id});
      result![userNameKey] = modelData.name;
      result[userSurNameKey] = modelData.surname;
      result[userNumberKey] = modelData.number;
      userCollection.update(where.eq('_id', modelData.id), result);
      return DataProcess.updateDataSuccessfull;
    } catch(e){
      return DataProcess.updateDataError;
    }
  }

  // _id ye göre datamızı siliyoruz.
  static deleteData(ObjectId userId){
    userCollection.remove(where.id(userId));
  }

  /* name key değerine (kullanıcı adı) göre MongoDataBase'imizden sorgulama yapıyoruz ve bulunan dataları listeye 
  çevirerek geri dödürüyoruz. */
  static Future<List<Map<String, dynamic>>> queryData(String name) async {
    /* Herhani bir aralığa göre şartlı sorgulama yapmak için bu kodu kullanıyoruz */
    //final queryData = await userCollection.find(where.eq(userNameKey, name)).toList();

    /* büyük küçük harf DUYARLI sorgulama yapmak için bu kodu kullanıyoruz. */
    //final queryData = await userCollection.find({userNameKey : name}).toList();

    /* büyük küçük harf DUYARSIZ sorgulama yapmak için bu kodu kullanıyoruz. */
    final queryData = await userCollection.find({userNameKey: {"\$regex": name.toLowerCase(),"\$options":"i"}}).toList();
    return queryData;
  }

  // MongoDataBase'imizden tüm dataları çekiyoruz ve listeye çevirerek geri döndürüyoruz.
  static Future<List<Map<String, dynamic>>> getData() async {
    final allData = await userCollection.find().toList();
    return allData;
  }
}

enum DataProcess {
  addDataError,
  addDataSuccessfull,
  updateDataSuccessfull,
  updateDataError
}
