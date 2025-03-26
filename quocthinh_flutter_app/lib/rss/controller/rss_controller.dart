import 'dart:convert';

import 'package:get/get.dart';
import 'package:quocthinh_flutter_app/rss/model/rss_resource.dart';

import 'package:http/http.dart' as http;
import 'package:quocthinh_flutter_app/rss/controller/rss_Item.dart';
import 'package:xml2json/xml2json.dart';
class RssController extends GetxController{
  late RssRsources currentRsources;
  late String currentUrl;
  late List<String> headers;
  late String currentHeader;

  @override
  void onInit() {
    // TODO: implement dispose
    super.onInit();
    currentRsources = rssRsources[0];
    currentUrl = currentRsources.headers.values.toList()[0];
    headers= currentRsources.headers.keys.toList();
    currentHeader = headers[0];
  }
  refresh(){
    update(["rss"]);
}
changedHeader(String? value){
    if(value!=null)
      if(value!=currentHeader){
        currentHeader=value;
        update(["header"]);
        currentUrl=currentRsources.headers[currentHeader]!;
       refresh();
      }
}
  Future<List<RssItem>> readRss() async{

    var response = await http.get(Uri.parse(currentUrl));
    if(response.statusCode==200) {
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(utf8.decode(response.bodyBytes));
      String jsonStr = xml2json.toParker();
      var data = json.decode(jsonStr)["rss"]["channel"]["item"] as List;
      return data.map(
        (e) => RssItem.empty().fromJson(e,currentRsources),
      ).toList();
    }
    return Future.error("Lôi đọc rss");
  }
}