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
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
