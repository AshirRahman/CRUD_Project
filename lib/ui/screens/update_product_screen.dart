import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update-product';

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _imageUrlTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();

  bool _updateProductInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
    _imageUrlTEController.text = widget.product.imageUrl ?? '';
    _unitPriceTEController.text = widget.product.unitPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Product')),
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
      //TODO: form validation
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            decoration: const InputDecoration(
              hintText: 'Product Name',
              labelText: 'Product Name',
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
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
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a product code';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageUrlTEController,
            decoration: const InputDecoration(
              hintText: 'Image URL',
              labelText: 'Image URL',
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter an image URL';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _unitPriceTEController,
            decoration: const InputDecoration(
              hintText: 'Unit Price',
              labelText: 'Unit Price',
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
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
              if (value == null || value.trim().isEmpty) {
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
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a total price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: _updateProductInProgress == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ElevatedButton(
              onPressed: () {
                //TODO from validation
                _updateProduct();
              },
              child: Text('Update Product'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
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
      Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}',
      ),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print(response.statusCode);
    print(response.body);

    _updateProductInProgress = false;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Product has been updated')));
    } else {}
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
