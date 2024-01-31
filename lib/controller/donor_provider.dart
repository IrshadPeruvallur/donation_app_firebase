import 'package:blood_donation_app/model/donor_model.dart';
import 'package:blood_donation_app/service/donor_service.dart';
import 'package:flutter/foundation.dart';

class DonorProvider extends ChangeNotifier {
  DonorService donorService = DonorService();
  getData() {
    return donorService.donorRef.snapshots();
  }

  addDonor(DonorModel data) async {
    await donorService.donorRef.add(data);
    notifyListeners();
  }

  updateDonor(id, DonorModel data) {
    donorService.donorRef.doc(id).update(data.toJson());
    notifyListeners();
  }

  deleteDonor(id) {
    donorService.donorRef.doc(id).delete();
    notifyListeners();
  }
}
