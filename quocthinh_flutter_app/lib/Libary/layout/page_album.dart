import 'package:flutter/material.dart';

import '../../Json_list/Json_data.dart';
import 'package:http/http.dart' as http;
class PageAlbum extends StatelessWidget {
  const PageAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Album"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<ALbum>>(
          future: docDuLieu(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Đang tải
            }
            if (snapshot.hasError) {
              return Center(child: Text("Lỗi: ${snapshot.error}")); //  Báo lỗi
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Không có dữ liệu")); //  Không có dữ liệu
            }
            var list = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index) {
                  ALbum alb = list[index];
                  return ListTile(
                    leading: Text("${alb.id}"),
                    title: Text("${alb.title}"),
                    subtitle: Text("${alb.thumbnailUrl}"),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: list.length
            );
          },
      ),
    );
  }
}
