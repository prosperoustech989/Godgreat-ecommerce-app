import 'package:flutter/material.dart';
import 'package:godgreat_app/controllers/category_controller.dart';
import 'package:godgreat_app/models/category.dart';
import 'package:godgreat_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:godgreat_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  // A future that will hold the list of categories once loaded from the API
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
        FutureBuilder(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Center
            } else if (snapshot.hasError) {
              return Center(child: Text('Error ${snapshot.error}')); // Center
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Categories')); // Center
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ), // SliverGridDelegateWithFixedCrossAxisCount
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InnerCategoryScreen(category: category);
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.network(category.image, height: 47, width: 47),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
