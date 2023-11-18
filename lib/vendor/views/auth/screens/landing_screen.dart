import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_vendor_app/model/vendor_user_model.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/main_vendor_screen.dart';
import 'package:dukan_vendor_app/vendor/views/vendor_registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference vendorStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: vendorStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.data!.exists) {
            return const VendorRegistrationScreen();
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return const MainVendorScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    vendorUserModel.storeImage,
                    width: 90,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  vendorUserModel.bussinessName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Your Application, has been send to shop admin\nadmin will get back to you soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: const Text(
                    'Sign out',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
