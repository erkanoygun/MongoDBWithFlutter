// DataBase'imizin adını tutuyor.
const DATA_BASE_NAME = "testDatabase";
// DataBase'imizde admin yetkisi olan kullanıcının, kullanıcı adını tutuyor.
const USER_NAME = "erkanoygun";
// Admin yetkisine sahip kullanıcının kullanıcı parolasını tutuyor.
const USER_PASSWORD = "mongoTest123";
// MongoDataBase ile bağlantı kurmamızı sağlayacak url.
const MONGO_CONN_URL = "mongodb+srv://$USER_NAME:$USER_PASSWORD@cluster0.6i5lrqz.mongodb.net/$DATA_BASE_NAME?retryWrites=true&w=majority";
// DataBase'imizde yer alan ve üzerine işlem yapacağımız collection'nın adını tutuyor.
const USER_COLLECTION = "testdata";