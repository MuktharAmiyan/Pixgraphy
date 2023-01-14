class SendNotification {
  final String title;
  final String body;
  final String token;
  SendNotification({
    required this.title,
    required this.body,
    required this.token,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendNotification &&
        other.title == title &&
        other.body == body &&
        other.token == token;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ token.hashCode;
}
