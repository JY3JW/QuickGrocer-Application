import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/category_controller.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/category_model.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/grocery_card_buyer.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/search_bar.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/view_grocery_details.dart';

class BrowseGroceryScreen extends StatefulWidget {
  const BrowseGroceryScreen({super.key});

  @override
  State<BrowseGroceryScreen> createState() => _BrowseGroceryScreenState();
}

class _BrowseGroceryScreenState extends State<BrowseGroceryScreen> {
  int isSelected = 0;
  late List<CategoryModel> category;

  @override
  Widget build(BuildContext context) {
    final catController = Get.put(CategoryController());
    final grocController = Get.put(GroceryController());
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          browseGroceryTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => SearchBarApp()),
              icon: Icon(
                Icons.search,
                color: iconColorWithoutBackground,
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                  future: catController.getAllCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        category = snapshot.data as List<CategoryModel>;
                        return SizedBox(
                          height: 120,
                          child: GridView.count(
                            crossAxisCount: 1,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(category.length, (index) {
                              return _buildProductCategory(
                                  index: index,
                                  name: category[index].name,
                                  img: category[index].imageUrl);
                            }),
                          ),
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
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                  future: isSelected == 0
                      ? grocController.getAllGroceries()
                      : grocController
                          .getGroceriesByCategory(category[isSelected].name),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<GroceryModel> grocery =
                            snapshot.data as List<GroceryModel>;
                        return SizedBox(
                            height: 500, child: _buildAllGroceries(grocery));
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
            ),
          ],
        ),
      ),
    );
  }

  // product category widget
  _buildProductCategory(
          {required int index, required String name, required String img}) =>
      GestureDetector(
        onTap: () => setState(() => isSelected = index),
        child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected == index
                  ? AppColors.mainPineColor
                  : AppColors.greyColor1,
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(img, fit: BoxFit.cover)),
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected == index ? Colors.white : Colors.black,
                    fontSize: 12),
              ),
            ])),
      );

  // grocery card widget
  _buildAllGroceries(List<GroceryModel> grocery) => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 135),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: grocery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ViewGroceryDetailsScreen(grocery: grocery[index]))),
          child: GroceryCardBuyer(grocery: grocery[index]),
        );
      });
}
