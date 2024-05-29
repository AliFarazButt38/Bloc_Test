import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/PostModel.dart';

class PostRepository{
 Future <List<Post>> fetchPost() async{
   try{
  final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
  print("status code ${response.statusCode}");
  if(response.statusCode==200){
    print("response posts: ${response.body}");
    final body =  json.decode(response.body) as List;
    return body.map((e) {
      return Post(postId: e['postId'] , id: e['id'], name: e['name'] as String, email: e['email'] as String, body: e['body'] as String);
    }).toList();
  }

   }on SocketException{
     throw Exception("socket error");
   }on TimeoutException{
     throw Exception("time error");
   }
   throw Exception("error");

 }

 }