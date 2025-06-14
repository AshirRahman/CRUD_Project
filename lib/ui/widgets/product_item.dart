import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../screens/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (product.imageUrl != null && product.imageUrl!.trim().isNotEmpty)
          ? Image.network(
              product.imageUrl!,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
              width: 40,
            )
          : const Icon(Icons.broken_image),
      title: Text(product.productName ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? ''}'),
          Text('Quantity: ${product.quantity ?? ''}'),
          Text('Price: ${product.unitPrice ?? ''}'),
          Text('Total Price: ${product.totalPrice ?? ''}'),
          // Text('Created Date: ${product.createdDate ?? ''}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              //TODO delete product
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
