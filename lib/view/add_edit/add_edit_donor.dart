import 'package:blood_donation_app/controller/add_edit_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddEditDonorPage extends StatefulWidget {
  final String? name;
  final String? group;
  final int? phone;
  final int? age;
  final String? id;

  const AddEditDonorPage({
    Key? key,
    this.name,
    this.group,
    this.phone,
    this.age,
    this.id,
  }) : super(key: key);

  @override
  State<AddEditDonorPage> createState() => _AddEditDonorPageState();
}

class _AddEditDonorPageState extends State<AddEditDonorPage> {
  @override
  void initState() {
    Provider.of<AddEditProvider>(context, listen: false)
        .loadDatasToEdit(widget.name, widget.phone, widget.age, widget.group);
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addEditProvider =
        Provider.of<AddEditProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(addEditProvider.isEdit ? "Edit Details" : "Add Details"),
      ),
      body: Form(
        key: addEditProvider.formKey,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddWidgets().circleImage(context),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) =>
                      AddWidgets().textFormField(
                    'Name',
                    value.nameCntlr,
                    formatters: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z\s]')),
                  ),
                ),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) =>
                      AddWidgets().textFormField(
                    'Age',
                    maxLength: 2,
                    value.ageCntlr,
                    formatters: FilteringTextInputFormatter.digitsOnly,
                    inputType: TextInputType.number,
                  ),
                ),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) =>
                      AddWidgets().textFormField(
                    'Phone',
                    prefixText: '+91',
                    maxLength: 10,
                    value.phoneCntlr,
                    formatters: FilteringTextInputFormatter.digitsOnly,
                    inputType: TextInputType.phone,
                  ),
                ),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) => AddWidgets()
                      .dropDownButton(
                              value.selectedItem),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (addEditProvider.formKey.currentState!.validate()) {
                        if (addEditProvider.isEdit) {
                          addEditProvider.updateDonor(widget.id);
                          Navigator.pop(context);
                        } else {
                          addEditProvider.addDonor(context);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text(addEditProvider.isEdit ? "Update" : "Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
