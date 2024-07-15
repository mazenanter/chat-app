class ChatModel {
  String? text;
  String? date;
  String? senderId;
  String? recieverId;
  String? msgImage;

  ChatModel(
      {required this.text,
      required this.date,
      required this.senderId,
      required this.recieverId,
      this.msgImage});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        text: json['text'],
        date: json['date'],
        senderId: json['senderId'],
        recieverId: json['recieverId'],
        msgImage: json['msgImage']);
  }
  Map<String ,dynamic>toMap()
  {
    return
      {
        'text':text,
        'date':date,
        'msgImage':msgImage,
        'senderId':senderId,
        'recieverId':recieverId,
      };
  }
}
