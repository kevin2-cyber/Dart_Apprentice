import 'package:cupertino_app/app/widget/product.row.item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../model/app.state.model.dart';


class ProductListTab extends StatelessWidget {
  const ProductListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final products = model.getProducts();
        return CustomScrollView(
          semanticChildCount: products.length,
          slivers:  <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Cupertino Store'),
            ),
            SliverSafeArea(   // BEGINNING OF NEW CONTENT
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index < products.length) {
                      return ProductRowItem(
                        product: products[index],
                        lastItem: index == products.length - 1,
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}