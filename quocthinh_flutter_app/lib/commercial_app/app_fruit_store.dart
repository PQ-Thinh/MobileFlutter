import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:badges/badges.dart' as badges;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quocthinh_flutter_app/commercial_app/page_chitiet_fruit.dart';

//import 'cotroller/Cotroller_fruit.dart';
import 'cotroller/cotroller_ver2.dart';
import 'model/model.dart';
class AppFruitStore extends StatelessWidget {
  const AppFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Fruit App Store",
      initialBinding: BingdingAppFruitStore(),

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageHomeFruitStore(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class  PageHomeFruitStore extends StatelessWidget {
  const  PageHomeFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fruit Store "),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions:[
          GetBuilder(
            id:"fruits",
              init: CotrollerFruit.get(),
              builder: (controller) => badges.Badge(
                showBadge: controller.slGHMH>0,
               badgeContent: Text('${controller.slGHMH}',style: TextStyle(color: Colors.white),),
                child: Icon(Icons.shopping_cart),
              ),
               ),
          SizedBox(
            width: 20,
          )
        ]
      ),
      body: GetBuilder(
        id: "fruits",
          init: CotrollerFruit.get(),
          builder: (controller) {
            var fruits = controller.fruits;
            return GridView.extent(
              maxCrossAxisExtent: 300,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.75,
              children: fruits.map(
                (e) => Card(
                  child: GestureDetector(// tạo sự kiện onTap
                    onTap: () {
                      Get.to(PageChitietFruit(fruit: e));
                    },
                    child: Column(
                        children: [
                          SizedBox(
                            height:6,
                                width:7
                          ),
                          Expanded(
                            child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10), // Bo góc nếu cần
                                  child: AspectRatio(
                                    aspectRatio: 1, // Tỷ lệ vuông 1:1
                                    child: Image.network(
                                      e.anh ?? "Link ảnh mặc định",
                                      fit: BoxFit.cover, // Cắt ảnh để lấp đầy khung hình vuông
                                    ),
                                  ),
                                )

                            ),
                          ),

                          Text(e.ten,
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),),

                          Text("${e.gia} Vnd",style:TextStyle(
                            color:Colors.red
                          ))

                        ]),
                  ) ,

                ),
              ).toList(),
            );
          },),
    );
  }
}

