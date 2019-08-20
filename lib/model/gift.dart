class Gift {
  String name;
  int id;
  String image;
  double weight;
  String description;
  int totalReviews;

  Gift(
        this.id,
        this.name,
        this.image,
        this.weight,
        this.description,
        this.totalReviews,
        );

  static getAllPossibleGifts() => <Gift>[
    Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.2, "",0),
    Gift(0, "FAU M&Ms", "assets/images/M&Ms.jpg", 0.2, "",0),
    Gift(0, "FAU Rubber Eraser", "assets/images/RadierGummi.jpg", 0.2, "",0),
    Gift(0, "FAU Biscuits", "assets/images/leibniz_keks.jpg", 0.2, "",0),
    Gift(0, "FAU USB-Sticks", "assets/images/USB.jpg", 0.2, "",0),
    Gift(0, "FAU Mentos Bonbons", "assets/images/Mentos_Neu.jpeg", 0.2, "",0),
    Gift(0, "Post-It", "assets/images/Post_it.jpg", 0.2, "",0),
    Gift(0, "FAU Surprise", "assets/images/FAU_blue.jpg", 0.2, "",0)
  ];
}
