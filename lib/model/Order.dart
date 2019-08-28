import 'package:faps_demonstrator_customer_app/model/gift.dart';
import 'package:flutter/material.dart';
import 'OrderStatus.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';

class OrderModel {
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  DateTime lastStatusUpdate = DateTime.now();
  StatusEnum currentOrderStatus = StatusEnum.CREATED;
  String OrderID = "XXXX_XXXX";
  String OrderOwner = "Unknown Customer";
  List<OrderStatus> statusHistory = [];
  List<Gift> gifts = [];
  var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');

  OrderModel(
      this.created,
        this.updated,
        this.lastStatusUpdate,
        this.currentOrderStatus,
        this.OrderID,
        this.OrderOwner,
        this.statusHistory,
        this.gifts);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return new OrderModel(
        json['created'] as DateTime,
        json['updated'] as DateTime,
        json['lastStatusUpdate'] as DateTime,
        json['currentOrderStatus'] as StatusEnum,
        json['OrderID'] as String,
        json['OrderOwner'] as String,
        json['statusHistory'] as List<OrderStatus>,
        json['gifts'] as List<Gift>);
  }

  static List<OrderModel> getAllfromJson(String jsonTxt) {
    List<dynamic> list = json.decode(jsonTxt);
    return list.map((val) => OrderModel.fromJson(val)).toList();
  }

  Map<String, dynamic> toJson() => {
    'created': created,
    'updated': updated,
    'lastStatusUpdate': lastStatusUpdate,
    'currentOrderStatus': currentOrderStatus,
    'OrderID': OrderID,
    'OrderOwner': OrderOwner,
    'statusHistory': statusHistory,
    'gifts': gifts
  };

  int get totalQuantity => gifts.length;

  bool isFull() => this.gifts.length > 4 ? true : false;

  Widget getImage() {
    return new Icon(
      Icons.music_note,
      color: Colors.black,
    );
  }

  Widget getText() {
    return Text(
      this.OrderID,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
    );
  }

  Widget getSubText() {
    return Text(
      formatter.format(this.created) + "\n" + this.OrderOwner,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }

  Widget getCreatedText() {
    return Text(
      formatter.format(this.created),
      style: TextStyle(fontSize: 14, color: getStatusColor()),
    );
  }

  Widget getItemCounts() {
    return Text(
      this.gifts.length.toString() + "\nItem(s)",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
    );
  }

  Widget getStatus() {
    return Text(
      this.currentOrderStatus.toString().split('.').last.toLowerCase(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: getStatusColor()),
    );
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
    return (((this.currentOrderStatus.index + 1) / (StatusEnum.values.length)));
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

  void updateStatus(StatusEnum newStatus) {
    this.currentOrderStatus = newStatus;
    this.statusHistory.add(new OrderStatus(newStatus, DateTime.now()));
  }

  List<Step> getAllStepWidgets() {
    return [
      getCreatedStatusStepView(), // CREATED
      getAcceptedStatusStepView(), // ACCEPTED
      getScheduledStatusStepView(), // SCHEDULED
      getInProcessingStatusStepView(), // IN_PROCESSING
      getOnDeliveryStatusStepView(), // ON_DELIVERY
      getDELIVEREDStatusStepView(), // DELIVERED
      getFINISHEDStatusStepView() // FINISHED
    ];
  }

  Step getCreatedStatusStepView() {
    if (this.statusHistory.length > 0) {
      OrderStatus current_step = this.statusHistory[0];
      return Step(
        // Title of the Step
          title: Text("CREATED - OrderID: " + this.OrderID + " created."),
          subtitle: Text(
              formatter.format(current_step.updated) + " - " + this.OrderOwner),
          // Content, it can be any widget here. Using basic Text for this example
          content: gifts.length > 0
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("OrderID: " + this.OrderID),
              Text("Owner: " + this.OrderOwner != null &&
                  !this.OrderOwner.isEmpty
                  ? this.OrderOwner
                  : "Unknown"),
              Text("Status Update: " +
                  formatter.format(current_step.updated)),
              Text("Product configuration:"),
              getGiftsImages(),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("No gifts have been selected!"),
            ],
          ),
          isActive: true,
          state: gifts.length > 0 ? StepState.complete : StepState.disabled);
    } else {
      return Step(
        // Title of the Step
          title: Text("Error"),
          subtitle: Text("Status history cannot be retrieved."),
          // Content, it can be any widget here. Using basic Text for this example
          content: Text("Status history cannot be retrieved. "
              "Please report this error to jupiter Bakakeu."),
          isActive: true);
    }
  }

  Step getAcceptedStatusStepView() {
    return Step(
      // Title of the Step
        title: Text("ACCEPTED"),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  Step getScheduledStatusStepView() {
    return Step(
      // Title of the Step
        title: Text("SCHEDULED"),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  Step getInProcessingStatusStepView() {
    return Step(
      // Title of the Step
        title: Text("IN PROCESSING"),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  Step getOnDeliveryStatusStepView() {
    return Step(
      // Title of the Step
        title: Text("ON DELIVERY"),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  Step getDELIVEREDStatusStepView() {
    return Step(
      // Title of the Step
        title: Text("DELIVERED"),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  Step getFINISHEDStatusStepView() {
    return Step(
      // Title of the Step
        title: Text("DELIVERED"),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  Step getNotConfiguredStepView() {
    return Step(
      // Title of the Step
        title: Text("Not implemented."),
        subtitle: Text("Current step visualization is not implemented."),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text("Current step visualization is not implemented."
            "Please report this error to jupiter Bakakeu."),
        isActive: true,
        state: StepState.editing);
  }

  getGiftsImages() {
    List<Expanded> imgs = [];
    for (final x in this.gifts) {
      imgs.add(Expanded(
          child: Card(
            elevation: 2.0,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage(x.image), fit: BoxFit.scaleDown),
              ),
              Text(x.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
          )));
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgs,
    );
  }
}
