import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';
class MyApp9 extends StatelessWidget {
  const MyApp9({Key? key}) : super(key: key);

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
class MyHomePageState extends State<MyHomePage> {
  late Future<User> dataUser;
  static Future<User> fetchData() async{
    String url = "https://randomuser.me/api/";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = response.body;
      final user = userFromJson(result);
      return user;
    }
    else
    {
      throw Exception("Lỗi lấy dữ liệu: ${response.statusCode}");
    }

  }
  var txtTenDangNhap = TextEditingController(text: "ANY TEXT");
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    dataUser = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        actions: [
          TextButton(onPressed: (){}, child: Text("Save",style: TextStyle(
            color: Colors.yellow
          ),))
        ],
      ),
      body: FutureBuilder(
        future: dataUser,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as User;
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data.results[0].picture.medium,scale: 1),
                    ),
                  ),
                  ListBody(
                    children: [
                      data_Text("Name",data.results[0].name.first),
                      data_Text("Email",data.results[0].email),
                      data_Text("Gender",data.results[0].gender),
                      data_Text("Country",data.results[0].location.city),
                    ],)
                ],
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
  Widget data_Text(String title,String value){
    var data_name =  TextEditingController(text: value);
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: data_name,
        decoration: InputDecoration(
          labelText: title,
        ),
      ),
    );
  }
}


