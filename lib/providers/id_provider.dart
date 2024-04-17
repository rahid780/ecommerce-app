// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  /* late Future<String> documentId; */

  static String _customerId = '';

  String get getData {
    return _customerId;
  }

  setCustomerId(User user) async {
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString('customerid', user.uid)
        .whenComplete(() => _customerId = user.uid);
    print(user.uid);
    notifyListeners();
  }

  clearCustomerId() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('customerid', '').whenComplete(() => _customerId = '');
    notifyListeners();
  }

  Future<String> getDocumentId() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString('customerid') ?? '';
    });
  }

  getDocId() async {
    await getDocumentId().then((value) => _customerId = value);
    notifyListeners();
  }
}
