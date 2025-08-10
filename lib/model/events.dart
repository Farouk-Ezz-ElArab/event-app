class Event {
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;

  Event({
    this.id = '',
    required this.dateTime,
    required this.description,
    required this.title,
    required this.eventName,
    required this.image,
    this.isFavorite = false,
    required this.time,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'time': time,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'eventName': eventName,
      'isFavorite': isFavorite,
    };
  }

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        image: data['image'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        description: data['description'],
        eventName: data['eventName'],
        time: data['time'],
        title: data['title'],
        id: data['id'],
        isFavorite: data['isFavorite'],
      );
}
