import 'package:get/get.dart';

import '../model/model.dart';

class CotrollerFruit extends GetxController{
  var fruits = <Fruit>[];
  var gh = <GH_Item>[];
  static CotrollerFruit get()=> Get.find();
  int get slGHMH =>gh.length;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // fruits =FruitSnapshot.getALL();
    // update(["fruits"]);
    _docDL();
  }
  _docDL() async{
    fruits = await FruitSnapshot.getFuirts();
    update(["fruits"]);
}

  themMHGH(Fruit f){
    for(var item in gh){
      if(item.fruit.id == f.id){
        item.sl++;
            return;
      }
    }
    gh.add(GH_Item(fruit: f, sl: 1));
    update(["fruits"]);
  }
}
class BingdingAppFruitStore extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => CotrollerFruit(),);
  }
}
class GH_Item{
  Fruit fruit;
  int sl;
  GH_Item({required this.fruit, required this.sl});
}