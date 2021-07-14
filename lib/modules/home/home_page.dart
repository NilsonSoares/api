import 'dart:convert';

import 'package:api/shared/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> posts = List.empty();

  Future <void> getPosts() async {

  final baseURL = "http://jsonplaceholder.typicode.com";
  var url = Uri.parse(
    '$baseURL/posts',
  );
  final response = await http.get(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as List;
    posts = json.map((e) => Post.fromJson(e)).toList();
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index){
        return Card(
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                posts[index].id.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade200,
              ),
            ),
            title: Text(
              posts[index].title ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{         
           await getPosts();
           setState(() {             
           });
        },
        child: Icon(Icons.download, semanticLabel: "Get Posts",),
      ),
    );
  }
}