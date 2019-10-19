import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:faps_demonstrator_customer_app/model/Order.dart';
import 'package:faps_demonstrator_customer_app/model/OrderStatus.dart';
import 'package:faps_demonstrator_customer_app/model/gift.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class NewOrderScreen extends StatefulWidget {
  static const String routeName = "/addOrder";


  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  List<Gift> selectedGifts = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String last_json_request = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Configure a new order"),
      ),
      body: getGridView(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            title: Text('Cancel'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            title: Text('Submit'),
          ),

        ],
        onTap: (index){
          if (index == 0){
            Navigator.pop(context);
          }else if (index == 1){
            // Get all the gifts that have been selected

            // Submit Btn
            OrderModel model = new OrderModel(
                DateTime.now(),
                DateTime.now(),
                DateTime.now(),
                StatusEnum.CREATED,
                "",
                "OrderOwner",
                [new OrderStatus(StatusEnum.CREATED, DateTime.now())],
                this.selectedGifts
            );

            postData(model.toJson()).then((resp){
              String msg = "";
              if (resp == 200) {
                msg = "Order posted sucessfully.";
              }else if (resp == -1){
                msg=  'Order has already been submitted!' ;
              }
              else {
                // If that call was not successful, throw an error.
                msg=  'Failed to post the data. Status code: ' + resp.toString() ;
              }

              debugPrint(msg);
              Navigator.pop(context);
            });

          }
          debugPrint("You selected on menu $index");
        },
      ),
    );
  }


  Future<int> postData(Map<String, dynamic> jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(
        Uri.parse("http://" + HomeScreen.backendServerAddress
        + ":" + HomeScreen.backendServerPort.toString() +"/orders"));
    request.headers.set('content-type', 'application/json');
    String msg  = json.encode(jsonMap);
    if(msg.toLowerCase() != this.last_json_request.toLowerCase()){
      request.add(utf8.encode(json.encode(jsonMap)));
      final HttpClientResponse response = await request.close();
      return response.statusCode;
    }else{
      return -1;
    }

    // return refreshDataOrders("");
  }

  Widget getGridView( BuildContext context) {
    List<Gift> all_types = Gift.getAllPossibleGifts();
    List<Widget> gridCells = [];
    all_types.forEach((element) => gridCells.add(getStructuredGridCell(element,context)));

    return
      OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              primary: true,
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              childAspectRatio: 0.85,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              children: gridCells,
            );
          },
      );
  }

  bool isSelected(Gift gift){
    return this.selectedGifts.where((f) => f.name == gift.name).toList().length > 0;
  }

  Card getStructuredGridCell(Gift gift, context) {
    return Card(
        elevation: 8.0,
        borderOnForeground: false,

        child: new InkResponse(
          enableFeedback: true,
          child: Column(

              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isSelected(gift)?
                    Image(image: AssetImage(gift.image),
                        color: Color.fromRGBO( 70, 89, 26, 0.9),
                        colorBlendMode: BlendMode.modulate,
                        fit: BoxFit.scaleDown):
                    Image(image: AssetImage(gift.image),
                        fit: BoxFit.scaleDown),
                ),
                Text(
                    gift.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected(gift)? Color.fromARGB(255, 70, 89, 26):Colors.black54,
                      fontWeight: FontWeight.bold,

                    )
                ),
                ]),
          onTap: () => _onTileClicked(gift, context),
        )
    );
  }

  void _onTileClicked(Gift gift, context){
    String msg = "";
    bool isWarning = false;
    var foundedGifts = this.selectedGifts.where((f) => f.name == gift.name).toList();
    if(foundedGifts.length> 0){
      setState(() => selectedGifts.remove(foundedGifts[0]));
      msg = "Gift \"" + gift.name + "\" has been removed.";
    }else{
      if(selectedGifts.length <= 3){
        setState(() => selectedGifts.add(gift));
        msg = "You selected on item " + gift.name;
      }else{
        isWarning = true;
        msg = 'You can only select 4 items!';
      }
    }
    final snackBar = SnackBar(
      backgroundColor: isWarning? Colors.red.withOpacity(0.8): Colors.black.withOpacity(0.5),
      content: Text(msg,),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);

  }


}