import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/product.dart';
import '/screens/product_detail.dart';

class FeedsProducts extends StatefulWidget {
  FeedsProducts({Key? key}) : super(key: key);

  @override
  _FeedsProductsState createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetail.routeName),
      child: Container(
        width: 250,
        height: 290,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).backgroundColor),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                        minHeight: 100,
                        maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Chip(
                  label: Text('New'),
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$ ${product.price}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity: ${product.quantity}'),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            )),
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
