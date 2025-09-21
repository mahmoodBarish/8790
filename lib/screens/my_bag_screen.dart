import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({Key? key}) : super(key: key);

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  int _item1Quantity = 1;
  int _item2Quantity = 1;
  int _item3Quantity = 1;

  void _incrementQuantity(int itemIndex) {
    setState(() {
      if (itemIndex == 1) _item1Quantity++;
      if (itemIndex == 2) _item2Quantity++;
      if (itemIndex == 3) _item3Quantity++;
    });
  }

  void _decrementQuantity(int itemIndex) {
    setState(() {
      if (itemIndex == 1 && _item1Quantity > 1) _item1Quantity--;
      if (itemIndex == 2 && _item2Quantity > 1) _item2Quantity--;
      if (itemIndex == 3 && _item3Quantity > 1) _item3Quantity--;
    });
  }

  double _calculateTotalPrice() {
    return (_item1Quantity * 599).toDouble() +
        (_item2Quantity * 400).toDouble() +
        (_item3Quantity * 199).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: screenHeight * 0.15), // Reserve space for fixed bottom bar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.12), // Space for header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.053), // 20 / 375
                    child: Text(
                      'My Shopping Bag',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.12,
                        color: const Color(0xFF121212),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.024), // Approx 24px height
                  _buildBagItem(
                    context,
                    imagePath: 'assets/images/192_104.png',
                    name: 'Jan Sflanaganvik sofa',
                    qty: _item1Quantity,
                    price: 599,
                    onMinus: () => _decrementQuantity(1),
                    onPlus: () => _incrementQuantity(1),
                    onCancel: () {
                      // Handle cancel for item 1
                    },
                  ),
                  _buildDivider(screenWidth),
                  _buildBagItem(
                    context,
                    imagePath: 'assets/images/192_79.png',
                    name: 'Sverom chair',
                    qty: _item2Quantity,
                    price: 400,
                    onMinus: () => _decrementQuantity(2),
                    onPlus: () => _incrementQuantity(2),
                    onCancel: () {
                      // Handle cancel for item 2
                    },
                  ),
                  _buildDivider(screenWidth),
                  _buildBagItem(
                    context,
                    imagePath: 'assets/images/192_54.png',
                    name: 'Kallax chair',
                    qty: _item3Quantity,
                    price: 199,
                    onMinus: () => _decrementQuantity(3),
                    onPlus: () => _incrementQuantity(3),
                    onCancel: () {
                      // Handle cancel for item 3
                    },
                  ),
                  SizedBox(height: screenHeight * 0.038), // Approx 38px
                  _buildPromoCodeSection(context, screenWidth),
                  SizedBox(height: screenHeight * 0.038), // Approx 38px
                  _buildRecommendedSection(context, screenWidth),
                ],
              ),
            ),
            _buildFixedHeader(context, screenWidth),
            _buildFixedBottomBar(context, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildBagItem(
      BuildContext context, {
        required String imagePath,
        required String name,
        required int qty,
        required int price,
        required VoidCallback onMinus,
        required VoidCallback onPlus,
        required VoidCallback onCancel,
      }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.053), // 20 / 375
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.213, // 80 / 375
            height: screenWidth * 0.213, // 80 / 375
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200], // Placeholder color
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.08), // 32px / 375px
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.06,
                    color: const Color(0xFF121212),
                  ),
                ),
                SizedBox(height: screenWidth * 0.005),
                Text(
                  'Qty: $qty',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.06,
                    color: const Color(0xFFAAB8B6),
                  ),
                ),
                SizedBox(height: screenWidth * 0.032), // 12px / 375px
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onMinus,
                          child: Container(
                            width: screenWidth * 0.064, // 24 / 375
                            height: screenWidth * 0.064, // 24 / 375
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFD9D9D9), // Placeholder for icons
                            ),
                            child: Icon(Icons.remove, size: screenWidth * 0.04, color: const Color(0xFF23262F)),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.045), // 17 / 375
                        Text(
                          '$qty',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.06,
                            color: const Color(0xFF121212),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.045), // 17 / 375
                        GestureDetector(
                          onTap: onPlus,
                          child: Container(
                            width: screenWidth * 0.064, // 24 / 375
                            height: screenWidth * 0.064, // 24 / 375
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFD9D9D9), // Placeholder for icons
                            ),
                            child: Icon(Icons.add, size: screenWidth * 0.04, color: const Color(0xFF23262F)),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${price * qty}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.08,
                        color: const Color(0xFFE29547),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.03), // 12 / 375
          GestureDetector(
            onTap: onCancel,
            child: Container(
              width: screenWidth * 0.064, // 24 / 375
              height: screenWidth * 0.064, // 24 / 375
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9), // Placeholder for icons
              ),
              child: Icon(Icons.close, size: screenWidth * 0.04, color: const Color(0xFF23262F)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.035, horizontal: screenWidth * 0.053), // 13px / 375px & 20px / 375px
      child: Container(
        height: 1,
        color: const Color(0xFFDEE5E4),
      ),
    );
  }

  Widget _buildPromoCodeSection(BuildContext context, double screenWidth) {
    return Column(
      children: [
        Container(
          height: 5,
          color: const Color(0xFFF1F1F1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.053, horizontal: screenWidth * 0.053), // 20 / 375
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFDEE5E4)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.042), // 16 / 375
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Insert you coupon code',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.06,
                        color: const Color(0xFFAAB8B6),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.027), // 10 / 375
              GestureDetector(
                onTap: () {
                  // Handle apply promo code
                },
                child: Container(
                  width: screenWidth * 0.192, // 72 / 375
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF121212),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Apply',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.07,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 5,
          color: const Color(0xFFF1F1F1),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.053), // 20 / 375
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.053), // 20 / 375
            child: Text(
              'Sofa you might like',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.08,
                color: const Color(0xFF121212),
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.042), // 16 / 375
          SizedBox(
            height: screenWidth * 0.555, // 208 / 375
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.053), // 20 / 375
              children: [
                _buildProductCard(
                  context,
                  imagePath: 'assets/images/192_13.png',
                  name: 'Ektorp sofa',
                  price: 599,
                ),
                SizedBox(width: screenWidth * 0.04), // 15 / 375
                _buildProductCard(
                  context,
                  imagePath: 'assets/images/192_26.png',
                  name: 'Grundtal sofa',
                  price: 499,
                ),
                SizedBox(width: screenWidth * 0.04), // 15 / 375
                _buildProductCard(
                  context,
                  imagePath: 'assets/images/192_39.png',
                  name: 'Poäng table',
                  price: 99,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context, {
        required String imagePath,
        required String name,
        required int price,
      }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.418, // 157 / 375
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF202020).withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 50,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  imagePath,
                  width: screenWidth * 0.418, // 157 / 375
                  height: screenWidth * 0.397, // 149 / 375
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: screenWidth * 0.021, // 8 / 375
                right: screenWidth * 0.021, // 8 / 375
                child: GestureDetector(
                  onTap: () {
                    // Handle wishlist tap
                  },
                  child: Container(
                    width: screenWidth * 0.069, // 26 / 375
                    height: screenWidth * 0.069, // 26 / 375
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: screenWidth * 0.032, // 12 / 375
                      color: const Color(0xFF121212),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.021), // 8 / 375
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.06,
                    color: const Color(0xFFAAB8B6),
                  ),
                ),
                Text(
                  '\$$price',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.07,
                    color: const Color(0xFF121212),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedHeader(BuildContext context, double screenWidth) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100, // Total height for status bar + header
        color: Colors.white,
        child: Column(
          children: [
            // Status bar (fixed height as per design, 44px)
            Container(
              height: 44,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064), // 24 / 375
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: GoogleFonts.helvetica(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF121212),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, size: screenWidth * 0.045, color: const Color(0xFF121212)), // 17 / 375
                      SizedBox(width: screenWidth * 0.008), // 3 / 375
                      Icon(Icons.wifi, size: screenWidth * 0.04, color: const Color(0xFF121212)), // 15 / 375
                      SizedBox(width: screenWidth * 0.008), // 3 / 375
                      Icon(Icons.battery_full, size: screenWidth * 0.056, color: const Color(0xFF121212)), // 21 / 375
                    ],
                  ),
                ],
              ),
            ),
            // Header
            Container(
              height: 56,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.053), // 20 / 375
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop(); // Using go_router for navigation
                    },
                    child: Container(
                      width: screenWidth * 0.085, // 32 / 375
                      height: screenWidth * 0.085, // 32 / 375
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Figma shows transparent but some designs use white
                      ),
                      child: Icon(Icons.arrow_back, size: screenWidth * 0.05, color: const Color(0xFF121212)), // 16 / 375
                    ),
                  ),
                  // No right icon in this header
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixedBottomBar(BuildContext context, double screenWidth) {
    final double totalPrice = _calculateTotalPrice();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 1,
            color: const Color(0xFFDEE5E4),
          ),
          Container(
            height: 108,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.053, // 20 / 375
              vertical: screenWidth * 0.042, // 16 / 375
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.07,
                            color: const Color(0xFFAAB8B6),
                          ),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(0)}', // Dynamically calculated total
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                            color: const Color(0xFFE29547),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/checkout'); // Using go_router for navigation
                      },
                      child: Container(
                        width: screenWidth * 0.576, // 216 / 375
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF121212),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Proceed to checkout',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.07,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.016), // 6px / 375px
                // Home indicator
                Container(
                  width: screenWidth * 0.357, // 134 / 375
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}