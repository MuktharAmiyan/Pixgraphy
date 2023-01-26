import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/report/model/report.dart';

final reportrepositoryProvider = Provider<ReportRepository>((ref) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  return ReportRepository(firebaseFirestore);
});

class ReportRepository {
  final FirebaseFirestore firebaseFirestore;
  ReportRepository(this.firebaseFirestore);
  Future<bool> report({
    required Report report,
  }) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionName.report)
          .doc(report.reportId)
          .set(report.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
