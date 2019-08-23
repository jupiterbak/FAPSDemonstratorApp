import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyGridView {

  void _onTileClicked(String item_name, context){
    debugPrint("You selected on item $item_name");
//    Scaffold.of(context).showSnackBar(
//        new SnackBar(
//            content: new Text("You selected on item $item_name")
//        )
//    );
  }

  Card getStructuredGridCell(name, image, context) {
    return Card(
        elevation: 1.5,
        child: new InkResponse(
          enableFeedback: true,
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
          ),
          onTap: () => _onTileClicked(name, context),
        )
    );
  }

  GridView build( BuildContext context) {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        getStructuredGridCell("FAU Gummy Bears", "assets/images/Haribo.jpg", context),
        getStructuredGridCell("FAU M&Ms", "assets/images/M&Ms.jpg", context),
        getStructuredGridCell("FAU Rubber Eraser", "assets/images/RadierGummi.jpg", context),
        getStructuredGridCell("FAU Biscuits", "assets/images/leibniz_keks.jpg", context),
        getStructuredGridCell("FAU USB-Sticks", "assets/images/USB.jpg", context),
        getStructuredGridCell("FAU Mentos Bonbons", "assets/images/Mentos_Neu.jpeg", context),
        getStructuredGridCell("Post-It", "assets/images/Post_it.jpg", context),
        getStructuredGridCell("FAU Surprise", "assets/images/FAU_blue.jpg", context),
      ],
    );
  }
}