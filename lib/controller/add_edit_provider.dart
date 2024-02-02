import 'package:blood_donation_app/controller/donor_provider.dart';
import 'package:blood_donation_app/controller/image_provider.dart';
// import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/model/donor_model.dart';
import 'package:flutter/material.dart';

class AddEditProvider extends ChangeNotifier {
  TextEditingController nameCntlr = TextEditingController();
  TextEditingController ageCntlr = TextEditingController();
  TextEditingController phoneCntlr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // final WidgetsProvider _widgetsProvider = WidgetsProvider();
  final DonorProvider _donorProvider = DonorProvider();
  final ImgProvider imgProvider = ImgProvider();
  bool isEdit = false;
  List<String> items = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedItem='';


  addDonor(context)async {
    await imgProvider.uploadImage();  
    final data = DonorModel(
        age: int.parse(ageCntlr.text),
        group: selectedItem,
        name: nameCntlr.text,
        phone: int.parse(phoneCntlr.text),
        image: imgProvider.downloadURL);

    _donorProvider.addDonor(data);
    clearTextFields();  
    notifyListeners();
  }

  updateDonor(id) {
    final data = DonorModel(
        age: int.parse(ageCntlr.text),
        group: selectedItem,
        name: nameCntlr.text,
        phone: int.parse(phoneCntlr.text),
        image: ''
        );
    _donorProvider.updateDonor(id, data);
    clearTextFields();
    notifyListeners();
  }

  clearTextFields() {
    nameCntlr.clear();
    ageCntlr.clear();
    phoneCntlr.clear();
    selectedItem = null;
    notifyListeners();
  }

  loadDatasToEdit(name, phone, age, group) {
    nameCntlr = TextEditingController(text: name);
    phoneCntlr = TextEditingController(text: phone?.toString() ?? '');
    ageCntlr = TextEditingController(text: age?.toString() ?? '');
    selectedItem = group;
  }
}
