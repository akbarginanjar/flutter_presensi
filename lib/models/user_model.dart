class User {
  String? message;
  String? token;
  Data? data;

  User({this.message, this.token, this.data});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? type;
  int? isLogin;
  String? idDepartemen;
  String? idJabatan;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.isLogin,
      this.idDepartemen,
      this.idJabatan,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    isLogin = json['is_login'];
    idDepartemen = json['id_departemen'];
    idJabatan = json['id_jabatan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['type'] = type;
    data['is_login'] = isLogin;
    data['id_departemen'] = idDepartemen;
    data['id_jabatan'] = idJabatan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
