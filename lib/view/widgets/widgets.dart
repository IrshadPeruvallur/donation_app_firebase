import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddWidgets {
  Widget textFormField(label, controller) {
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
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget dropDownButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Consumer<WidgetsProvider>(builder: (context, widgetvalue, child) {
        return DropdownButtonFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter";
            } else {
              return null;
            }
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              label: Text("Select Blood Group")),
          value: widgetvalue.selectedItem,
          items: widgetvalue.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (value) {
            widgetvalue.dropDownItem(value);
          },
        );
      }),
    );
  }
}
