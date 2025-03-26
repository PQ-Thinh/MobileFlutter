// {
// "albumId": 1,
// "id": 1,
// "title": "accusamus beatae ad facilis cum similique qui sunt",
// "url": "https://via.placeholder.com/600/92c952",
// "thumbnailUrl": "https://via.placeholder.com/150/92c952"
// }
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class ALbum{
  int albumId, id;
  String title,url,thumbnailUrl;

  ALbum({required this.albumId, required this.id, required this.title, required this.url,required this.thumbnailUrl});


  factory ALbum.fromJson(Map<String, dynamic> json) {
    return ALbum(
      albumId: json["albumId"] ,
      id: json["id"],
      title: json["title"],
      url: json["url"],
      thumbnailUrl: json["thumbnailUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "albumId": this.albumId,
      "id": this.id,
      "title": this.title,
      "url": this.url,
      "thumbnailUrl": this.thumbnailUrl,
    };
  }
}

Future<List<ALbum>> docDuLieu() async{
  Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  var reponse = await http.get(uri);
  if(reponse.statusCode==200){
      var list = json.decode(reponse.body) as List;
      List<ALbum> albums = list.map(
        (e) {
          return ALbum.fromJson(e);
        },
      ).toList();
      return albums;
  }
  return [];
}