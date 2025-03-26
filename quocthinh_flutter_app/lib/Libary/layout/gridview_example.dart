import 'package:flutter/material.dart';
import 'package:quocthinh_flutter_app/Libary/layout/Chi_Tiet_Sp.dart';
import 'package:quocthinh_flutter_app/Libary/layout/ListView.dart';
class PageGridView extends StatefulWidget {
   PageGridView({super.key});

  @override
  State<PageGridView> createState() => _PageGridViewState();
}

class _PageGridViewState extends State<PageGridView> {
   String images ="https://suckhoedoisong.qltns.mediacdn.vn/Images/_OLD/2015/4-loi-ich-tuyet-voi-cua-dau-tay-4-1422241944000.jpg";

   int Cout =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Grid View"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Stack(
            children: [
              Icon(Icons.shopping_cart,color:
                Colors.red,size: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 2),
                child: Text("$Cout",style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),),
              )
            ],
          ),
          SizedBox(width: 15,)
        ],
      ),
      body: GridView.extent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 2,
          crossAxisSpacing: 5,
      children: data.map(
        (e) {
          return Card(
            child:GestureDetector(
              child: Column(
                  children: [
                    SizedBox(
                      height:5,
                    ),
                    Expanded(
                    child: Container(
                    child: Image.network
                      (images,
                          fit: BoxFit.cover, // Đảm bảo hình ảnh vừa khung),

                    ),
                    ),
                    ),
                    SizedBox(
                         height: 5,
                    ),
                    Text(e.ten),
                    SizedBox(
                      height:5,
                    ),
                    Text("${e.gia}")
                  ],
              ),
              onTap: ()async{
                String messege = await
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageChitiet(),));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(messege)));
              },
            ),
          );
        },
        ).toList(),
      ),
    );
  }
}
