import 'package:blood_donation_app/model/donor_model.dart';
import 'package:blood_donation_app/service/donor_service.dart';
import 'package:flutter/foundation.dart';

class DonorProvider extends ChangeNotifier {
  DonorService donorService = DonorService();
  getData() {
    return donorService.donorRef.snapshots();
  }

  addDonor(id, DonorModel data) async {
    await donorService.donorRef.add(data);
    notifyListeners();
  }
}
