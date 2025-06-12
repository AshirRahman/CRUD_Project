import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../models/product.dart';
import '../widgets/product_item.dart';
import 'add_new_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<Product> productList = [];

  bool _getProductListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getProductList();
      },
      child: Visibility(
        visible: _getProductListInProgress == false,
        replacement: const Center(child: CircularProgressIndicator()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Product List'),
            actions: [
              IconButton(onPressed: () {
                _getProductList();
              }, icon: Icon(Icons.refresh))
            ],
          ),
          body: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: productList[index],

              );
            },
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.pushNamed(context, AddNewProductScreen.name);
            setState(() {});
          },child: const Icon(Icons.add)),
        ),
      ),
    );
  }

  //api call for getting product list
  Future<void> _getProductList() async {
    productList.clear();
    _getProductListInProgress = true;
    setState(() {});
    Response response = await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      for (Map<String, dynamic> p in decodedData['data']) {
        Product product = Product(
          id: p['_id'],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          imageUrl: p['Img'],
          unitPrice: p['UnitPrice'],
          quantity: p['Qty'],
          totalPrice: p['TotalPrice'],
          createdDate: p['CreatedDate'],
        );
        productList.add(product);
      }
      setState(() {});
    }
    _getProductListInProgress = false;
    setState(() {});
  }

}
