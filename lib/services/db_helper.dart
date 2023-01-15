import 'dart:async';
import 'package:car_portal/Models/carmodel.dart';
import 'package:car_portal/Models/usermodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;

  late Database _db;

  final carstore = intMapStoreFactory.store('cars');
  final userStore = intMapStoreFactory.store('users');

  static final SembastDb _singleton = SembastDb._internal();

  SembastDb._internal();

  factory SembastDb() {
    return _singleton;
  }

  Future<Database> init() async {
    _db = await _openDb();
    return _db;
  }

  Future _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'users.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<void> cardataInsert(CarModel carModel) async {
    await carstore.add(_db, carModel.toMap());
    Fluttertoast.showToast(msg: "car registed successfully");
  }

  Future carUpdateData(CarModel carModel) async {
    await init();

    final finder = Finder(
      filter: Filter.byKey(carModel.id!),
    );
    await carstore.update(_db, {}, finder: finder);

    Fluttertoast.showToast(msg: "car updated successfully");
    await _db.close();
  }

  Future carDeletedData(CarModel carModel) async {
    await init();
    final finder = Finder(
      filter: Filter.byKey(carModel.id!),
    );
    await carstore.delete(_db, finder: finder);
    await _db.close();
  }

  Future<int> countRegisterCar() async {
    await init();

    var count = await carstore.count(_db);
    await _db.close();

    return count;
  }

  Future<List<CarModel>> getAllCarData() async {
    await init();
    final finder = Finder(sortOrders: [
      SortOrder('make'),
    ]);

    final recordSnapshots = await carstore.find(
      await _db,
      finder: finder,
    );
    await _db.close();

    return recordSnapshots.map<CarModel>((snapshot) {
      final car = CarModel.fromMap(snapshot.value);
      car.id = snapshot.key;
      return car;
    }).toList();
  }

  Future allDeletedCarData() async {
    await init();
    await carstore.delete(_db);
    await _db.close();
  }

  Future<int> signup(UserModel userModel) async {
    // Create a new user object
    var value1;
    // Insert the user into the store
    await userStore.add(_db, userModel.toMap()).then((value) {
      if (value != null) {
        value1 = value;
        Fluttertoast.showToast(msg: "UserCreateSuccessfully");
        return value;
      } else {
        value1 = 0;
        return 0;
      }
    });
    return value1;
  }

  Future<bool> signin(String email, String password) async {
    await init();

    // Find the user by email
    final finder = Finder(
        filter: Filter.equals(
      'email',
      email,
    ));
    final user = await userStore.findFirst(_db, finder: finder);

    // Check if the user exists and the password is correct
    await _db.close();

    if (user != null &&
        user['password'] == password &&
        user['email'] == email) {
      Fluttertoast.showToast(msg: "Login Successfully");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Email and Password wrong");

      return false;
    }
  }

  Future<bool> session() async {
    await init();

    // final finder = Finder(filter: Filter.equals('id', v));
    final user = await userStore.count(_db);
    await _db.close();
    if (user == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future deleteAll() async {
    await init();
    await userStore.delete(_db);
  }
}
