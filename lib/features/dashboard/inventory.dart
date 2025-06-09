class Inventory {
  Inventory({
    required this.event,
    required this.description,
    required this.time,
    required this.status,
  });
  final String event;
  final String description;
  final String time;
  final String status;

  static const itemCount = 4;
}
