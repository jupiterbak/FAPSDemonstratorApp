import 'package:faps_demonstrator_customer_app/model/gift.dart';

class GiftViewModel {

  List<Gift> giftsItems;

  GiftViewModel({this.giftsItems});
  getAllPossibleGifts() => <Gift>[
    Gift(0, "FAU Gummy Bears", "faps","assets/images/Haribo.jpg", 0.2, "",0),
    Gift(0, "FAU M&Ms", "faps","assets/images/M&Ms..jpg", 0.2, "",0),
    Gift(0, "FAU Rubber Eraser", "faps","assets/images/RadierGummi..jpg", 0.2, "",0),
    Gift(0, "FAU Biscuits", "faps","assets/images/leibniz_keks..jpg", 0.2, "",0),
    Gift(0, "FAU USB-Sticks", "faps","assets/images/USB..jpg", 0.2, "",0),
    Gift(0, "FAU Mentos Bonbons", "faps","assets/images/Mentos_Neu.jpeg", 0.2, "",0),
    Gift(0, "Post-It", "faps","assets/images/Post_it..jpg", 0.2, "",0),
    Gift(0, "FAU Surprise", "faps","assets/images/FAU_blue..jpg", 0.2, "",0)
  ];
}