import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{

  // final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  final  storage = const FlutterSecureStorage();

  writeData(String key, String value) async{
    await storage.write(key: key, value: value, aOptions: _getAndroidOptions(), );
  }
  readData(String key) async{
    String value = storage.read(key: key,aOptions: _getAndroidOptions()).toString();
    print('$value ');
    return value;
  }
  deleteData(String key) async{
    await storage.delete(key: key);
  }

}