import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/home.png")),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/love.png")),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/mart.png")),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/cart.png")),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/user.png")),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
