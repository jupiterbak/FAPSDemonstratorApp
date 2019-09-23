class OrderStatus{
  StatusEnum status;
  DateTime updated;

  OrderStatus(this.status, this.updated);

  static fromJson(Map<String, dynamic> json) {
    DateTime updated = DateTime.parse(json['updated']);
    return OrderStatus(
        parseStatusEnum(json['status']),
        updated
    );
  }

  static List<OrderStatus> allFromJson(List<dynamic> jsonList) {
    List<OrderStatus> rslt = [];
    for (final val in jsonList) {
      rslt.add(OrderStatus.fromJson(val));
    }
    return rslt;
  }

  static StatusEnum parseStatusEnum(String status){
    List<StatusEnum> values = StatusEnum.values;
    for (final e in values) {
      if (e.toString().toLowerCase() == ( "StatusEnum." + status).toLowerCase()){
        return e;
      }
    }
    return null;
  }
  Map<String, dynamic> toJson() =>
      {
        'status': status.toString().replaceAll("StatusEnum.", ""),
        'updated': updated.toString(),
      };
}

enum StatusEnum {
  // the enum values
  CREATED,
  ACCEPTED,
  SCHEDULED,
  IN_PROCESSING,
  ON_DELIVERY,
  DELIVERED,
  FINISHED
}