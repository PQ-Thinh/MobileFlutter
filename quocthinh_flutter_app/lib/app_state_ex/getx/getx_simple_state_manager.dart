import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Getto.dart';

class CotrollerSimpleState extends GetxController{
  int counter =0;

  static CotrollerSimpleState get({String?tag})=> Get.find<CotrollerSimpleState>(tag: tag);
  void increase1(){
    counter++;
    update(["01"]);
  }
  void increase2(){
    counter++;
    update(["02"]);
  }
  void increaseALL(){
    counter++;
    update(["01","02"]);
  }


}
 class BindingController extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CotrollerSimpleState(),);
  }

 }

 class BindingTempoCotroller extends Bindings{
  @override
  void dependencies() {
    Get.create(() => PageNext(),
    permanent: false);
  }

 }


class GetXApp extends StatelessWidget {
  const GetXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Getxt App",
      initialBinding: BindingController(),
      home: PageSimpleState(),
    );
  }
}



class PageSimpleState extends StatelessWidget {
   PageSimpleState({super.key});

  //final c = Get.put(CotrollerSimpleState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Simple State"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<CotrollerSimpleState>(
                //init: CotrollerSimpleState.get(),
              id: "01",
                builder: (controller) => Text(
                  "01: ${controller.counter}",style: TextStyle(fontSize: 20),)),
            GetBuilder<CotrollerSimpleState>(
               // init: CotrollerSimpleState.get(),
                id: "02",
                builder: (controller) => Text(
                  "02: ${controller.counter}",style: TextStyle(fontSize: 20),)),
            ElevatedButton(
                onPressed: () {
                  CotrollerSimpleState.get().increase1();
                },
                child: Text("increase1")),
            ElevatedButton(
                onPressed: () {
                  CotrollerSimpleState.get().increase2();
                },
                child: Text("increase2")),
            ElevatedButton(
                onPressed: () {
                  CotrollerSimpleState.get().increaseALL();
                },
                child: Text("increase")),
            ElevatedButton(
                onPressed:  () {
                  Get.to(PageNext(),binding: BindingTempoCotroller());
                },
                child: Text("Next"))
          ],
        ),
      ),
    );
  }
}
