import 'package:faps_demonstrator_customer_app/model/gift.dart';
import 'package:flutter/material.dart';

class NewOrderScreen extends StatefulWidget {
  static const String routeName = "/new_order";

  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  List<Gift> selectedGifts = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          }
          debugPrint("You selected on menu $index");
        },
      ),
    );
  }

  GridView getGridView( BuildContext context) {
    List<Gift> all_types = Gift.getAllPossibleGifts();
    List<Widget> gridCells = [];
    all_types.forEach((element) => gridCells.add(getStructuredGridCell(element,context)));

    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: gridCells,
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
    String msg = "You selected on item " + gift.name;
    if(selectedGifts.length >= 4){
      msg = 'You can only select 4 items!';
    }
    if(selectedGifts.length <= 3){
      setState(() => selectedGifts.add(new Gift(gift.id, gift.name, gift.image, gift.weight, gift.description, gift.totalReviews)));
    }
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);

  }


}