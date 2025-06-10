import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  static const String name = '/add-new-product';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _imageUrlTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Product')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildProductForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'Product Name',
              labelText: 'Product Name',
            ),
            validator: (String? value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter a product name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _codeTEController,
            decoration: const InputDecoration(
              hintText: 'Product Code',
              labelText: 'Product Code',
            ),
            validator: (String? value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter a product code';
              }
              return null;
            },
          ),
          /*TextFormField(
            controller: _imageUrlTEController,
            decoration: const InputDecoration(
              hintText: 'Image URL',
              labelText: 'Image URL',
            ),
            validator: (String? value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter an image URL';
              }
              return null;
            },
          ),*/
          TextFormField(
            controller: _unitPriceTEController,
            decoration: const InputDecoration(
              hintText: 'Unit Price',
              labelText: 'Unit Price',
            ),
            validator: (String? value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter a unit price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _quantityTEController,
            decoration: const InputDecoration(
              hintText: 'Quantity',
              labelText: 'Quantity',
            ),
            validator: (String? value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter a quantity';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: const InputDecoration(
              hintText: 'Total Price',
              labelText: 'Total Price',
            ),
            validator: (String? value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return 'Please enter a total price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: _addNewProductInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                _addNewProduct();
              }
            }, child: Text('Add Product')),
          ),
        ],
      ),
    );
  }

  Future<void> _addNewProduct() async {
    _addNewProductInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "Img": _imageUrlTEController.text.trim(),
      "UnitPrice": _unitPriceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      // "CreatedDate": _createdDateTEController.text.trim(),
      // "_id":
    };

    Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);
    _addNewProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New product added'),),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New product add failed! Try again.'),),);
    }
    Navigator.pop(context, true);
  }

  void _clearTextFields() {
    _nameTEController.clear();
    _codeTEController.clear();
    _imageUrlTEController.clear();
    _unitPriceTEController.clear();
    _quantityTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _imageUrlTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    super.dispose();
  }
}