import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quocthinh_flutter_app/commercial_app/model/model.dart';
import 'package:badges/badges.dart' as badges;

import 'cotroller/cotroller_ver2.dart';
//import 'cotroller/Cotroller_fruit.dart';

class PageChitietFruit extends StatelessWidget {
   PageChitietFruit({super.key, required this.fruit});
   double rating = getRating();
  Fruit fruit;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.ten),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Image.network(fruit.anh??"link anh mac dinh",
                  width: MediaQuery.of(context).size.width * 0.95,)),
            SizedBox(
              height: 10,
            ),
            Text(fruit.ten),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Giá: ${fruit.gia??0} VND"),
                SizedBox(
                  width: 20,
                ),
                Text(
                   "${((fruit.gia ?? 0) * 1.2).round()} VNĐ",
                    style: TextStyle(
                       decoration: TextDecoration.lineThrough, fontSize: 24),                 ),
              ],
                 
            ),
            SizedBox(
              height: 10,
            ),
            Text(fruit.moTa??""),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                RatingBarIndicator(
                     rating: rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                     ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
                SizedBox(height: 10,),
                Text("$rating"),
                SizedBox(height: 10,),
                Expanded(child: Text("${Random().nextInt(1000)+1} đánh giá"))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            CotrollerFruit.get().themMHGH(fruit);
          },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
double getRating(){
  return Random().nextInt(201)/100+3;
}
