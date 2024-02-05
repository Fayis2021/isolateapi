import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';

class HomePage extends StatelessWidget {
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    dataController.fetchDataInIsolate();
                  },
                  child: const Text('Get API Datas'),
                ),
                Obx(
                  () => dataController.users.isEmpty
                      ? const Text('No api data Found')
                      : Expanded(
                          child: ListView.builder(
                            itemCount: dataController.users.length,
                            itemBuilder: (context, index) {
                              final user = dataController.users[index];
                              return ListTile(
                                title:
                                    Text("${user.firstName} ${user.lastName}"),
                                subtitle: Text(user.email),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          )),
          Expanded(
              child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    dataController.hiveData.clear();
                    dataController.fetchApiData();
                    dataController.getmyhivedata();
                  },
                  child: const Text('Get hive data'),
                ),
                Obx(
                  () => dataController.hiveData.isEmpty &&
                          dataController.getapicallcondition.value == false
                      ? const Text('No hive data Found')
                      : dataController.hiveData.isEmpty &&
                              dataController.getapicallcondition.value == true
                          ? const CircularProgressIndicator()
                          : Expanded(
                              child: ListView.builder(
                                itemCount: dataController.hiveData.length,
                                itemBuilder: (context, index) {
                                  final user = dataController.hiveData[index];
                                  return ListTile(
                                    title: Text(
                                        '${user.firstName} ${user.lastName}'),
                                    subtitle: Text(user.email),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
