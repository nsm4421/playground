part of 'datasource.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> saveEmailAndPassword(String email, String password) async {
    final box = await _openBox(Boxes.credential.name);
    await box.put('email', email);
    await box.put('password', password);
  }

  @override
  Future<Map<String, String?>> getEmailAndPassword() async {
    final box = await _openBox(Boxes.credential.name);
    return {
      'email': box.get("email", defaultValue: null),
      'password': box.get("password", defaultValue: null)
    };
  }

  @override
  Future<void> deleteEmailAndPassword() async {
    final box = await _openBox(Boxes.credential.name);
    await box.deleteFromDisk();
  }

  Future<Box> _openBox(String boxName) async => await Hive.openBox(boxName);
}
