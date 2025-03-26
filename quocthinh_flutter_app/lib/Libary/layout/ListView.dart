import 'package:flutter/material.dart';
import 'package:quocthinh_flutter_app/Libary/layout/ListView.dart';
class PageListView extends StatefulWidget {
  const PageListView({super.key});

  @override
  State<PageListView> createState() => _PageListViewState();
}

class _PageListViewState extends State<PageListView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My list View"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var itemData = data[index];
            return ListTile(
              leading: Text("${index+1}.",style: TextStyle(
                fontSize: 16
              ),),
              title: Text(itemData.ten),
              subtitle: Text("Trái cay viet Text", style:
                TextStyle(
                  fontStyle: FontStyle.italic
                ),),
              trailing: Text("${itemData.gia} VND",style: 
              TextStyle(color: Colors.teal),),
              onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text("Bạn da chon san pham ${itemData.ten}"),
                  duration: Duration(seconds: 5),),
                );
              },
            );
          },
          separatorBuilder:(context, index) => Divider(
            thickness: 1.5,
          ) ,
          itemCount: data.length
      ),// ham khoi tao
    );
  }
}
class SanPham{
  String ten;
   int gia;

   SanPham({
    required this.ten,
    required this.gia
  });
}
var data = [
  SanPham(ten: "Buger Gà", gia: 5000),
  SanPham(ten: "Pizza ", gia: 3200),
  SanPham(ten: "Gà Rán", gia: 70000),
  SanPham(ten: "Khoai Tây Chiên", gia: 26600),
  SanPham(ten: "Bánh Mì Kẹp Thịt", gia: 6000),
  SanPham(ten: "Xúc Xích", gia: 4000),
  SanPham(ten: "Mì Ý", gia: 7000),
  SanPham(ten: "Bánh Tacos", gia: 500),
  SanPham(ten: "Gỏi Cuốn", gia: 3000),
  SanPham(ten: "Chả Giò", gia: 4000),
  SanPham(ten: "Bánh Bao", gia: 2000),
  SanPham(ten: "Há Cảo", gia: 5000),
  SanPham(ten: "Bún Chả", gia: 6000),
  SanPham(ten: "Phở Cuốn", gia: 5000),
  SanPham(ten: "Bánh Tráng Nướng", gia: 4000),
  SanPham(ten: "Xiên Que", gia: 3000),
  SanPham(ten: "Nem Chua Rán", gia: 5000),
  SanPham(ten: "Bánh Gối", gia: 4000),
  SanPham(ten: "Súp Cua", gia: 6000),
  SanPham(ten: "Bánh Mì Que", gia: 2000),
  SanPham(ten: "Chè", gia: 3000),
  SanPham(ten: "Sinh Tố", gia: 4000)
];
