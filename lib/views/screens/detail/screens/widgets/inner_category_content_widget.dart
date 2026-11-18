import 'package:flutter/material.dart';
import 'package:godgreat_app/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:godgreat_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:godgreat_app/controllers/subcategory_controller.dart';
import 'package:godgreat_app/models/category.dart';
import 'package:godgreat_app/models/subcategory.dart';
import 'package:godgreat_app/views/screens/detail/screens/widgets/inner_banner_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    super.initState();
    _subCategories = _subcategoryController.getSubCategoriesByCategoryName(
      widget.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const InnerHeaderWidget(),
          InnerBannerWidget(image: widget.category.banner),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Shop By Category',
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: _subCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Subcategories'));
              } else {
                final subcategories = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate((subcategories.length / 7).ceil(), (
                      index,
                    ) {
                      // for each row, calculate the starting and ending indices
                      final start = index * 7;
                      final end = (index + 1) * 7;

                      // create a padding widget to add spacing around the row
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            // Create a Row of the subcategory tile
                            children:
                                subcategories
                                    .sublist(
                                      start,
                                      end > subcategories.length
                                          ? subcategories.length
                                          : end,
                                    )
                                    .map(
                                      (subcategory) => SubcategoryTileWidget(
                                        image: subcategory.image,
                                        title: subcategory.subCategoryName,
                                      ),
                                    )
                                    .toList(),
                          ), // Row
                        ), // SingleChildScrollView
                      ); // Padding
                    }), // List.generate
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
