import 'package:faps_demonstrator_customer_app/model/gift.dart';
import 'package:flutter/material.dart';
import 'OrderStatus.dart';
import 'package:intl/intl.dart';

class OrderModel {
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  DateTime lastStatusUpdate;
  StatusEnum currentOrderStatus;
  String OrderID = "XXXX_XXXX";
  String OrderOwner = "Unknown Customer";
  List<OrderStatus> statusHistory =  [];
  List<Gift> gifts = [];
  var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');

  OrderModel(OrderID,OrderOwner,List<Gift> gifts){
    this.updated = DateTime.now();
    OrderStatus cur = new OrderStatus(StatusEnum.CREATED, DateTime.now());
    this.statusHistory.add(cur);
    this.OrderID = OrderID;
    this.OrderOwner = OrderOwner;
    this.gifts = gifts;
    this.currentOrderStatus = StatusEnum.CREATED;
  }

  int get totalQuantity => gifts.length;
  bool isFull() => this.gifts.length > 4? true:false;

  Widget getImage() {
    return new Icon(Icons.music_note, color: Colors.black,);
  }
  Widget getText() {
    return Text(this.OrderID  , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.black54),);
  }
  Widget getSubText() {
    return Text(formatter.format(this.created) + "\n" + this.OrderOwner , style: TextStyle(fontSize: 12, color: Colors.black54),);
  }
  Widget getCreatedText() {
    return Text( formatter.format(this.created) , style: TextStyle(fontSize: 14, color: getStatusColor()),);
  }
  Widget getItemCounts() {
    return Text( this.gifts.length.toString() + "\nItem(s)" , textAlign:TextAlign.center ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),);
  }
  Widget getStatus() {
    return Text(this.currentOrderStatus.toString().split('.').last.toLowerCase() , overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: getStatusColor()),);
  }

  Icon getStatusIcon() {

    switch (this.currentOrderStatus) {
      case StatusEnum.CREATED:
        return Icon(Icons.check_circle_outline, color: getStatusColor());
      case StatusEnum.SCHEDULED:
        return Icon(Icons.schedule, color: getStatusColor());
      case StatusEnum.IN_PROCESSING:
        return Icon(Icons.build, color: getStatusColor());
      case StatusEnum.ON_DELIVERY:
        return Icon(Icons.airport_shuttle, color: getStatusColor());
      case StatusEnum.DELIVERED:
        return Icon(Icons.check_circle, color: getStatusColor());
      case StatusEnum.FINISHED:
        return Icon(Icons.bookmark, color: getStatusColor());
      default:
        return Icon(Icons.access_time, color: getStatusColor());
    }
  }

  double getStatusIndicator() {
    return (((this.currentOrderStatus.index + 1)/ (StatusEnum.values.length)));
  }

  String getStatusString() {
    return this.currentOrderStatus.toString().split('.').last.toLowerCase();
  }

  Color getStatusColor() {
    if (this.currentOrderStatus.index <= StatusEnum.CREATED.index)
      return Colors.blueGrey;
    else if (this.currentOrderStatus.index <= StatusEnum.SCHEDULED.index)
      return Colors.yellow;
    else if (this.currentOrderStatus.index <= StatusEnum.IN_PROCESSING.index)
      return Colors.orange;
    else if (this.currentOrderStatus.index <= StatusEnum.FINISHED.index)
      return Colors.green;
    else
      return Colors.orange;
  }

  void updateStatus(StatusEnum newStatus){
    this.currentOrderStatus = newStatus;
    this.statusHistory.add(new OrderStatus(newStatus, DateTime.now()));
  }
}