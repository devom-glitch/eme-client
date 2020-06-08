import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_up/models/amenity.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection refrence
  final CollectionReference emeAmenities =
      Firestore.instance.collection('Our Amenities');
  final CollectionReference emeUser =
      Firestore.instance.collection('Users Profile');
  Future updateUserData(String displayName, String photoUrl, String phoneNumber,
      String email) async {
    return await emeUser.document(uid).setData({
      'name': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'email': email
    });
  }

  List<Amenity> _amenityAmenityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Amenity(
          imgPath: doc.data['ImageUrl'] ?? '0',
          amenityName: doc.data['Name'] ?? '0');
    }).toList();
  }

  // get Amenities stream from firebase
  Stream<List<Amenity>> get emeAmenitiesList {
    return emeAmenities.snapshots().map(_amenityAmenityListFromSnapshot);
  }
}