class UserModel {
  final int id;
  String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];
}
