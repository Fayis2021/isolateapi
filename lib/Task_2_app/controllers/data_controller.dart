import 'dart:convert';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../model/api_model.dart';
import 'package:http/http.dart' as http;

class DataController extends GetxController {
  var users = <User>[].obs;

  RxBool getapicallcondition = false.obs;

  void fetchApiData() async {
    final response =
        await http.get(Uri.parse('https://www.jsonkeeper.com/b/3J3S'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final userBox = await Hive.openBox<User>('users');
      // await userBox.clear();
      userBox.addAll(data.map((json) => User.fromJson(json)));
      hiveData.assignAll(userBox.values.toList());
      getapicallcondition.value = true;
      update();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //hive

  var hiveData = <User>[].obs;

  Future<void> getmyhivedata() async {
    // update();
    final userBox = await Hive.openBox<User>('users');
    hiveData.assignAll(userBox.values.toList());
    update();
    getapicallcondition.value = true;
  }

  //.siolates

  void fetchDataInIsolate() {
    final receivePort = ReceivePort();
    Isolate.spawn(getmyApiData, receivePort.sendPort);
    receivePort.listen((message) {
      if (message is List<User>) {
        users.assignAll(message);
      }
    });
  }

  static void getmyApiData(SendPort sendPort) async {
    final response =
        await http.get(Uri.parse('https://www.jsonkeeper.com/b/3J3S'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<User> users = data.map((json) => User.fromJson(json)).toList();
      sendPort.send(users);
    }
  }
}
