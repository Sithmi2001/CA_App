import 'package:ca_app_new/cart.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'second.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zgmgxmuxltrfjslovbgp.supabase.co',
    anonKey: 'sb_publishable_7aV92sgTyYX7sI0qRm_yIA_v4qpUBDk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoes Catalog',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All'; // Default category

  String searchQuery = ''; // store search query

  final Map<String, List<Map<String, String>>> shoesData = {
    'All': [
      {
        'id': '1',
        'name': 'M-#101',
        'image': 'assets/images/shoe1.jpg',
        'price': '14.00',
        'category': 'Men'
      }, // M1
      
      {
        'id': '2',
        'name': 'M-#102',
        'image': 'assets/images/shoe2.jpg',
        'price': '15.00',
        'category': 'Men'
      }, // M2
      {
        'id': '7',
        'name': 'K-#101',
        'image': 'assets/images/shoe7.jpg',
        'price': '7.00',
        'category': 'Kids'
      }, // K1
      {
        'id': '13',
        'name': 'L-#101',
        'image': 'assets/images/shoe13.jpg',
        'price': '23.00',
        'category': 'Women'
      }, // L1
      {
        'id': '14',
        'name': 'L-#102',
        'image': 'assets/images/shoe14.jpg',
        'price': '19.00',
        'category': 'Women'
      }, // L2
      {
        'id': '3',
        'name': 'M-#103',
        'image': 'assets/images/shoe3.jpg',
        'price': '16.00',
        'category': 'Men'
      }, // M3
      {
        'id': '11',
        'name': 'K-#105',
        'image': 'assets/images/shoe11.png',
        'price': '4.00',
        'category': 'Kids'
      }, //K5
      {
        'id': '4',
        'name': 'M-#104',
        'image': 'assets/images/shoe4.jpg',
        'price': '14.00',
        'category': 'Men'
      }, // M4
      {
        'id': '8',
        'name': 'K-#102',
        'image': 'assets/images/shoe8.png',
        'price': '5.00',
        'category': 'Kids'
      }, // K2
      {
        'id': '18',
        'name': 'L-#106',
        'image': 'assets/images/shoe18.jpg',
        'price': '13.00',
        'category': 'Women'
      }, // L6
      {
        'id': '5',
        'name': 'M-#105',
        'image': 'assets/images/shoe5.jpg',
        'price': '20.00',
        'category': 'Men'
      }, // M5
      {
        'id': '15',
        'name': 'L-#103',
        'image': 'assets/images/shoe15.jpg',
        'price': '10.00',
        'category': 'Women'
      }, // L3
      {
        'id': '16',
        'name': 'L-#104',
        'image': 'assets/images/shoe16.jpg',
        'price': '17.00',
        'category': 'Women'
      }, // L4
      {
        'id': '6',
        'name': 'M-#106',
        'image': 'assets/images/shoe6.jpg',
        'price': '21.00',
        'category': 'Men'
      }, //M6
      {
        'id': '17',
        'name': 'L-#105',
        'image': 'assets/images/shoe17.jpg',
        'price': '20.00',
        'category': 'Women'
      }, // L5
      {
        'id': '9',
        'name': 'K-#103',
        'image': 'assets/images/shoe9.jpg',
        'price': '8.00',
        'category': 'Kids'
      }, // K3
      {
        'id': '10',
        'name': 'K-#104',
        'image': 'assets/images/shoe10.jpg',
        'price': '6.00',
        'category': 'Kids'
      }, // K4
      {
        'id': '12',
        'name': 'K-#106',
        'image': 'assets/images/shoe12.jpg',
        'price': '9.00',
        'category': 'Kids'
      }, //K6
    ],
    'Men': [
      {
        'id': '1',
        'name': 'M-#101',
        'image': 'assets/images/shoe1.jpg',
        'price': '14.00',
        'category': 'Men'
      }, // M1
      {
        'id': '2',
        'name': 'M-#102',
        'image': 'assets/images/shoe2.jpg',
        'price': '15.00',
        'category': 'Men'
      }, // M2
      {
        'id': '3',
        'name': 'M-#103',
        'image': 'assets/images/shoe3.jpg',
        'price': '16.00',
        'category': 'Men'
      }, // M3
      {
        'id': '4',
        'name': 'M-#104',
        'image': 'assets/images/shoe4.jpg',
        'price': '14.00',
        'category': 'Men'
      }, // M4
      {
        'id': '5',
        'name': 'M-#105',
        'image': 'assets/images/shoe5.jpg',
        'price': '20.00',
        'category': 'Men'
      }, // M5
      {
        'id': '6',
        'name': 'M-#106',
        'image': 'assets/images/shoe6.jpg',
        'price': '21.00',
        'category': 'Men'
      }, //M6
    ],
    'Women': [
      {
        'id': '13',
        'name': 'L-#101',
        'image': 'assets/images/shoe13.jpg',
        'price': '23.00',
        'category': 'Women'
      }, // L1
      {
        'id': '14',
        'name': 'L-#102',
        'image': 'assets/images/shoe14.jpg',
        'price': '19.00',
        'category': 'Women'
      }, // L2
      {
        'id': '15',
        'name': 'L-#103',
        'image': 'assets/images/shoe15.jpg',
        'price': '10.00',
        'category': 'Women'
      }, // L3
      {
        'id': '16',
        'name': 'L-#104',
        'image': 'assets/images/shoe16.jpg',
        'price': '17.00',
        'category': 'Women'
      }, // L4
      {
        'id': '17',
        'name': 'L-#105',
        'image': 'assets/images/shoe17.jpg',
        'price': '20.00',
        'category': 'Women'
      }, // L5
      {
        'id': '18',
        'name': 'L-#106',
        'image': 'assets/images/shoe18.jpg',
        'price': '13.00',
        'category': 'Women'
      }, // L6
    ],
    'Kids': [
      {
        'id': '7',
        'name': 'K-#101',
        'image': 'assets/images/shoe7.jpg',
        'price': '7.00',
        'category': 'Kids'
      }, // K1
      {
        'id': '8',
        'name': 'K-#102',
        'image': 'assets/images/shoe8.png',
        'price': '5.00',
        'category': 'Kids'
      }, // K2
      {
        'id': '9',
        'name': 'K-#103',
        'image': 'assets/images/shoe9.jpg',
        'price': '8.00',
        'category': 'Kids'
      }, // K3
      {
        'id': '10',
        'name': 'K-#104',
        'image': 'assets/images/shoe10.jpg',
        'price': '6.00',
        'category': 'Kids'
      }, // K4
      {
        'id': '11',
        'name': 'K-#105',
        'image': 'assets/images/shoe11.png',
        'price': '4.00',
        'category': 'Kids'
      }, //K5
      {
        'id': '12',
        'name': 'K-#106',
        'image': 'assets/images/shoe12.jpg',
        'price': '9.00',
        'category': 'Kids'
      }, //K6
    ],
  };

  Future<int> _getCartCount() async {
    try {
      final response = await Supabase.instance.client
          .from('cart')
          .select()
          .count(CountOption.exact); // Simplified count method

      return response.count ?? 0;
    } catch (e) {
      print("Error getting cart count: $e");
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    // NEW: Added listener for real-time search
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // NEW: UPDATED GET FILTERED SHOES WITH SEARCH FUNCTIONALITY
  List<Map<String, String>> getFilteredShoes() {
    List<Map<String, String>> categoryShoes = shoesData[selectedCategory] ?? [];

    // If search is empty, return all shoes in category
    if (searchQuery.isEmpty) {
      return categoryShoes;
    }

    // Filter by search query
    return categoryShoes.where((shoe) {
      final name = shoe['name']?.toLowerCase() ?? '';
      final price = shoe['price']?.toLowerCase() ?? '';
      final category = shoe['category']?.toLowerCase() ?? '';

      // Search in name, price, and category
      return name.contains(searchQuery) ||
          price.contains(searchQuery) ||
          category.contains(searchQuery) ||
          searchQuery.contains('men') && category.contains('men') ||
          searchQuery.contains('women') && category.contains('women') ||
          searchQuery.contains('kid') && category.contains('kid') ||
          searchQuery.contains('shoe') ||
          searchQuery.contains('nike') ||
          searchQuery.contains('sneaker') ||
          searchQuery.contains('sport');
    }).toList();
  }

  // NEW: CLEAR SEARCH FUNCTION
  void _clearSearch() {
    _searchController.clear();
    setState(() {
      searchQuery = '';
      _showSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredShoes = getFilteredShoes();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/shoe_logo.png',
              height: 28,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.sports_soccer,
                size: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "SHOE PALACE",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey[50]!],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
        actions: [
          // Search Toggle - UPDATED with clear functionality
          IconButton(
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) {
                  _clearSearch();
                }
              });
            },
            icon: Icon(
              _showSearch ? Icons.close : Icons.search,
              color: Colors.black,
              size: 24,
            ),
          ),
          // Cart Icon (unchanged)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
            borderRadius: BorderRadius.circular(100),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.orange,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: FutureBuilder(
                        future: _getCartCount(),
                        builder: (context, snapshot) {
                          final count = snapshot.data ?? 0;
                          return Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Expandable Search Bar
          if (_showSearch)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search shoes, brands, categories...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        // Search updates automatically via listener
                      },
                      onSubmitted: (value) {
                        print('Searching for: $value');
                      },
                    ),
                  ),
                  // NEW: Clear button appears when typing
                  if (searchQuery.isNotEmpty)
                    IconButton(
                      icon:
                          const Icon(Icons.clear, color: Colors.grey, size: 20),
                      onPressed: _clearSearch,
                    ),
                ],
              ),
            ),

          // NEW: SEARCH RESULTS INFO BAR
          if (searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search results for "$searchQuery"',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${filteredShoes.length} items found',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (searchQuery.isEmpty)
                  // Banner
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      height: 170,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/nike_banner.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                // NEW: Conditional category buttons
                if (searchQuery.isEmpty || selectedCategory == 'All')
                  // Category Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NikeCategoryButton(
                            label: 'All',
                            isSelected: selectedCategory == 'All',
                            onPressed: () {
                              setState(() => selectedCategory = 'All');
                              _searchController.clear();
                            },
                          ),
                          const SizedBox(width: 40),
                          NikeCategoryButton(
                            label: 'Men',
                            isSelected: selectedCategory == 'Men',
                            onPressed: () {
                              setState(() => selectedCategory = 'Men');
                              _searchController.clear();
                            },
                          ),
                          const SizedBox(width: 40),
                          NikeCategoryButton(
                            label: 'Women',
                            isSelected: selectedCategory == 'Women',
                            onPressed: () {
                              setState(() => selectedCategory = 'Women');
                              _searchController.clear();
                            },
                          ),
                          const SizedBox(width: 40),
                          NikeCategoryButton(
                            label: 'Kids',
                            isSelected: selectedCategory == 'Kids',
                            onPressed: () {
                              setState(() => selectedCategory = 'Kids');
                              _searchController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                // Product Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: filteredShoes.isEmpty
                        ? _buildNoResultsWidget(
                            searchQuery) // Fixed: called as function
                        : GridView.builder(
                            itemCount: filteredShoes.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 0.7),
                            itemBuilder: (context, index) {
                              return ProductCard(shoe: filteredShoes[index]);
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            // Profile is index 2
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget _buildNoResultsWidget(String searchQuery) {
  VoidCallback? _clearSearch;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          size: 80,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 20),
        Text(
          'No results found for "$searchQuery"',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'Try searching for:\n• M-#101, K-#101, L-#101\n• Men, Women, Kids\n• Price like 14.00, 20.00',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _clearSearch, // This will use the class method
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: const Text(
            'Clear Search',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

class ProductCard extends StatelessWidget {
  final Map<String, String> shoe; // Accept shoe data
  const ProductCard({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShoeDetailPage(
              shoeName: shoe['name']!,
              shoeImage: shoe['image']!,
              shoePrice: shoe['price']!,
              shoeDescription: 'This is a description of the shoe.',
              originalPrice:
                  '${(double.parse(shoe['price']!) * 1.25).toStringAsFixed(2)}', // Add original price if needed
              shoeRating: '4.5', // Add shoe rating if needed
              shoeId: shoe['id']!, // Pass the shoe id
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // MISSING: Changed from Column
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                shoe['image']!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 120,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shoe['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // MISSING: Updated rating row with category
                  Row(
                    children: [
                      // Rating stars
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < 4 ? Icons.star : Icons.star_border,
                            size: 16, // Reduced size
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.5',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Spacer(), // MISSING: Added spacer
                      // MISSING: Category tag
                      Text(
                        shoe['category'] ?? 'Shoes',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // MISSING: Added more spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${shoe['price']}",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 18, // Increased size
                          fontWeight: FontWeight.w700, // Made bolder
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                              size: 20, // Reduced size
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.purple,
                              size: 20, // Reduced size
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NikeCategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  final VoidCallback onPressed;

  const NikeCategoryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // NEW: Different styles for selected vs unselected
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: isSelected ? 4 : 0,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
