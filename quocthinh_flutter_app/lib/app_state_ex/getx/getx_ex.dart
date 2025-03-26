import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerCounter extends GetxController{
  final _counter =0.obs;
  //final count2 =0.obs;
  int get counter => _counter.value;

  void increase(){
    _counter.value++;
  }
  void decrease(){
    _counter.value--;
  }

}
class PageCounterGetx extends StatelessWidget {
   PageCounterGetx({super.key});
  final ControllerCounter c = Get.put(ControllerCounter());
  final ControllerCounter c1 = Get.put(ControllerCounter(),tag: "My tag");
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My GETx"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Obx(()=>Text("${c.counter}"),),
            ElevatedButton(
                onPressed:() {
                  c.increase();
                } ,
                child: Text("+",)),
            Obx(()=>Text("Cotroller: ${c.counter}",style: TextStyle(fontSize: 20),)),
            GetX<ControllerCounter>(
              builder:(controller) => Text("${controller.counter}"),),
            GetX<ControllerCounter>(
              tag: "My tag",
              builder:(controller) => Text("${controller.counter}"),),
            ElevatedButton(
                onPressed:() {
                  c1.decrease();
                } ,
                child: Text("-")),
          ],
        ),
      ),
    );
  }
}
