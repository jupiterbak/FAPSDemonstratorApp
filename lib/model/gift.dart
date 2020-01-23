import 'dart:convert';

class Gift {
  String name;
  String name_image_processing = "faps";
  int id;
  String image;
  double weight;
  String description;
  int totalReviews;

  Gift(
    this.id,
    this.name,
    this.name_image_processing,
    this.image,
    this.weight,
    this.description,
    this.totalReviews,
  );

  static getAllPossibleGifts() => <Gift>[
        Gift(0, "FAU Haribo", "haribo", "assets/images/haribo-mini.jpg", 0.2, "", 0),
        Gift(1, "FAU Ritter Sport", "choco","assets/images/ritter-sport-kokos-100g.jpg", 0.2, "", 0),
        Gift(2, "FAU Choco Munze", "choco_munze","assets/images/Muenzen-Schokoladen.jpg", 0.2, "",
            0),
        Gift(3, "FAU Hanuta", "hanuta","assets/images/hanuta-minis.jpg", 0.2, "", 0),
        Gift(7, "FAU Surprise", "faps", "assets/images/FAU_blue.jpg", 0.2, "", 0)
      ];

  static  Gift fromJson(Map<String, dynamic> json) {
    return Gift(
        json['id'] as int,
        json['name'] as String,
        json['name_image_processing'] as String,
        json['image'] as String,
        json['weigth'] as double,
        json['description'] as String,
        json['totalReviews'] as int);
  }

  static  List<Gift> getAllFromJson(List<dynamic> jsonList) {
    return jsonList.map((val) => Gift.fromJson(val)).toList();
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'name_image_processing':name_image_processing,
        'id': id,
        'image': image,
        'weight': weight,
        'description': description,
        'totalReviews': totalReviews
      };
}
