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

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }
}
