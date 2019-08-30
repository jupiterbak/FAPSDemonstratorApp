import 'dart:async';
import 'dart:convert';
import 'package:faps_demonstrator_customer_app/model/OrderStatus.dart';
import 'package:faps_demonstrator_customer_app/model/gift.dart';
import 'package:faps_demonstrator_customer_app/views/OrderDetailsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:faps_demonstrator_customer_app/model/Order.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import 'package:faps_demonstrator_customer_app/views/NewOrderScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';
  static const String backendServerAddress = "kain.faps.uni-erlangen.de";
  static const int backendServerPort = 8080;

  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<OrderModel> _orders;
  Timer _timer;
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _orders = List<OrderModel>();
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

    const fiveSeconds = const Duration(seconds: 5);
    _timer = Timer.periodic(
      fiveSeconds,
      (Timer t) => _refresh(),
    );
  }

  Future _refresh() {
    if (Navigator.of(context).canPop()) return null;
    return _fetchData().then((serversResult) {
      setState(() => _orders = serversResult);
    });
  }

  Future<List<OrderModel>> _fetchData() async {
    final response = await http.get("http://" + HomeScreen.backendServerAddress
        + ":" + HomeScreen.backendServerPort.toString() +"/orders");
    if (response.statusCode == 200) {
      return OrderModel.getAllfromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  List<OrderModel> refreshDataOrders(String body) {
    return [
      new OrderModel(
          DateTime.now(),
          DateTime.now(),
          DateTime.now(),
          StatusEnum.CREATED,
          randomAlphaNumeric(10),
          "jupiter.bakakeu@faps.de", [], [
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
      ]),
      new OrderModel(
          DateTime.now(),
          DateTime.now(),
          DateTime.now(),
          StatusEnum.CREATED,
          randomAlphaNumeric(10),
          "jupiter.bakakeu@faps.de", [], [
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
      ]),
      new OrderModel(
          DateTime.now(),
          DateTime.now(),
          DateTime.now(),
          StatusEnum.CREATED,
          randomAlphaNumeric(10),
          "jupiter.bakakeu@faps.de", [], [
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
      ]),
      new OrderModel(
          DateTime.now(),
          DateTime.now(),
          DateTime.now(),
          StatusEnum.CREATED,
          randomAlphaNumeric(10),
          "jupiter.bakakeu@faps.de", [], [
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
        Gift(0, "FAU Gummy Bears", "assets/images/Haribo.jpg", 0.4, "", 0),
      ]),
    ];
  }

  @override
  void dispose() {
    this._orders.clear();
    this._timer.cancel();
    super.dispose();
  }

  void openOrderDetailsView(OrderModel order) {
    Navigator.of(context)
        .pushNamed(OrderDetailsScreen.routeName, arguments: order);
  }

  void goToCreateNewOrderView() {
    Navigator.of(context).pushNamed(NewOrderScreen.routeName);
  }

  ListTile makeListTile(OrderModel order) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: order.getStatusIcon(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            order.getText(),
            order.getSubText(),
          ],
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: LinearProgressIndicator(
                  backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                  value: order.getStatusIndicator(),
                  valueColor: AlwaysStoppedAnimation(order.getStatusColor()),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: order.getStatus(),
              ),
            )
          ],
        ),
        trailing: Column(
          children: <Widget>[order.getItemCounts()],
        ),
        onTap: () {
          openOrderDetailsView(order);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: SafeArea(
              child: Container(
                  child: (_orders.isNotEmpty)
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _orders.length,
                          itemBuilder: (BuildContext context, int index) {
                            return makeCard(_orders[index]);
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )))),
      drawer: getNavDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCreateNewOrderView,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Card makeCard(OrderModel order) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white10),
        child: makeListTile(order),
      ),
    );
  }

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(
        child: new Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Image.asset(
          'assets/images/FAPS_Logo_scaled.PNG',
        )
      ],
    )));

    var aboutChild = AboutListTile(
        child: Text(
          "About",
          style: TextStyle(color: Colors.black54),
        ),
        applicationName: "FAPS Demonstrator Customer Application",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(
          s,
          style: TextStyle(color: Colors.black54),
        ),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushReplacementNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.home, "Home", HomeScreen.routeName),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }
}
