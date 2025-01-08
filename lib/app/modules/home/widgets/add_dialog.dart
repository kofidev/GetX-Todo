import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                    color: Colors.red,
                    iconSize: 30,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent)),
                    onPressed: () {},
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 14.0.sp, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'New Task',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeController.addformController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, right: 5.0.wp, left: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...homeController.tasks.map((element) => Obx(
                  () => InkWell(
                    onTap: () => homeController.changeTask(element),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.0.wp, vertical: 3.0.wp),
                      child: Row(
                        children: [
                          Icon(
                            IconData(
                              element.icon,
                              fontFamily: 'MaterialIcons',
                            ),
                            color: HexColor.fromHex(element.color!),
                          ),
                          SizedBox(
                            width: 3.0.wp,
                          ),
                          Text(
                            element.title,
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (homeController.task.value == element)
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                            )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
