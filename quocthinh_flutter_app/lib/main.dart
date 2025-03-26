import 'package:flutter/material.dart';
import 'package:quocthinh_flutter_app/Libary/layout/ListView.dart';
import 'package:quocthinh_flutter_app/Libary/layout/gridview_example.dart';
import 'package:quocthinh_flutter_app/Libary/layout/page_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://inynpdivcfhoghvpcqnf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlueW5wZGl2Y2Zob2dodnBjcW5mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxODE2NzUsImV4cCI6MjA1Nzc1NzY3NX0.hUkyfocm8qEr2Mhl4vtlQywUTDs3R2hRzXBBOkmCBEQ',
  );
  child: CircularProgressIndicator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PageHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mes = "Hello";
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNgaysinh = TextEditingController();
  Widget? selectedScreen;

  String image = "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/bugger-online-order-design-template-dc78976e774b67ba5167353003305569_screen.jpg?ts=1625555973";

  @override
  void initState() {
    super.initState();
    txtName.text = "Phung Quoc Thinh";
    txtNgaysinh.text = "07/01/2004";
    selectedScreen = homeScreen(); // Hiển thị trang chủ mặc định
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("My APP"),
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Text("Welcome"),
            ),
            ListTile(
              title: const Text("GridView"),
              onTap: () {
                setState(() {
                  selectedScreen = PageGridView(); // Chuyển sang GridView
                });
                Navigator.pop(context); // Đóng Drawer
              },
            ),
            ListTile(
              title: const Text("Danh sách sản phẩm"),
              onTap: () {
                setState(() {
                  selectedScreen = PageListView(); // Chuyển sang ListView
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Trang chủ"),
              onTap: () {
                setState(() {
                  selectedScreen = homeScreen(); // Quay lại trang chủ
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: selectedScreen ?? homeScreen(), // Hiển thị màn hình đã chọn
    );
  }

  Widget homeScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 400,
              height: 300,
              child: Image.network(image),
            ),
            Text(
              mes,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Hello ${txtName.text}"),
            TextField(
              controller: txtName,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Phung Quoc Thinh",
              ),
            ),
            TextField(
              controller: txtNgaysinh,
              decoration: const InputDecoration(
                labelText: "Ngày Sinh",
                hintText: "07/01/2004",
              ),
              keyboardType: TextInputType.datetime,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  mes = (mes == "Hello") ? "Chào" : "Hello";
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Chào ${txtName.text}"),
                    duration: const Duration(seconds: 5),
                  ),
                );
              },
              child: const Text("Click me!"),
            ),
          ],
        ),
      ),
    );
  }
}
