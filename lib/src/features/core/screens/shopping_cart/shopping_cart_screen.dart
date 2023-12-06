import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/cart_controller.dart';
import 'package:quickgrocer_application/src/features/core/controllers/store_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_item_model.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_model.dart';
import 'package:quickgrocer_application/src/features/core/models/store_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/shopping_cart/view_grocery_details_from_cart.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late List<CartItemModel> cartItems;
  late StoreModel store;
  final cartController = Get.put(CartController());
  final storeController = Get.put(StoreController());

  @override
  void initState() {
    super.initState();
    cartController.removeOutOfStockData();
  }

  @override
  Widget build(BuildContext context) {
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
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
            await Future.delayed(const Duration(seconds: 1));
          },
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
                          cartController.totalPrice =
                              cartController.changeCartTotalPrice(cart);

                          return Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 8 / 12,
                                child: _buildAllCartItems(cartItems),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
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
      ),
      bottomSheet: BottomAppBar(
        height: MediaQuery.of(context).size.height / 12,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          width: double.infinity,
          child: Container(
            child: FutureBuilder(
                future: storeController.getStoreData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      StoreModel store = snapshot.data as StoreModel;
                      bool storeStatus = store.status;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\RM'
                            '${cartController.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                              onPressed:
                                  storeStatus == true ? () => {} : () => {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                backgroundColor: store.status == true
                                    ? AppColors.mainPineColor
                                    : Colors.grey,
                                side: store.status == true
                                    ? BorderSide(color: AppColors.mainPineColor)
                                    : BorderSide(color: Colors.grey),
                                shape: StadiumBorder(),
                              ),
                              icon: storeStatus == true
                                  ? Icon(Icons.shopping_cart_checkout)
                                  : Icon(Icons.remove_shopping_cart_rounded),
                              label: storeStatus == true
                                  ? Text(checkoutShoppingCart)
                                  : Text(storeClosed)),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }

  // user list widget
  _buildAllCartItems(List<CartItemModel> cartItems) => ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: ((context, index) {
        return Card(
          color: Colors.white,
          child: Slidable(
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewGroceryDetailsFromCartScreen(
                            grocery: cartItems[index])));
              },
              visualDensity: VisualDensity(vertical: 4),
              leading: Image.network(
                cartItems[index].image,
                width: 50,
                height: 50,
              ),
              title: Text(
                cartItems[index].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                '\RM'
                '${cartItems[index].price.toStringAsFixed(2)}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
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
                        icon: Icon(LineAwesomeIcons.chevron_circle_left, color: Colors.black),
                      ),
                      Text(
                        cartItems[index].quantity.toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
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
                          icon: Icon(LineAwesomeIcons.chevron_circle_right), color: Colors.black),
                    ]),
              ),
            ),
          ),
        );
      }));
}
