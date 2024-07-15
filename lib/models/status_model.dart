class StatusModel {
  final String title;
  final String name;
  final String image;
  final String date;
  final String? statusImage;
  StatusModel(
      {required this.name,
      required this.image,
      required this.title,
      required this.date,
      this.statusImage});
  factory StatusModel.fromJson(json) {
    return StatusModel(
        image: json['image'],
        title: json['title'],
        name: json['name'],
        date: json['date'],
        statusImage: json['statusImage']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'name': name,
      'date': date,
      'statusImage': statusImage,
    };
  }
}
