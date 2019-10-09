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
        Gift(0, "FAU Gummy Bears", "faps", "assets/images/Haribo.jpg", 0.2, "", 0),
        Gift(1, "FAU M&Ms", "faps","assets/images/M&Ms.jpg", 0.2, "", 0),
        Gift(2, "FAU Rubber Eraser", "faps","assets/images/RadierGummi.jpg", 0.2, "",
            0),
        Gift(3, "FAU Biscuits", "faps","assets/images/leibniz_keks.jpg", 0.2, "", 0),
        Gift(4, "FAU USB-Sticks", "faps","assets/images/USB.jpg", 0.2, "", 0),
        Gift(5, "FAU Mentos Bonbons", "faps","assets/images/Mentos_Neu.jpeg", 0.2, "",
            0),
        Gift(6, "Post-It", "faps","assets/images/Post_it.jpg", 0.2, "", 0),
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
