
# Aprendendo a consumir uma API usando dart sem  flutter em 1 minuto.
<p id="e067" class="pw-post-body-paragraph kc kd iu ke b kf kg kh ki kj kk kl km kn ko kp kq kr ks kt ku kv kw kx ky kz in fw" data-selectable-paragraph=""><strong class="ke iv">Adicione nas suas dependências.</strong></p>
<br>
<br>
<br>
<br>
<br>
<span id="bb1b" class="fw lj lk iu li b dm ll lm l ln lo" data-selectable-paragraph="">{
dev_dependencies:
  http:
}</span>
<br>
<br>
<br>
<br>
<br>
<span id="bb1b" class="fw lj lk iu li b dm ll lm l ln lo" data-selectable-paragraph="">class PostModel {
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
}</span>

<br>
<br>
<br>
<br>
<br>
<br>


<span id="bb1b" class="fw lj lk iu li b dm ll lm l ln lo" data-selectable-paragraph="">
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
  
  </span>
