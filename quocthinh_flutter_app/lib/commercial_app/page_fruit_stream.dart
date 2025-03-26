import 'package:flutter/material.dart';
import 'package:quocthinh_flutter_app/commercial_app/model/model.dart';

class PageFruitStream extends StatelessWidget {
  const PageFruitStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Stream"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
          stream: FruitSnapshot.getFruitsStream(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              print(snapshot.error.toString());
              return Center(child: Text("Lỗi"),);
            }if(!snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading.....")
                  ],
                ),
              );
            }
            var list = snapshot.data!;
            return GridView.extent(maxCrossAxisExtent:300,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.75,
            children: list.map(
              (fruit) => Card(
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
                                  fruit.anh ?? "Link ảnh mặc định",
                                  fit: BoxFit.cover, // Cắt ảnh để lấp đầy khung hình vuông
                                ),
                              ),
                            )

                        ),
                      ),

                      Text(fruit.ten,
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),),

                      Text("${fruit.gia} Vnd",style:TextStyle(
                          color:Colors.red
                      ))

                    ]),
              ),

            ).toList(),
            );
            }),
    );
  }
}
