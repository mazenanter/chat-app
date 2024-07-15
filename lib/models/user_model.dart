class UserModel {
  final String name;
  final String email;
  final String uId;
  final String image;
  final String phone;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.uId,
    required this.phone,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      image: json['image'],
      uId: json['uId'],
      phone: json['phone'],
    );
  }
  Map<String,dynamic>toMap()
  {
    return
      {
        'name':name,
        'email':email,
        'image':image,
        'uId':uId,
        'phone':phone,
      };
  }
}
