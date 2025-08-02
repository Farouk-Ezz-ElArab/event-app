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
}
