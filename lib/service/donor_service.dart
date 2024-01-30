import 'package:blood_donation_app/model/donor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String crudref = "donor";
class DonorService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<DonorModel> donorRef;
  Reference main = FirebaseStorage.instance.ref();

  DonorService() {
    donorRef = firestore.collection('donor').withConverter(
      fromFirestore: (snapshot, options) =>
          DonorModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }
}
