// ignore_for_file: use_key_in_widget_constructors

import 'package:blood_donation_app/controller/pages_provider/add_edit_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDonorPage extends StatefulWidget {
  final String? name;
  final String? group;
  final int? phone;
  final int? age;
  final String? id;
  const AddDonorPage(
      {Key? key, this.name, this.group, this.phone, this.age, this.id});

  @override
  State<AddDonorPage> createState() => _AddDonorPageState();
}

class _AddDonorPageState extends State<AddDonorPage> {
  @override
  void initState() {
    final getProvider = Provider.of<AddEditProvider>(context, listen: false);
    final getWidgetProvider =
        Provider.of<WidgetsProvider>(context, listen: false);
    getProvider.nameCntlr = TextEditingController(
      text: widget.name,
    );
    getProvider.phoneCntlr = TextEditingController(
      text: widget.phone.toString(),
    );
    getProvider.ageCntlr = TextEditingController(
      text: widget.age.toString(),
    );
    getWidgetProvider.selectedItem = widget.group;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getProvider = Provider.of<AddEditProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(getProvider.isEdit ? "Edit Details" : "Add Details"),
      ),
      body: Form(
        key: getProvider.formKey,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddWidgets().textFormField('Name', getProvider.nameCntlr),
                AddWidgets().textFormField('Age', getProvider.ageCntlr),
                AddWidgets().textFormField('Phone', getProvider.phoneCntlr),
                AddWidgets().dropDownButton(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(500, 50))),
                      onPressed: () {
                        if (getProvider.formKey.currentState!.validate()) {
                          if (getProvider.isEdit) {
                            getProvider.updateDonor(widget.id);
                            Navigator.pop(context);
                          } else {
                            getProvider.addDonor(context);
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(getProvider.isEdit ? "Update" : "Submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
