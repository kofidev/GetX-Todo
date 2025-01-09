import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value;
    var color = HexColor.fromHex(task!.color!);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back))
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                IconData(
                  task.icon,
                  fontFamily: 'MaterialIcons',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
