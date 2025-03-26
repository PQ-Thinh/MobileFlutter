import 'package:flutter/material.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  DateTime ngaysinh = DateTime(2004,1,7);
  String? gioiTinh = "Nam";
  List<String> nnlts = ["Java", "Python", "Kotlin", "Golang", "Ruby", "C#","C++"];
  String? nnlt = "Java";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
       selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              label:"Home",
                icon:Icon(Icons.home,color: Colors.blue,)),
            BottomNavigationBarItem(
                label:"SMS",
                icon:Icon(Icons.sms,color: Colors.orange,)),
            BottomNavigationBarItem(
                label:"Phone",
                icon:Icon(Icons.phone,color: Colors.green,))
          ],
          onTap: (value) {
            setState(() {
              index=value;
            });
          },
      ),
      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Phùng Quốc Thịnh"),
                accountEmail:Text("thinh.pq.64cntt@ntu.edu.vn"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("asset/images/anhnen.jpg"),
            ),
            ),
            ListTile(
              leading: Icon(Icons.sms),
              title: Text("SMS"),
              trailing: Text("10"),
              onTap: () {
                setState(() {
                  Navigator.of(context).pop();
                  index = 1;
                });
              },

            ),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text("Drafts"),

            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text("Sent"),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),

            ),

          ],
        ),
      ),
    );
  }
  Widget _buildHome(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*3/4,
                child: Image.asset("asset/images/anhnen1.jpg"),
              ),
            ),
            SizedBox(height: 15,),
            Text("Họ và Tên:",style: TextStyle(fontSize: 15),),
            Text("Phùng Quốc Thịnh",style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green
            ),),
            SizedBox(height: 15,),
            Text("Ngay Sinh:",style: TextStyle(fontSize: 15),),
            Row(
              children: [
                Expanded(child:
                Text("${ngaysinh.day}/${ngaysinh.month}/${ngaysinh.year}",
                  style: TextStyle(fontSize: 20),)),
                IconButton(
                    onPressed:() async{
                      DateTime? selectedDate = await
                      showDatePicker(
                          context: context,
                          initialDate: ngaysinh,
                          firstDate: DateTime(1920), lastDate: DateTime(2050));
                      if(selectedDate!=null){
                        setState(() {
                          ngaysinh=selectedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month)),
                SizedBox(width: 80,)
              ],
            ),
            SizedBox(height: 15,),
            Text("Giới Tính:",style: TextStyle(fontSize: 15),),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text("Nam"),
                    value: "Nam", //Không thay doi
                    groupValue: gioiTinh,//Thay doi, khi groupvalue = value thì Radiobutton se duoc chon
                    onChanged:(value) {
                      setState(() {
                        gioiTinh= value;
                      });
                    },),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Nữ"),
                    value: "Nữ", //Không thay doi
                    groupValue: gioiTinh,//Thay doi, khi groupvalue = value thì Radiobutton se duoc chon
                    onChanged:(value) {
                      setState(() {
                        gioiTinh= value;
                      });
                    },),
                )
              ],
            ),
            SizedBox(height: 15,),
            Text("Sở thích",style: TextStyle(fontSize: 15),),
            Text("Xem Phim, Nghe Nhạc,Đọc sách, Nấu Ăn, Ngủ...",
              style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold,
                  color: Colors.teal),),
            SizedBox(height: 15,),
            Text("Ngôn ngữ lập trình giỏi nhất của bạn",style: TextStyle(fontSize: 15),),
            DropdownButton<String>(
              isExpanded: true,
              value: nnlt,// Thay doi khi value bang voi value cua dropdownmenuitem thi icon do se duoc chon
              items: nnlts.map(
                    (e) {
                  return DropdownMenuItem<String>(
                      value:e,
                      child:Text(e));
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  nnlt=value;
                });
              },)

          ],
        ),
      ),
    );
  }
  Widget _buildSMS(){
    return Center(
      child: Text("SMS",style: TextStyle(fontSize: 20),),
    );
  }
  Widget _buildPhone(){
    return Center(
      child: Text("Phone",style: TextStyle(fontSize: 20),),
    );
  }
  Widget _buildBody(int index){
    switch(index){
      case 0: return _buildHome();
      case 1: return _buildSMS();
      case 2: return _buildPhone();
      default: return _buildPhone();
    }
  }
}
