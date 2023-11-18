import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_vendor_app/vendor/provider/product_provider.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/tab_bar_screen/attributes_screen.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/tab_bar_screen/general_screen.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/tab_bar_screen/images_screen.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/tab_bar_screen/shipping_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              child: Text('General'),
            ),
            Tab(
              child: Text('Shipping'),
            ),
            Tab(
              child: Text('Attributes'),
            ),
            Tab(
              child: Text('Images'),
            ),
          ]),
        ),
        body: Form(
          key: _formKey,
          child: const TabBarView(children: [
            GeneralScreen(),
            ShippingScreen(),
            AttributesScreen(),
            ImagesScreen(),
          ]),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () async {
              DocumentSnapshot userDoc = await _firestore
                  .collection('vendors')
                  .doc(_auth.currentUser!.uid)
                  .get();
              final productId = const Uuid().v4();
              if (_formKey.currentState!.validate()) {
                EasyLoading.show(status: 'Uploading');
                await _firestore.collection('products').doc(productId).set({
                  'productId': productId,
                  'productName': productProvider.productData['productName'],
                  'productPrice': productProvider.productData['productPrice'],
                  'productQuantity':
                      productProvider.productData['productQuantity'],
                  'category': productProvider.productData['category'],
                  'description': productProvider.productData['description'],
                  'chargeShipping':
                      productProvider.productData['chargeShipping'],
                  'shippingCharge':
                      productProvider.productData['shippingCharge'],
                  'brandName': productProvider.productData['brandName'],
                  'sizeList': productProvider.productData['sizeList'],
                  'productImages': productProvider.productData['imageUrlList'],
                  'bussinessName':
                      (userDoc.data() as Map<String, dynamic>)['bussinessName'],
                  'storeImage':
                      (userDoc.data() as Map<String, dynamic>)['storeImage'],
                  'countryValue':
                      (userDoc.data() as Map<String, dynamic>)['countryValue'],
                  'cityValue':
                      (userDoc.data() as Map<String, dynamic>)['cityValue'],
                  'stateValue':
                      (userDoc.data() as Map<String, dynamic>)['stateValue'],
                  'vendorId': _auth.currentUser!.uid,
                }).whenComplete(() {
                  EasyLoading.dismiss();
                  productProvider.clearData();
                });
              } else {
                print('Not Valid');
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: const Center(
                child: Text(
                  'Upload Product',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
