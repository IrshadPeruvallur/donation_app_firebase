import 'package:blood_donation_app/controller/add_edit_provider.dart';
import 'package:blood_donation_app/controller/image_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/view/add_edit/add_edit_donor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddWidgets {
  Widget textFormField(label, controller,
      {int? maxLength,
      String? prefixText,
      TextInputFormatter? formatters,
      TextInputType? inputType}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter $label ";
          } else {
            return null;
          }
        },
        keyboardType: inputType,
        maxLength: maxLength,
        inputFormatters: [formatters!],
        controller: controller,
        decoration: InputDecoration(
          prefixText: prefixText,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget dropDownButton(value) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Consumer<AddEditProvider>(builder: (context, widgetvalue, child) {
        return DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return "Please Enter";
            } else {
              return null;
            }
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              label: Text("Select Blood Group")),
          value: value,
          items: widgetvalue.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (value) {
            widgetvalue.selectedItem = value.toString();
          },
        );
      }),
    );
  }

  circleImage(context) {
    return Consumer<ImgProvider>(builder: (context, value, child) {
      return FutureBuilder(
          future: Future.value(value.file),
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                showImagePickerBottomSheet(context, value);
              },
              child: CircleAvatar(
                child: snapshot.data != null
                    ? Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 8),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(snapshot.data!),
                          ),
                        ),
                      )
                    : Icon(Icons.add_a_photo),
                radius: 60,
              ),
            );
          });
    });
  }

  showImagePickerBottomSheet(context, ImgProvider value) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.camera,
                    size: 60,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        value.getImage(ImageSource.camera);
                      },
                      child: Text("Camera"))
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.photo,
                    size: 60,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        value.getImage(ImageSource.gallery);
                      },
                      child: Text("Gallery"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
