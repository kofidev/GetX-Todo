import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/data/models/task.dart';
import 'package:getx_todo/app/modules/home/controller.dart';
import 'package:getx_todo/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          debugPrint('Clicked ');
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: Form(
                key: homeController.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homeController.addformController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your task';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map(
                              (e) => Obx(
                                () {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    label: e,
                                    selectedColor: Colors.grey[200],
                                    selected:
                                        homeController.chipIndex.value == index,
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                    onSelected: (bool selected) {
                                      homeController.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0.wp),
                      child: ElevatedButton(
                          onPressed: () {
                            if (homeController.formKey.currentState!
                                .validate()) {
                              int icon = icons[homeController.chipIndex.value]
                                  .icon!
                                  .codePoint;
                              String color =
                                  icons[homeController.chipIndex.value]
                                      .color!
                                      .toHex();
                              var task = Task(
                                title: homeController.addformController.text,
                                icon: icon,
                                color: color,
                              );
                              Get.back();
                              homeController.addTask(task)
                                  ? EasyLoading.showSuccess(
                                      'Created Successfully')
                                  : EasyLoading.showError('Duplicated Task');
                              homeController.addformController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
              onWillPop: () {
                homeController.addformController.clear();
                homeController.changeChipIndex(0);
                return Future.value(true);
              });
        },
        child: DottedBorder(
          color: Colors.blueGrey,
          dashPattern: [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
            ),
          ),
        ),
      ),
    );
  }
}
