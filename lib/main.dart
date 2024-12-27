import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/modules/home/binding.dart';
import 'package:getx_todo/app/modules/home/homeview.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/services/storage/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Homeview(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
