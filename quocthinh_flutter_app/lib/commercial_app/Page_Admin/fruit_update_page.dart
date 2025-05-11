import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quocthinh_flutter_app/commercial_app/model/model.dart';
import 'package:quocthinh_flutter_app/commercial_app/supabase_helper.dart';
import 'package:quocthinh_flutter_app/my_widget/dialogs.dart';
import 'package:quocthinh_flutter_app/permission/permission_gant.dart';

class PageUpdateFruit extends StatefulWidget {
   PageUpdateFruit({super.key, required this.fruit});
    Fruit fruit;
  @override
  State<PageUpdateFruit> createState() => _PageUpdateFruitState();
}

class _PageUpdateFruitState extends State<PageUpdateFruit> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
  XFile? _xFile;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: _xFile==null ?
                Image.network(widget.fruit.anh??"Link ảnh mặc định"):
                    Image.file(File(_xFile!.path))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed:() async{
                        if(await requestPermission(Permission.photos)) {
                          var picImages = await ImagePicker().pickImage(
                              source: ImageSource.gallery);
                        if (picImages != null)
                          {
                            setState(() {
                              _xFile = picImages;
                            });
                          }
                        }

                      },
                      child: Text("Chọn ảnh")),
                  SizedBox(width: 10,),
                ],
              ),
              TextField(
                readOnly: true,
                controller: txtId,
                decoration: InputDecoration(
                  labelText: "Id"
                ),
                keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false

                ),

              ),
          TextField(
            controller: txtTen,
            decoration: InputDecoration(
                labelText: "Tên"
            ),
            keyboardType: TextInputType.text
          ),
              TextField(
                  controller: txtGia,
                  decoration: InputDecoration(
                      labelText: "Giá"
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false

                  ),
              ),
              TextField(
                  controller: txtMoTa,
                  decoration: InputDecoration(
                      labelText: "Mô Tả"
                  ),
                  keyboardType: TextInputType.text
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed:() async {
                        Fruit fruit = widget.fruit;
                        showSnackBar(
                            context,
                            message: "Đang cập nhật: ${fruit.ten}...",
                        seconds: 10);
                            if(_xFile!=null){
                              //1 cập nhâtj ảnh và lấy đường đãn
                              showSnackBar(
                                  context,
                                  message: "Đang thêm ${txtTen.text}..",
                              seconds: 5);
                              String url = await updateImage(
                                  image: File(_xFile!.path),
                                  bucket: "imagesfruits",
                                  path:"Fruit/Fruit_${txtId.text}.jpg" );

                              fruit.anh = imageUrl;
                            }

                            fruit.ten = txtTen.text;
                            fruit.gia = int.parse(txtGia.text);
                            fruit.moTa =txtMoTa.text;
                            await FruitSnapshot.update(fruit);
                             showSnackBar(context,
                                message: "Đã update ${txtTen.text}..",
                                seconds: 5);
                      },
                      child: Text("Thêm")),
                  SizedBox(width: 10,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtId.text = widget.fruit.id.toString();
    txtTen.text = widget.fruit.ten;
    txtGia.text = widget.fruit.gia.toString();
    txtMoTa.text = widget.fruit.moTa??"";
  }
}