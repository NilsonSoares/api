import 'dart:convert';

import 'package:http/http.dart' as http;


void getPosts() async {
  var baseUrl = Uri.parse("https://jsonplaceholder.typicode.com");
  var url = Uri.parse('$baseUrl/users');
  final response = await http.get(url);
  //print(response.body);
  print(jsonDecode(response.body)[0]['name']);
}

void main() {
  getPosts();
}
