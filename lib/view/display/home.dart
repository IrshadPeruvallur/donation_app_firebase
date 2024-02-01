import 'dart:developer';
import 'package:blood_donation_app/controller/donor_provider.dart';
import 'package:blood_donation_app/controller/add_edit_provider.dart';
import 'package:blood_donation_app/model/donor_model.dart';
import 'package:blood_donation_app/view/add_edit/add_edit_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final CollectionReference items =
      FirebaseFirestore.instance.collection('doner');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blood Donation App'),
      ),
      body: Consumer<DonorProvider>(builder: (context, donorValue, child) {
        return StreamBuilder<QuerySnapshot<DonorModel>>(
          stream: donorValue.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              log("${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            List<QueryDocumentSnapshot<DonorModel>> donatorDocs =
                snapshot.data?.docs ?? [];
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: donatorDocs.length,
              itemBuilder: (context, index) {
                DonorModel donor = donatorDocs[index].data();
                final id = donatorDocs[index].id;
                return ListTile(
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == "Edit") {
                        Provider.of<AddEditProvider>(context, listen: false)
                            .isEdit = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditDonorPage(
                                age: donor.age,
                                group: donor.group,
                                name: donor.name,
                                phone: donor.phone,
                                id: id,
                              ),
                            ));
                      } else if (value == "Delete") {
                        donorValue.deleteDonor(id);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: "Edit",
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: "Delete",
                          child: Text('Delete'),
                        )
                      ];
                    },
                  ),
                  tileColor: const Color.fromARGB(255, 43, 43, 43),
                  title: Text(
                    donor.name!.toUpperCase(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    donor.phone!.toString(),
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Provider.of<AddEditProvider>(context, listen: false).isEdit = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEditDonorPage(),
                ));
          },
          label: const Text("Add")),
    );
  }
}
