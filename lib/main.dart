
// ignore_for_file: use_key_in_widget_constructors

import 'package:blood_donation_app/controller/donor_provider.dart';
import 'package:blood_donation_app/controller/pages_provider/add_edit_provider.dart';
import 'package:blood_donation_app/controller/widgets_provider.dart';
import 'package:blood_donation_app/service/firebase_options.dart';
import 'package:blood_donation_app/view/display/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DonorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WidgetsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddEditProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
