import 'package:flutter/material.dart';

import 'Task_2_app/model/api_model.dart';
import 'Task_2_app/view/home_page.dart';
// import 'package:alarm/test.dart';
// import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:path_provider/path_provider.dart' as path_provider;



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  await Hive.initFlutter();
  await Hive.openBox<User>('users');
  runApp(const MyApp2());
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

// Task2
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
