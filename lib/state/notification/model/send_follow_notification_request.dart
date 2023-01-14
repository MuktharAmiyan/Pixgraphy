class SendFollowNotificationRequest {
  final String uid;
  final String followUid;

  SendFollowNotificationRequest(this.uid, this.followUid);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendFollowNotificationRequest &&
        other.uid == uid &&
        other.followUid == followUid;
  }

  @override
  int get hashCode => uid.hashCode ^ followUid.hashCode;
}
