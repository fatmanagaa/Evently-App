
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
//todo:data
  List<Event> eventsList = [];
  void getEventsFromFireStore() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection().get();

    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
notifyListeners();
  }
}