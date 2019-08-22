class OrderStatus{
  StatusEnum status;
  DateTime updated;

  OrderStatus(this.status, this.updated);
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