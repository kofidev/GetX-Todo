import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/data/models/task.dart';
import 'package:getx_todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final addformController = TextEditingController();
  final tasks = <Task>[].obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTask());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void changeTask(Task? select) {
    Task.value = select;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  @override
  void onClose() {
    addformController.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) => chipIndex.value = value;

  void deleteTask(Task task) {
    tasks.remove(task);
  }
}
