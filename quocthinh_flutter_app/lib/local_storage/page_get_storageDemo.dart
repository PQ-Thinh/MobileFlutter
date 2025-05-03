import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class PageGetStorage extends StatefulWidget {
  const PageGetStorage({super.key});

  @override
  State<PageGetStorage> createState() => _PageGetStorageState();
}

class _PageGetStorageState extends State<PageGetStorage> {
  late int count=0;
  late GetStorage box;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("GetStorage demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
      body: Center(
        child: Column(
          children: [
            Text("$count"),
            ElevatedButton(
                onPressed: () async{
                  await box.write("counter", ++count);
                  setState(() {
                    count=box.read("counter");
                  });
                },
                child: Text("tăng"))
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   inGetStorage();
  }
  Future<void> inGetStorage()async{
    await GetStorage.init();
    box = GetStorage();
    setState(() {
      count = box.read("counter")??0;
    });

  }
}

