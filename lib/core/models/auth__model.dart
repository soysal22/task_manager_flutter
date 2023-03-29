class AuthModel {
  String? name;
  String? email;
  String? password;

  AuthModel({
    this.name,
    required this.email,
    required this.password,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    name = json['title'];
    email = json['note'];
    password = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['title'] = name;
    data['note'] = email;
    data['date'] = password;

    return data;
  }
}
