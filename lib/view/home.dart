import 'dart:developer';

import 'package:blood_donation_app/controller/donor_provider.dart';
import 'package:blood_donation_app/model/donor_model.dart';
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
      appBar: AppBar(),
      body: Consumer<DonorProvider>(builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot<DonorModel>>(
          stream: value.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              log("${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            List<QueryDocumentSnapshot<DonorModel>> donatorDocs =
                snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: donatorDocs.length,
              itemBuilder: (context, index) {
                DonorModel donor = donatorDocs[index].data();
                return Text(donor.name!);
              },
            );
          },
        );
      }),
    );
  }
}
