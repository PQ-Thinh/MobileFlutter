//https://vnexpress.net/rss/tin-moi-nhat.rss
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quocthinh_flutter_app/rss/model/rss_resource.dart';
import 'package:quocthinh_flutter_app/rss/controller/rss_Item.dart';
import 'package:xml2json/xml2json.dart';
void main() async{
  var url="https://vnexpress.net/rss/tin-moi-nhat.rss";
  var response = await http.get(Uri.parse(url));
  if(response.statusCode==200){
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(utf8.decode(response.bodyBytes));
    String jsonStr  = xml2json.toParker();
    var data = json.decode(jsonStr)["rss"]["channel"]["item"][0];
    var item = RssItem.empty().fromJson(data, rssRsources[0]);
    print(item.title);
    print(item.link);
    print(item.pubDate);
    print(item.imageUrl);
    print(item.description);
  }
}