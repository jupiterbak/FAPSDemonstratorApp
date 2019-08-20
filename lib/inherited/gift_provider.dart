import 'package:faps_demonstrator_customer_app/logic/bloc/gift_bloc.dart';
import 'package:flutter/material.dart';

class GiftProvider extends InheritedWidget {
  final GiftBloc productBloc;
  final Widget child;

  GiftProvider({this.productBloc, this.child}) : super(child: child);

  static GiftProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(GiftProvider);

  @override
  bool updateShouldNotify(GiftProvider oldWidget) =>
      productBloc != oldWidget.productBloc;
}
