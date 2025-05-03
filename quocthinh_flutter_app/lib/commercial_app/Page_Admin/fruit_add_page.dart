import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quocthinh_flutter_app/commercial_app/model/model.dart';
import 'package:quocthinh_flutter_app/commercial_app/supabase_helper.dart';
import 'package:quocthinh_flutter_app/my_widget/dialogs.dart';
import 'package:quocthinh_flutter_app/permission/permission_gant.dart';

class PageAddFruit extends StatefulWidget {
  const PageAddFruit({super.key});

  @override
  State<PageAddFruit> createState() => _PageAddFruitState();
}

class _PageAddFruitState extends State<PageAddFruit> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
  XFile? _xFile;
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
                child: _xFile==null ? Icon(Icons.image,size: 40,):
                    Image.file(File(_xFile!.path))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed:() async{
                        if(await requestPermission(Permission.photos)){
                          var picImages = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if(picImages!=null)
                            setState(() {
                              _xFile=picImages;
                            });
                        }

                      },
                      child: Text("Chọn ảnh")),
                  SizedBox(width: 10,),
                ],
              ),
              TextField(
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
                            if(_xFile!=null){
                              //1 upload ảnh và lấy đường dẫn
                              showSnackBar(
                                  context,
                                  message: "Đang thêm ${txtTen.text}..",
                              seconds: 5);
                              String url = await uploadImage(
                                  image: File(_xFile!.path),
                                  bucket: "imagesfruits",
                                  path:"Fruit/Fruit_${txtId.text}.jpg" );
                              Fruit fruit = Fruit(
                                id: int.parse(txtId.text),
                                ten: txtTen.text,
                                gia: int.parse(txtGia.text),
                                moTa: txtMoTa.text,
                                anh:url,
                              );
                              FruitSnapshot.insert(fruit);
                              showSnackBar(context,
                                  message: "Đã thêm ${txtTen.text}..",
                                  seconds: 5);
                            }
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
}
