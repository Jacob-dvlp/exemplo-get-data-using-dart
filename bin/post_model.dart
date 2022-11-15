import 'dart:convert';

List<PostModel> responseApiFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromeJson(x)));

class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory PostModel.fromeJson(Map<String, dynamic> json) => PostModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);
}
