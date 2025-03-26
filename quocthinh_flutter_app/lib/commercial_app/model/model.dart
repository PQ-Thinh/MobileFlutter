//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:quocthinh_flutter_app/commercial_app/supabase_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Fruit {
  int id;
  int? gia;
  String ten;
  String? moTa, anh;

  Fruit(
      {required this.id, required this.gia, required this.ten, required this.moTa, required this.anh});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      id: json["id"],
      gia:json["gia"],
      ten: json["ten"],
      moTa: json["moTa"],
      anh: json["anh"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "gia": this.gia,
      "ten": this.ten,
      "moTa": this.moTa,
      "anh": this.anh,
    };
  }
}
  class FruitSnapshot {
    Fruit fruit;

    FruitSnapshot(this.fruit);
    Future<dynamic> update(Fruit newFruit)async{
      final supabase = Supabase.instance.client;
      var data= await supabase.from("Fruit").update(newFruit.toJson()).eq("id",fruit.id);
      return data;
    }
    Future<void> delete()async{
      final supabase = Supabase.instance.client;
      await supabase.from("Fruit").delete().eq("id",fruit.id);
      await removeImages(bucket: "imagesfruits",Path: "fruit/fruit_${fruit.id}");
      return;
    }
    static Future<dynamic> insert(Fruit newFruit)async{
      final supabase = Supabase.instance.client;
      var data=await supabase
          .from('Fruit')
          .insert({newFruit.toJson()});
      return data;
    }
    static Stream<List<Fruit>> getFruitsStream(){
     return getDataStream<Fruit>(
         table: "Fruit",
         ids: ["id"],
         fromJson: (json) => Fruit.fromJson(json),);
    }
  static Future<List<Fruit>>getFuirts() async{
      final supabase = Supabase.instance.client;
      List<Fruit> fruit= [];
      final data = await supabase
          .from('Fruit')
          .select();
      //print("DD: $data");
      fruit = data.map(
        (e) =>Fruit.fromJson(e),
      ).toList();
      //print("DL: ${fruit}");
      return fruit;
    }
    static Future<Map<int,Fruit>> getMapFruit() async{
      return getMapData<Fruit>(
          table: "Fruit",
          fromJson:(json) => Fruit.fromJson(json) ,
          getID: (t)=>t.id);
    }
    static listenFruitChange(Map<int,Fruit>maps, {Function()? updateUI}){
     listenFruitChangeData(
         maps, channel: , table: table, schema: schema, fromJson: fromJson, getID: getID)
    }
   static List<Fruit> getALL() {
    return data;
  }
  }
  final data =<Fruit>[
    Fruit(
        id: 1,
        ten: "Dâu tây",
        gia: 30000,
        moTa: "Dâu tây rất ngon",
        anh:
        "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 2,
        ten: "Chuối",
        gia: 20000,
        moTa: "Chuối thái",
        anh:
        "https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 3,
        ten: "Bơ",
        gia: 27000,
        moTa: "Bơ vơ",
        anh:
        "https://images.unsplash.com/photo-1704960961383-67dd63756199?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 4,
        ten: "Thơm",
        gia: 32000,
        moTa: "Thơm má em Hồng",
        anh:
        "https://images.unsplash.com/photo-1490885578174-acda8905c2c6?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 5,
        ten: "Chanh",
        gia: 14000,
        moTa: "Rất chua",
        anh:
        "https://images.unsplash.com/photo-1534531173927-aeb928d54385?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 6,
        ten: "Măng xôi",
        gia: 28000,
        moTa: "Ngon hết sức",
        anh:
        "https://images.unsplash.com/photo-1577003833619-76bbd7f82948?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 7,
        ten: "Việt quất",
        gia: 50000,
        moTa: "Việt ơi đừng quất Em",
        anh:
        "https://images.unsplash.com/photo-1425934398893-310a009a77f9?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 8,
        ten: "Táo",
        gia: 22000,
        moTa: "Ba quả táo rất ngọt",
        anh:
        "https://images.unsplash.com/photo-1533893662125-43c54ffa3b41?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 9,
        ten: "Cherry",
        gia: 43000,
        moTa: "Cherry Cherry lady",
        anh:
        "https://images.unsplash.com/photo-1528373553865-c5d96fe764f1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Fruit(
        id: 10,
        ten: "Thanh Long",
        gia: 27000,
        moTa: "Anh long đến rồi",
        anh:
        "https://images.unsplash.com/photo-1585138774489-caf6e48633b5?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  ];
//
