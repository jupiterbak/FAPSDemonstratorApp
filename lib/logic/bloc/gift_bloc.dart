import 'dart:async';


import 'package:faps_demonstrator_customer_app/model/gift.dart';

import 'package:faps_demonstrator_customer_app/logic/view_model/gift_view_model.dart';


class GiftBloc {
  final GiftViewModel giftViewModel = GiftViewModel();
  final giftController = StreamController<List<Gift>>();
  Stream<List<Gift>> get productItems => giftController.stream;

  GiftBloc() {
    giftController.add(giftViewModel.getAllPossibleGifts());
  }
}