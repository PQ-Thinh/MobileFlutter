import 'package:flutter/material.dart';
import 'package:quocthinh_flutter_app/Libary/Profile/Page_profile.dart';
import 'package:quocthinh_flutter_app/Libary/layout/ListView.dart';
import 'package:quocthinh_flutter_app/Libary/layout/gridview_example.dart';
import 'package:quocthinh_flutter_app/Libary/layout/page_album.dart';
import 'package:quocthinh_flutter_app/app_state_ex/getx/getx_ex.dart';
import 'package:quocthinh_flutter_app/app_state_ex/getx/getx_simple_state_manager.dart';
import 'package:quocthinh_flutter_app/commercial_app/app_fruit_store.dart';
import 'package:quocthinh_flutter_app/commercial_app/page_fruit_stream.dart';
import 'package:quocthinh_flutter_app/main.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App",style:
        TextStyle(fontSize: 30,color: Colors.black),),
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
      ),
     body: SingleChildScrollView(
       child: Center(
         child: Column(
           children: [
             buildButton(context,title: "My Profile",destination: PageProfile()),
             buildButton(context,title: "My ListView",destination: PageListView()),
             buildButton(context,title: "My GridView",destination: PageGridView()),
             buildButton(context,title: "My Home",destination: MyHomePage()),
             buildButton(context,title: "Getx",destination: PageCounterGetx()),
             buildButton(context,title: "Getx_App",destination: GetXApp()),
             buildButton(context,title: "ALbum",destination: PageAlbum()),
             buildButton(context,title: "AppFruit",destination: AppFruitStore()),
             buildButton(context,title: "PageFruitStream",destination: PageFruitStream()),
           ],
         ),
       ),
     ),
    );
  }

  Widget buildButton(BuildContext context,{required String title, required Widget destination}) {
    return Container(
             width: MediaQuery.of(context).size.width*2/3,
             child: ElevatedButton(
                 onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder:(context) =>destination,));
                 },
                 child: Text(title)),
           );
  }
}
