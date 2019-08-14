import 'package:flutter/material.dart';

class MyGridView {
  Card getStructuredGridCell(name, image) {
    return Card(
        elevation: 1.5,
        child: Padding(
        padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center ,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Image(image: AssetImage(image),fit: BoxFit.scaleDown),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child:
                  Text(
                      name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.0
                      )
                  )
              )
            ]),
          )
        );
  }

  GridView build() {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        getStructuredGridCell("FAU Gummy Bears", "assets/images/Haribo.jpg"),
        getStructuredGridCell("FAU M&Ms", "assets/images/M&Ms.jpg"),
        getStructuredGridCell("FAU Rubber Eraser", "assets/images/RadierGummi.jpg"),
        getStructuredGridCell("FAU Biscuits", "assets/images/leibniz_keks.jpg"),
        getStructuredGridCell("FAU USB-Sticks", "assets/images/USB.jpg"),
        getStructuredGridCell("FAU Mentos Bonbons", "assets/images/Mentos_Neu.jpeg"),
        getStructuredGridCell("Post-It", "assets/images/Post_it.jpg"),
        getStructuredGridCell("FAU Surprise", "assets/images/FAU_blue.jpg"),
      ],
    );
  }
}