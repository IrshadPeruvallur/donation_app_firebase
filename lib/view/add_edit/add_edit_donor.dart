import 'package:blood_donation_app/controller/pages_provider/add_edit_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
    final addEditProvider = Provider.of<AddEditProvider>(context, listen: false);
    final widgetsProvider = Provider.of<WidgetsProvider>(context, listen: false);

    addEditProvider.nameCntlr = TextEditingController(text: widget.name);
    addEditProvider.phoneCntlr = TextEditingController(text: widget.phone?.toString() ?? '');
    addEditProvider.ageCntlr = TextEditingController(text: widget.age?.toString() ?? '');
    widgetsProvider.selectedItem = widget.group;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addEditProvider = Provider.of<AddEditProvider>(context, listen: false);

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
                Consumer<AddEditProvider>(
                  builder: (context, value, child) => AddWidgets().textFormField('Name', value.nameCntlr),
                ),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) => AddWidgets().textFormField('Age', value.ageCntlr),
                ),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) => AddWidgets().textFormField('Phone', value.phoneCntlr),
                ),
                Consumer<AddEditProvider>(
                  builder: (context, value, child) => AddWidgets().dropDownButton(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(500, 50)),
                    ),
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
