class SendLikeNotificationRequest {
  final String uid;
  final String postId;
  SendLikeNotificationRequest({
    required this.uid,
    required this.postId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendLikeNotificationRequest &&
        other.uid == uid &&
        other.postId == postId;
  }

  @override
  int get hashCode => uid.hashCode ^ postId.hashCode;
}
