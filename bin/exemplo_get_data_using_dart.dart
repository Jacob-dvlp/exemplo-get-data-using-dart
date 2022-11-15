import 'package:http/http.dart' as http;

import 'post_model.dart';

void main(List<String> arguments) async {
  await Repository().getPost();
}

class Repository {
  final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
  List<PostModel> data = [];
  Future getPost() async {
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final model = responseApiFromJson(response.body);
      data = model;
      print(data);
    } else {
      print(response.statusCode);
    }
  }
}
