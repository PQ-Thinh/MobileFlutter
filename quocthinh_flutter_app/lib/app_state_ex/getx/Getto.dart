import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'getx_simple_state_manager.dart';

class PageNext extends StatelessWidget {
  const PageNext({super.key});

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
              init: CotrollerSimpleState.get(),
                id: "01",
                builder: (controller) => Text(
                  "01: ${controller.counter}",style: TextStyle(fontSize: 20),)),
            GetBuilder<CotrollerSimpleState>(
               init: CotrollerSimpleState.get(),
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
          ],
        ),
      ),
    );
  }
}
