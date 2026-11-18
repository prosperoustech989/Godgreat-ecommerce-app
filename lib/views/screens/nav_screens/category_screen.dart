import 'package:flutter/material.dart';
import 'package:godgreat_app/controllers/subcategory_controller.dart';
import 'package:godgreat_app/models/subcategory.dart';
import 'package:godgreat_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:godgreat_app/controllers/category_controller.dart';
import 'package:godgreat_app/models/category.dart';
import 'package:godgreat_app/views/screens/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // A future that will hold the list of categories once loaded from the API
  late Future<List<Category>> futureCategories;

  Category? _selectedCategory;
  List<Subcategory> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
    //once the categories are loaded process them
    futureCategories.then((categories) {
      //iterate through the categories to find the "Fashion" category
      for (var category in categories) {
        if (category.name == "Fashion") {
          //if "Fashion" category is found set it as the selected category

          setState(() {
            _selectedCategory = category;
          });
          //load subcategories for the "Fashion" category
          _loadSubcategories(category.name);
        }
      }
    });
  }

  //this will load subcategories base on the categoryName
  Future<void> _loadSubcategories(String categoryName) async {
    final subcategories = await _subcategoryController
        .getSubCategoriesByCategoryName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: HeaderWidget(),
      ), // PreferredSize
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left side - Display categories
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Center
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    ); // Center
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubcategories(category.name);
                          },
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color:
                                  _selectedCategory == category
                                      ? Colors.blue
                                      : Colors.black,
                            ),
                          ), // Text
                        ); // ListTile
                      },
                    ); // ListView.builder
                  }
                },
              ), // FutureBuilder
            ), // Container
          ),
          //Right side - Display selected category details
          Expanded(
            flex: 5,
            child:
                _selectedCategory != null
                    ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 12.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              _selectedCategory!.name,
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                              bottom: 8.0,
                            ),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _selectedCategory!.banner,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          _subcategories.isNotEmpty
                              ? GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _subcategories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 2 / 3,
                                    ),
                                itemBuilder: (context, index) {
                                  final Subcategory = _subcategories[index];

                                  return SubcategoryTileWidget(
                                    image: Subcategory.image,
                                    title: Subcategory.subCategoryName,
                                  );
                                },
                              )
                              : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'No sub categories',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.7,
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    )
                    : Container(),
          ),
        ],
      ),
    );
  }
}
