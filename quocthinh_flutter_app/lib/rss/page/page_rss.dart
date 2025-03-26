import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quocthinh_flutter_app/rss/controller/rss_controller.dart';
import 'package:quocthinh_flutter_app/rss/page/page_url.dart';
import 'package:quocthinh_flutter_app/rss/controller/rss_Item.dart';

class PageRss extends StatelessWidget {
   PageRss({super.key});

   final controller = Get.put(RssController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rss"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
         GetBuilder<RssController>(
              id: "header",
             init: controller,
             builder: (controller) {
               var list = controller.headers;
               return DropdownButton<String>(
                 value: controller.currentHeader,
                   items: list.map(
                     (e) => DropdownMenuItem<String>(
                       value: e,
                         child: Text(e)),
                   ).toList(),
                   onChanged: (value) {
                     controller.changedHeader(value);
                   },);
             },
         )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.refresh();
        },
        child: GetBuilder<RssController>(
            id: "rss",
            init: controller,
            builder: (controller) => FutureBuilder<List<RssItem>>(
                future: controller.readRss(),
                builder: (context,snapshot){
                    if(snapshot.hasError){
                      return Center(
                        child: Text("Lỗi rồi"),
                      );
                    }if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    }
                    var list = snapshot.data!;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                       var item = list[index];

                        return Padding(
                          padding: const EdgeInsets.only(left: 6,right: 6),
                          child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                              onTap:() {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)     => PageUrl(link: item.link),));
                              } ,

                               child: Row(
                                 children: [
                                   Expanded(
                                          flex: 1,
                                     child:
                                   item.imageUrl==null?
                                   Center(
                                     child: Column(
                                       children: [
                                         Icon(Icons.image_not_supported,
                                         size: 60,),
                                         Text("chưa có anh")
                                       ],
                                     ),
                                   )
                                                       :Image.network(item.imageUrl!),

                                   ),
                                   SizedBox(width: 5,),
                                   Expanded(
                                     flex: 2,
                                       child: Text(
                                     item.title??"",
                                     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),

                                   ))
                                 ],

                               ),
                              ),
                              SizedBox(height: 5,),
                              Text(item.description??"")


                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: list.length,
                      );
           },
        ),
             ),
      ),
    );
  }
}
