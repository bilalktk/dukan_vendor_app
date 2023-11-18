import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_vendor_app/vendor/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Name';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(productName: value);
              },
              decoration: const InputDecoration(
                labelText: 'Enter Product Name',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Price';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(productPrice: double.parse(value));
              },
              decoration: const InputDecoration(
                labelText: 'Enter Product Price ',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Quantity';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(productQuantity: int.parse(value));
              },
              decoration: const InputDecoration(
                hintText: 'Enter Product Quantity',
                labelText: 'Enter Product Quantity ',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              hint: const Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              items: _categoryList.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                productProvider.getFormData(category: value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Description';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(description: value);
              },
              maxLines: 10,
              minLines: 3,
              maxLength: 800,
              decoration: const InputDecoration(
                hintText: 'Enter Product Description',
                labelText: 'Product Description',
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
