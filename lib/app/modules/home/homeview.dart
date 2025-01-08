import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/data/models/task.dart';
import 'package:getx_todo/app/modules/home/controller.dart';
import 'package:getx_todo/app/modules/home/widgets/add_card.dart';
import 'package:getx_todo/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo/app/modules/home/widgets/task_card.dart';

class Homeview extends GetView<HomeController> {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My List',
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ...controller.tasks.map(
                    (element) => LongPressDraggable(
                      data: element,
                      onDragStarted: () => controller.changeDeleting(true),
                      onDraggableCanceled: (_, __) =>
                          controller.changeDeleting(false),
                      onDragEnd: (_) => controller.changeDeleting(false),
                      feedback: Opacity(opacity: 0.8),
                      childWhenDragging: Opacity(
                        opacity: 0.8,
                        child: TaskCard(task: element),
                      ),
                      child: TaskCard(task: element),
                    ),
                  ),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () =>
                  Get.to(() => AddDialog(), transition: Transition.downToUp),
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blueAccent,
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        // ignore: deprecated_member_use
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted successfully');
        },
      ),
    );
  }
}
