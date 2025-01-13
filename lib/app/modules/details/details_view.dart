import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value;
    var color = HexColor.fromHex(task!.color!);
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.updateTodos();
                        homeController.changeTask(null);
                        homeController.addformController.clear();
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                  ),
                  SizedBox(width: 2.0.wp),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                var totalTodos = homeController.doingTodos.length +
                    homeController.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0.wp, right: 16.0.wp, top: 3.0.wp),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeController.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                              colors: [
                                color.withValues(
                                  alpha: 0.5,
                                  red: 1.0,
                                  blue: 0.8,
                                  green: 0.9,
                                ),
                                color
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          unselectedGradientColor: LinearGradient(
                            colors: [Colors.grey[300]!, Colors.grey[300]!],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeController.addformController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400],
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        var success = homeController
                            .addTodo!(homeController.addformController.text);
                        if (success) {
                          EasyLoading.showSuccess('Todo item add success');
                        } else {
                          EasyLoading.showError('Tod item already exist');
                        }
                        homeController.addformController.clear();
                      }
                    },
                    icon: const Icon(Icons.done),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
