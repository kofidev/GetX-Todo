// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:getx_todo/app/data/provider/task/provider.dart';

import '../../models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({
    required this.taskProvider,
  });

  List<Task> readTask() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
