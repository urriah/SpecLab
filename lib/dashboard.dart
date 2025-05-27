import 'package:flutter/material.dart';
import 'dart:async';
import 'building_page.dart';
import 'profile_page.dart';
import 'builds_page.dart';

class DashboardPage extends StatefulWidget {
  final String userEmail;
  const DashboardPage({super.key, required this.userEmail});
  

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  // List to store saved builds
  final List<Map<String, dynamic>> _savedBuilds = [];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.06;
    final double topPadding = size.height * 0.06;
    final double logoSize = size.width * 0.18;
    final double pageViewHeight = size.height * 0.28;
    final double categoryCardHeight = size.height * 0.13;
    final double actionTileWidth = (size.width - horizontalPadding * 2 - 10) / 2;
    final double actionTileHeight = size.height * 0.18;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  top: topPadding,
                  right: horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/speclab1.png',
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.contain,
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                height: pageViewHeight,
                child: PageView(
                  controller: _pageController,
                  children: [
                    Image.asset('assets/images/1.png', fit: BoxFit.cover),
                    Image.asset('assets/images/2.png', fit: BoxFit.cover),
                    Image.asset('assets/images/3.png', fit: BoxFit.cover),
                    Image.asset('assets/images/4.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.025),

              // Slidable Component Category Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: SizedBox(
                  height: categoryCardHeight,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryCard('assets/images/CPU.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/GPU.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/MB.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/RAM.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/Storage.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/PSU.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/FAN.png', categoryCardHeight),
                      SizedBox(width: size.width * 0.025),
                      _buildCategoryCard('assets/images/Case.png', categoryCardHeight),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.025),

              // Action Tiles using your asset images
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: [
                    // Build Your Rig Tile (larger)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BuildingPage(savedBuilds: _savedBuilds)),
                        );
                      },
                      child: Container(
                        width: actionTileWidth,
                        height: actionTileHeight * 1.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/Build_Now.png',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(userEmail: widget.userEmail),
                              ),
                            );
                          },
                          child: Container(
                            width: actionTileWidth,
                            height: actionTileHeight * 0.68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/Profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BuildsPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: actionTileWidth,
                            height: actionTileHeight * 0.68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/Your_Builds.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.025),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String imagePath, double height) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}