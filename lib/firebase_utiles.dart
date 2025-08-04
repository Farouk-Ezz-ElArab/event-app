import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/model/events.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) {
            return Event.fromFireStore(snapshot.data()!);
          },
          toFirestore: (event, options) {
            return event.toFireStore();
          },
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> eventsCollection = getEventCollection();
    DocumentReference<Event> documentReference = eventsCollection.doc();
    event.id = documentReference.id;
    return documentReference.set(event);
  }

// Add these methods to your FirebaseUtils class

  static Future<void> updateEventInFireStore(Event event) async {
    CollectionReference<Event> eventsCollection = getEventCollection();
    DocumentReference<Event> eventDoc = eventsCollection.doc(event.id);

    return eventDoc.set(event);
  }

  static Future<void> deleteEventFromFireStore(String eventId) async {
    CollectionReference<Event> eventsCollection = getEventCollection();
    DocumentReference<Event> eventDoc = eventsCollection.doc(eventId);

    return eventDoc.delete();
  }
}
