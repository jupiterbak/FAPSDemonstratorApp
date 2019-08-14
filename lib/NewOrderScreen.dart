import 'package:flutter/material.dart';
import 'ProductGridView.dart';

class NewOrderScreen extends StatelessWidget {
  static const String routeName = "/new_order";
  final MyGridView myGridView = MyGridView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure a new order"),
      ),
      body: myGridView.build(),
    );
  }
}