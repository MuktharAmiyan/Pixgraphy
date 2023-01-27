import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider =
    StreamProvider.autoDispose<ConnectivityResult>((ref) {
  final controller = StreamController<ConnectivityResult>();
  final sub =
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    controller.sink.add(result);
  });
  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });
  return controller.stream;
});
