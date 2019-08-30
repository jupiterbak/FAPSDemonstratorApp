class OrderStatus{
  StatusEnum status;
  DateTime updated;

  OrderStatus(this.status, this.updated);

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    DateTime updated = DateTime.parse(json['updated']);
    return OrderStatus(
        json['status'] as StatusEnum,
        updated
    );
  }

  static StatusEnum parseStatusEnum(String status){
    return StatusEnum.values.firstWhere((e) => e.toString() == status);
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