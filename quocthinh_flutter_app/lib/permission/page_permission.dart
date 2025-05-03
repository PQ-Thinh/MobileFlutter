import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quocthinh_flutter_app/permission/permission_gant.dart';

class PageRequestPermission extends StatelessWidget {
  const PageRequestPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async{
              String mess;
              var staus = await requestPermission(Permission.camera);
              if(staus)
                mess = "Quyền sử dụng camera đã được cấp";
              else
                mess ="Quyền sử dụng camera đã bị từ chối";
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(mess),
                    )
              );
            },
            child: Text("Permission request")),
      ),
    );
  }
}
