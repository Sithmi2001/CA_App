import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShoeDetailPage extends StatefulWidget {
  final String shoeName;
  final String shoeImage;
  final String shoePrice;
  final String originalPrice;
  final String shoeDescription;
  final String shoeRating;
  final String shoeId;

  const ShoeDetailPage({
    super.key,
    required this.shoeName,
    required this.shoeImage,
    required this.shoePrice,
    required this.originalPrice,
    required this.shoeDescription,
    required this.shoeRating,
    required this.shoeId,
  });

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  String _selectedSize = 'Size 10';
  String _selectedColor = 'Orange';

  final List<String> _sizes = [
    'Size 8',
    'Size 9',
    'Size 10',
    'Size 11',
    'Size 12'
  ];
  final List<String> _colors = ['Orange', 'Black', 'Blue', 'Red'];

  // Insert item into the Cart in Supabase
  Future<void> addToCart() async {
    try {
      await Supabase.instance.client.from('cart').insert({
        'shoe_id': int.parse(widget.shoeId),
        'name': widget.shoeName,
        'price': double.parse(widget.shoePrice),
        'color': _selectedColor,
        'size': _selectedSize,
      }).select();

      // Success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to Cart ($_selectedSize, $_selectedColor)'),
        ),
      );
    } catch (e) {
      print("Insert Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add to cart'),
        ),
      );
    }
  }

  Color _getColorFromName(String name) {
    switch (name) {
      case 'Black':
        return Colors.black;
      case 'Blue':
        return Colors.blueAccent;
      case 'Red':
        return Colors.redAccent;
      case 'Orange':
      default:
        return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nike',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.black),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
        child: Column(
          children: [
            // TOP CARD + FLOATING SHOE
            SizedBox(
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background card with gradient & dots
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFE0B2), Color(0xFFFF7043)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 24),
                          // Left dotted pattern
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              6,
                              (row) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  children: List.generate(
                                    3,
                                    (col) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      width: 3,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Floating rotated shoe inside a card
                  Positioned(
                    top: 10,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      shadowColor: Colors.black.withOpacity(0.25),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Transform.rotate(
                          angle: -0.10, // adjust tilt here
                          child: Hero(
                            tag: widget.shoeImage,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                widget.shoeImage,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Rating pill
                  Positioned(
                    right: 24,
                    top: 56,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            widget.shoeRating,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // NAME + CATEGORY + FAVORITE / SHARE

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shoeName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Basketball Shoes',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // PRICE + DISCOUNT
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.shoePrice}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '\$${widget.originalPrice}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '25% OFF',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // SIZE + COLOR SELECTORS (DROPDOWNS)
            Row(
              children: [
                // Size dropdown
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSize,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        items: _sizes
                            .map(
                              (size) => DropdownMenuItem<String>(
                                value: size,
                                child: Text(size),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedSize = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Color dropdown
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedColor,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        items: _colors
                            .map(
                              (colorName) => DropdownMenuItem<String>(
                                value: colorName,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: _getColorFromName(colorName),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(colorName),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedColor = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // DESCRIPTION
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.shoeDescription,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // BOTTOM BUTTONS
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: addToCart,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle buying logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Buying Now ($_selectedSize, $_selectedColor)',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
