class OrderStatus{
  StatusEnum status;
  DateTime updated;

  OrderStatus(this.status, this.updated);

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
        json['status'] as StatusEnum,
        json['updated'] as DateTime
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'updated': updated,
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