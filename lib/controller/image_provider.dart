import 'dart:developer';
import 'dart:io';

import 'package:blood_donation_app/service/donor_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider extends ChangeNotifier {
  DonorService donorService = DonorService();
  File? file;
  ImagePicker image = ImagePicker();
  String imageName = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadURL = '';

  getImage(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }

  uploadImage() async {
    try {
      Reference imageFolder =
          donorService.storage.ref().child('profilePicture'); //imagefolder name
      Reference uploadImae =
          imageFolder.child("$imageName.jpg"); //sett image name
      await uploadImae.putFile(File(file!.path));
      downloadURL = await uploadImae.getDownloadURL();
      log(downloadURL);
      notifyListeners();
    } catch (e) {
      return Exception('image cant be added $e');
    }
    notifyListeners();
  }
}
