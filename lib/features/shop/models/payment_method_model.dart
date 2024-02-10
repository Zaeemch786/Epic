class PayMentMethodModel {
  String name;
  String image;
  PayMentMethodModel({
    required this.image,
    required this.name,
  });
  static PayMentMethodModel empty() => PayMentMethodModel(image: '', name: '');
}
