class RecivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  RecivedNotification({
    required this.id,
    this.title,
    this.body,
    this.payload,
  });

  @override
  String toString() {
    return 'RecivedNotification(id: $id, title: $title, body: $body, data: $payload)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecivedNotification &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.payload == payload;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ payload.hashCode;
  }
}
