class TempReservations {
  int? id, userId, type;
  String? TripType;
  DateTime? date;
  TempReservations(
      {this.id,
      required this.userId,
      required this.TripType,
      required this.date,
      required this.type});
}
