import 'package:flutter/material.dart';

import '../screens/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network('https://www.nfm.com/dw/image/v2/BDFM_PRD/on/demandware.static/-/Sites-nfm-master-catalog/default/dwf6cc12b5/images/067/15/67153650-1.jpg?sw=1000&sh=1000&sm=fit'),
        title: Text('Product Name'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Code: #code'),
            Text('Quantity: 23'),
            Text('Price: 3435'),
            Text('Total Price: 202554')
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context ,UpdateProductScreen.name);
            }, icon: const Icon(Icons.edit)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
          ],
        )
    );
  }
}