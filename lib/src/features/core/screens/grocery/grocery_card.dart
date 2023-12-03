import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/update_grocery_screen.dart';
import 'package:quickgrocer_application/src/repository/grocery_repository/grocery_repository.dart';

class GroceryCard extends StatefulWidget {
  final GroceryModel grocery;

  const GroceryCard({super.key, required this.grocery});

  @override
  State<GroceryCard> createState() => _GroceryCardState();
}

class _GroceryCardState extends State<GroceryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greyColor2,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Image.network(widget.grocery.imageUrl, fit: BoxFit.cover),
            ),
            Text(
              widget.grocery.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '\RM' '${widget.grocery.price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.mainPineColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: IconButton(
                      icon: Icon(Icons.edit_square, color: Colors.white),
                      onPressed: () => Get.to(() => UpdateGroceryScreen(grocery: widget.grocery)),
                      ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete_forever_rounded, color: Colors.white),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: Text('Delete Grocery'),
                                  content:
                                      Text('Confirm to delete this grocery?'),
                                  actions: [
                                    ElevatedButton(
                                      child: Text('NO'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    ElevatedButton(
                                      child: Text('YES'),
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        setState(() {
                                          GroceryRepository.instance.deleteGroceryRecord(widget.grocery);
                                        }),
                                      },
                                    ),
                                  ]));
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
