import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';

import 'model/event.dart';

class FirebaseUtils {
  ///write data
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.eventsCollection)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.eventToJson(value),
        );

    ///withconverter bet3raf firebase no3 el haga elly ehna ben5azenha
  }

  static Future<void> addEventsToFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventCollection();

    DocumentReference<Event> docRef = collectionRef.doc();

    event.id = docRef.id;

    return docRef.set(event);
  }
}
