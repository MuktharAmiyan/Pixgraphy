import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String format() {
    final differance = DateTime.now().difference(this);
    if (differance.inHours >= 24) {
      return DateFormat.yMMMMd().format(this).toString();
    } else if (differance.inHours <= 24 && differance.inHours != 0) {
      return '${differance.inHours} hours ago';
    } else if (differance.inMinutes != 0) {
      return '${differance.inMinutes} minutes ago';
    }
    return '${differance.inSeconds} seconds ago';
    // }
  }
}
