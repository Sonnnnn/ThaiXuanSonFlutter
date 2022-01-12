import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyApp11 extends StatelessWidget {
  const MyApp11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetarialApp',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  const MyHomePage({Key?key}):super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<MyHomePage>{
  var fkey = GlobalKey<FormState>();
  var txtEmail = TextEditingController();
  var txtTenDangNhap = TextEditingController();
  var txtMatKhau = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm xe vào hệ thống"),
      ),
      body: Form(
        key: fkey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(height: 5,),
              Text("Thêm xe vào hệ thống",style: TextStyle(fontSize: 35,color: Colors.orange),),
              TextFormField(
                controller: txtTenDangNhap,
                validator: (value){
                  if(value == null|| value.isEmpty)
                    return "Vui lòng nhập tên biển số xe";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.bike_scooter),
                    hintText: "Biển số xe",
                    labelText: "Biển số xe"
                ),

              ),
              TextFormField(
                controller: txtMatKhau,
                validator: (value){
                  if(value == null|| value.isEmpty)
                    return "Vui lòng nhập tên xe";
                  else if(value.length <6)
                    return "Bạn phải nhập tên xe";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.accessible_forward_outlined),
                    hintText: "Nhập tên xe",
                    labelText: "Nhập tên xe"
                ),
              ),
              TextFormField(
                controller: txtEmail,
                validator: (value){
                  if(value == null|| value.isEmpty)
                    return "Vui lòng nhập màu xe";
                  else if(value.length <6)
                    return "Bạn phải nhập màu xe";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.agriculture_sharp),
                    hintText: "Nhập màu xe",
                    labelText: "Màu xe"
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(onPressed: ()
                {
                  if(fkey.currentState!.validate())
                  {
                    var tenDangNhap = txtTenDangNhap.text;
                    var matKhau = txtMatKhau.text;
                    var email = txtEmail.text;
                    var data_result = User.fetchData(tenDangNhap,matKhau,email);
                    print(data_result.runtimeType.toString());
                    var alert = AlertDialog(
                      content: Text(data_result.runtimeType.toString()),
                    );
                    showDialog(context: context, builder: (context){
                      return alert;
                    });
                  }else{
                  }
                }, child: Text("Thêm")),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
class User{
  final int id;
  final int usename;
  final String pass;
  final String email;
  User({required this.id,required this.usename,required this.pass,required this.email});
  static Future<String> fetchData(var usename,var pass,var email) async
  {
    String url = "https://thongtincongdong.site";
    final resutl = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usename,
        'pass': pass,
        'email': email,
      }),
    );
    print(resutl.body);
    return resutl.body;
  }

}