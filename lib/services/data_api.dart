import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffice_app/home/models/coffee.dart';

class DataApi {
  final CollectionReference _coffeeCollection =
      Firestore.instance.collection('coffee');
  List<Coffee> _getCoffeeListFromSnapShot(QuerySnapshot snapshot) {
    print(snapshot.documents.length);
    return snapshot.documents.map((doc) {
      return Coffee.fromJson(doc.data);
    }).toList();
  }

  Future<void> updateCoffee(Coffee coffee, String uid) {
    return _coffeeCollection.document(uid).setData(coffee.toJson());
  }

  Stream<List<Coffee>> get coffeeList {
    return _coffeeCollection.snapshots().map(_getCoffeeListFromSnapShot);
  }

  Stream<Coffee> getUserCoffee(String uid) {
    return _coffeeCollection.document(uid).snapshots().map((snapshot) {
      return Coffee.fromJson(snapshot.data);
    });
  }
}
