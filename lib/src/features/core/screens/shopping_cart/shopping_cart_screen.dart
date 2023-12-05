import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/cart_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_item_model.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late List<CartItemModel> cartItems;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    late CartModel cart;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          shoppingCartScreenTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Container(
              child: FutureBuilder(
                  future: cartController.getCartData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        cart = snapshot.data as CartModel;
                        cartItems = cart.cart;
                        cartController.changeCartTotalPrice(cart);

                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  8.75 /
                                  12,
                              child: _buildAllCartItems(cartItems),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 9 / 12,
                              child: ElevatedButton.icon(
                                  onPressed: () => {},
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  icon: Icon(Icons.shopping_cart_checkout),
                                  label: Text(checkoutShoppingCart +
                                      '\ (Total RM'
                                          '${cartController.changeCartTotalPrice(cart).toStringAsFixed(2)})')),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("No items added into cart"));
                      } else {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ]),
        ),
      ),
    );
  }

  // user list widget
  _buildAllCartItems(List<CartItemModel> cartItems) => ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: ((context, index) {
        return Slidable(
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
                onPressed: (context) async {
                  CartController.instance.removeCartItem(cartItems[index]);
                  cartItems.removeAt(index);
                  setState(() {});
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete')
          ]),
          child: ListTile(
            visualDensity: VisualDensity(vertical: 4),
            leading: Image.network(
              cartItems[index].image,
              width: 50,
              height: 50,
            ),
            title: Text(
              cartItems[index].name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '\RM'
              '${cartItems[index].price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: SizedBox(
              width: 120,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        CartController.instance
                            .decreaseQuantity(cartItems[index]);
                        setState(() {});
                      },
                      icon: Icon(LineAwesomeIcons.chevron_circle_left),
                    ),
                    Text(
                      cartItems[index].quantity.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () async {
                          await CartController.instance
                                      .checkQuantity(cartItems[index]) ==
                                  true
                              ? CartController.instance
                                  .increaseQuantity(cartItems[index])
                              : Get.snackbar("Invalid Operation",
                                  "Quantity to purchase cannot exceed the quantity of item in stock");
                          setState(() {});
                        },
                        icon: Icon(LineAwesomeIcons.chevron_circle_right)),
                  ]),
            ),
          ),
        );
      }));
}
