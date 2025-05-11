import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quocthinh_flutter_app/commercial_app/Page_Admin/fruit_add_page.dart';
import 'package:quocthinh_flutter_app/commercial_app/Page_Admin/fruit_update_page.dart';
import 'package:quocthinh_flutter_app/commercial_app/model/model.dart';
import 'package:quocthinh_flutter_app/my_widget/async_widget.dart';
import 'package:quocthinh_flutter_app/my_widget/dialogs.dart';

class FruitPageAdmin extends StatelessWidget {
  FruitPageAdmin({super.key});
  late BuildContext mycontext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits Admin"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PageAddFruit(),)
                );
              }, 
              icon: Icon(Icons.add_circle_outline, size: 30,)),
        ],
      ),
      body: StreamBuilder<List<Fruit>>(
          stream: FruitSnapshot.getFruitsStream(),
          builder: (context, snapshot) {
            return AsyscWidget(

                snapshot: snapshot,
                builder:(context, snapshot) {

                  var list = snapshot.data! as List<Fruit>;
                  return Padding(
                    padding: const EdgeInsets.only(right: 5,left: 5),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          mycontext = context;
                          Fruit fruit = list[index];
                          return Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              extentRatio: 0.6,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 2,
                                  onPressed: (context) async{
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => PageUpdateFruit(fruit: fruit),)
                                    );
                                  },
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_forever,
                                  label: 'Cập nhật',
                                  // An action can be bigger than the others.
                                ),
                                SlidableAction(
                                  onPressed: (context) async{
                                     String? xacNhan = await showConfirmDialog(mycontext,
                                      "Bạn có muốn xóa ${fruit.ten}?");
                                      if(xacNhan=="ok"){
                                        await FruitSnapshot.delete(fruit.id);
                                        showSnackBar(mycontext, message: "Đã xóa ${fruit.ten}");
                                      }
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_forever,
                                  label: 'Xóa',
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                  fruit.anh ?? "Link ảnh mặc định",
                                  fit: BoxFit.cover, // Cắt ảnh để lấp đầy khung hình vuông
                                ),),
                                SizedBox(width:  5,),
                                Expanded(
                                  flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${fruit.id}",style: TextStyle(fontSize: 20,
                                    )),
                                    Text("${fruit.ten}",style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                    Text("${fruit.gia} vnđ",style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,color: Colors.red)),
                                    Text(fruit.moTa??""),
                                  ],
                                ))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                        itemCount: list.length
                    ),
                  );
                },);
          },),
    );
  }
}
