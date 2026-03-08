class Event {
  /// collection names
  static const String usersCollectionName = 'users';
  static const String eventsCollectionName = 'events';

  String id;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  String eventTime;
  bool isFavorite;

  Event({
    this.id = '',
    required this.eventTitle,
    required this.eventName,
    required this.eventDescription,
    required this.eventImage,
    required this.eventDate,
    required this.eventTime,
    this.isFavorite = false,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      eventTitle: json['eventTitle'],
      eventName: json['eventName'],
      eventDescription: json['eventDescription'],
      eventImage: json['eventImage'],
      eventDate: DateTime.fromMillisecondsSinceEpoch(json['eventDate']),
      eventTime: json['eventTime'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
  Map<String, dynamic> eventToJson(Event event) {
    return {
      'id': event.id,
      'eventTitle': event.eventTitle,
      'eventName': event.eventName,
      'eventDescription': event.eventDescription,
      'eventImage': event.eventImage,
      'eventDate': event.eventDate.millisecondsSinceEpoch,
      'eventTime': event.eventTime,
      'isFavorite': event.isFavorite,
    };
  }

}