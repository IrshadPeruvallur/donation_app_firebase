import 'package:blood_donation_app/controller/donor_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/model/donor_model.dart';
import 'package:flutter/material.dart';

class AddEditProvider extends ChangeNotifier {
  TextEditingController nameCntlr = TextEditingController();
  TextEditingController ageCntlr = TextEditingController();
  TextEditingController phoneCntlr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final WidgetsProvider _widgetsProvider = WidgetsProvider();
  final DonorProvider _donorProvider = DonorProvider();
  bool isEdit = false;

  addDonor(context) {
    final data = DonorModel(
        age: int.parse(ageCntlr.text),
        group: _widgetsProvider.selectedItem,
        name: nameCntlr.text,
        phone: int.parse(phoneCntlr.text));

    _donorProvider.addDonor(data);
    notifyListeners();
  }

  updateDonor(id) {
    final data = DonorModel(
        age: int.parse(ageCntlr.text),
        group: _widgetsProvider.selectedItem,
        name: nameCntlr.text,
        phone: int.parse(phoneCntlr.text));
    _donorProvider.updateDonor(id, data);
    notifyListeners();
  }
}
