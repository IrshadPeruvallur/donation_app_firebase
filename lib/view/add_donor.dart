import 'package:blood_donation_app/controller/donor_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/model/donor_model.dart';
import 'package:blood_donation_app/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDonorPage extends StatelessWidget {
  AddDonorPage({Key? key});

  final TextEditingController nameCntlr = TextEditingController();
  final TextEditingController ageCntlr = TextEditingController();
  final TextEditingController groupCntlr = TextEditingController();
  final TextEditingController phoneCntlr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddWidgets().textFormField('Name', nameCntlr),
                AddWidgets().textFormField('Age', ageCntlr),
                AddWidgets().textFormField('Phone', phoneCntlr),
                AddWidgets().dropDownButton(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(500, 50))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          addDonor(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addDonor(context) {
    final getPrv = Provider.of<DonorProvider>(context, listen: false);
    final getWidgetPrv = Provider.of<WidgetsProvider>(context, listen: false);
    final data = DonorModel(
        age: int.parse(ageCntlr.text),
        group: getWidgetPrv.selectedItem,
        name: nameCntlr.text,
        phone: int.parse(phoneCntlr.text));

    getPrv.addDonor(data);
  }
}
