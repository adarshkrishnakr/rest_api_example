import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ApiData extends StatefulWidget {
  const ApiData({super.key});

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api",style: TextStyle(color: Colors.green),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          final user = users[index];
          final name = user['name']['first'];
          final email = user['email'];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text('${index+1}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)),
          title: Text(name),
          subtitle: Text(email),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: fetchUsers),
    );
  }
  void fetchUsers()async{
    
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    
    
  }
}