
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:car_portal/Models/usermodel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

Future<void> signup(String fileName,List<UserModel> userModel) async {
  // final root =  await getApplicationDocumentsDirectory();
  // final path = root.path;
  // var filePath=File('$path/users.json').create(recursive: true);
  // log("file path  $filePath" );
  //
  //
  // String jsonString = await rootBundle.loadString('$filePath');
  // Map<String, dynamic> users = jsonDecode(jsonString);
  // users[userName] = {'username':username,'phoneNumber':phoneNumber,'email':email,'password': password};
  // File file = File('assets/users.json');
  //
  //
  // file.writeAsStringSync(json.encode(users),mode: FileMode.write,flush: Platform.isAndroid );

  final file = File(fileName);

  // Convert the List of people to a JSON string
  final jsonString = jsonEncode(userModel);

  // Write the JSON string to the file
  return file.writeAsStringSync(jsonString);

}


Future<Object> signin(String userName, String email,String password) async {
  String jsonString = await rootBundle.loadString('assets/users.json');
  Map<String, dynamic> users = jsonDecode(jsonString);
  if (users.containsKey(userName) && users[userName]['password'] == password && users[userName]['email'] ==email) {
    return Fluttertoast.showToast(msg: "Successfully login");
  } else {

    return Fluttertoast.showToast(msg: " Check Your Email and Password is not correct ");

  }
}