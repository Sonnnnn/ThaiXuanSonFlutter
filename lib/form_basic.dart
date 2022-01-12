import 'package:flutter/material.dart';

class MyApp5 extends StatelessWidget {
  const MyApp5({Key? key}) : super(key: key);

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
  var txtTenDangNhap = TextEditingController();
  var txtMatKhau = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đâng nhập hệ thống"),
      ),
      body: Form(
        key: fkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("Đăng nhập hệ thống",style: TextStyle(fontSize: 35,color: Colors.orange),),
              TextFormField(
                controller: txtTenDangNhap,
                validator: (value){
                  if(value == null|| value.isEmpty)
                    return "Vui lòng nhập tên tài khoản";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    hintText: "Tên đăng nhập",
                    labelText: "Tên đăng nhập"
                ),

              ),
              TextFormField(
                controller: txtMatKhau,
                validator: (value){
                  if(value == null|| value.isEmpty)
                    return "Vui lòng nhập mật khẩu";
                  else if(value.length <6)
                    return "Mật khẩu dài là 6 ký tự";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    hintText: "Mật khẩu",
                    labelText: "Mật khẩu (*)"
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(onPressed: (){
                  if(fkey.currentState!.validate())
                  {
                    var tenDangNhap = txtTenDangNhap.text;
                    var matKhau = txtMatKhau.text;
                    var alert = AlertDialog(
                      content: Text("Tên đăng nhập: ${tenDangNhap}, mật khẩu: ${matKhau}"),
                    );
                    showDialog(context: context, builder: (context){
                      return alert;
                    });
                  }else{
                    print("not pass");
                  }
                }, child: Text("Đăng nhập")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
