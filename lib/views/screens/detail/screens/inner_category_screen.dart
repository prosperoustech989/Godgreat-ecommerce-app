import 'package:flutter/material.dart';
import 'package:godgreat_app/models/category.dart';
import 'package:godgreat_app/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:godgreat_app/views/screens/nav_screens/account_screen.dart';
import 'package:godgreat_app/views/screens/nav_screens/cart_screen.dart';
import 'package:godgreat_app/views/screens/nav_screens/category_screen.dart';
import 'package:godgreat_app/views/screens/nav_screens/favorite_screen.dart';
import 'package:godgreat_app/views/screens/nav_screens/stores_screen.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      InnerCategoryContentWidget(category: widget.category),
      const FavoriteScreen(),
      const CategoryScreen(),
      const StoresScreen(),
      const CartScreen(),
      AccountScreen(),
    ];

    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/icons/home.png'),
              width: 24,
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/icons/love.png'),
              width: 24,
              height: 24,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/icons/mart.png'),
              width: 24,
              height: 24,
            ),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/icons/cart.png'),
              width: 24,
              height: 24,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/icons/user.png'),
              width: 24,
              height: 24,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
