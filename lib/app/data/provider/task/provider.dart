import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/keys.dart';

import '../../models/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

  // 'tasks':  [
  //   {
  //     'title': 'Work',
  //     'color': '#ff123456',
  //     'icon': 0xe123
  //   }
  // ];

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
