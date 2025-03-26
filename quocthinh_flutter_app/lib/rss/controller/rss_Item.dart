import 'package:quocthinh_flutter_app/rss/model/rss_resource.dart';

class RssItem{
  late String title,link,pubDate;
  String? imageUrl, description;
  RssItem.empty();

  RssItem fromJson(Map<String,dynamic> map,RssRsources rsources){
    this.title = map["title"];
    this.link = map["link"];
    this.pubDate = map["pubDate"];
    this.imageUrl = getImageUrl(map["description"], rsources);
    this.description= getDescriptionUrl(map["description"], rsources);
    return this;
  }
}
String? getImageUrl(String rawDescription, RssRsources rsource){
  String startRegrex = rsource.startImageRegrex;
  String endRegrex = rsource.endImageRegrex;
  int start = rawDescription.indexOf(startRegrex)+startRegrex.length;
  if(start>=startRegrex.length){
    if(endRegrex.length>0){
      int end = rawDescription.indexOf(endRegrex,start);
      return rawDescription.substring(start,end);
    }
    return rawDescription.substring(start);
  }
  return null;
}

String? getDescriptionUrl(String rawDescription, RssRsources rsource){
  String startRegrex = rsource.startDescriptionRegrex;
  String endRegrex = rsource.endDescriptionRegrex;
  int start = rawDescription.indexOf(startRegrex)+startRegrex.length;
  if(start>=startRegrex.length){
    if(endRegrex.length>0){
      int end = rawDescription.indexOf(endRegrex,start);
      return rawDescription.substring(start,end);
    }
    return rawDescription.substring(start);
  }
  return null;
}