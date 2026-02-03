import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'second.dart';

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
      title: 'Nike Shoes Catalog',
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

  final Map<String, List<Map<String, String>>> shoesData = {
    'All': [
      {'id': '1','name': 'M-#101', 'image': 'assets/images/shoe1.jpg', 'price': '14.00'},  // M1
      {'id': '7','name': 'K-#101', 'image': 'assets/images/shoe7.jpg', 'price': '7.00'},  // K1
      {'id': '2','name': 'M-#102', 'image': 'assets/images/shoe2.jpg', 'price': '15.00'}, // M2
      {'id': '13','name': 'L-#101', 'image': 'assets/images/shoe13.jpg', 'price': '23.00'},  // L1 
      {'id': '14','name': 'L-#102', 'image': 'assets/images/shoe14.jpg', 'price': '19.00'}, // L2
      {'id': '3','name': 'M-#103', 'image': 'assets/images/shoe3.jpg', 'price': '16.00'}, // M3
      {'id': '11','name': 'K-#105', 'image': 'assets/images/shoe11.png', 'price': '4.00'}, //K5
      {'id': '4','name': 'M-#104', 'image': 'assets/images/shoe4.jpg', 'price': '14.00'}, // M4
      {'id': '8','name': 'K-#102', 'image': 'assets/images/shoe8.png', 'price': '5.00'}, // K2
     {'id': '18','name': 'L-#106', 'image': 'assets/images/shoe18.jpg', 'price': '13.00'}, // L6
      {'id': '5','name': 'M-#105', 'image': 'assets/images/shoe5.jpg', 'price': '20.00'}, // M5
      {'id': '15','name': 'L-#103', 'image': 'assets/images/shoe15.jpg', 'price': '10.00'}, // L3
      {'id': '16','name': 'L-#104', 'image': 'assets/images/shoe16.jpg', 'price': '17.00'}, // L4
      {'id': '6','name': 'M-#106', 'image': 'assets/images/shoe6.jpg', 'price': '21.00'}, //M6
      {'id': '17','name': 'L-#105', 'image': 'assets/images/shoe17.jpg', 'price': '20.00'}, // L5
      {'id': '9','name': 'K-#103', 'image': 'assets/images/shoe9.jpg', 'price': '8.00'}, // K3
      {'id': '10','name': 'K-#104', 'image': 'assets/images/shoe10.jpg', 'price': '6.00'}, // K4
      {'id': '12','name': 'K-#106', 'image': 'assets/images/shoe12.jpg', 'price': '9.00'}, //K6


    ],


    'Men': [
      {'id': '1','name': 'M-#101', 'image': 'assets/images/shoe1.jpg', 'price': '14.00'},  // M1
      {'id': '2','name': 'M-#102', 'image': 'assets/images/shoe2.jpg', 'price': '15.00'}, // M2
      {'id': '3','name': 'M-#103', 'image': 'assets/images/shoe3.jpg', 'price': '16.00'}, // M3
      {'id': '4','name': 'M-#104', 'image': 'assets/images/shoe4.jpg', 'price': '14.00'}, // M4
      {'id': '5','name': 'M-#105', 'image': 'assets/images/shoe5.jpg', 'price': '20.00'}, // M5
      {'id': '6','name': 'M-#106', 'image': 'assets/images/shoe6.jpg', 'price': '21.00'}, //M6
      

    ],




    'Women': [

       {'id': '13','name': 'L-#101', 'image': 'assets/images/shoe13.jpg', 'price': '23.00'},  // L1
      {'id': '14','name': 'L-#102', 'image': 'assets/images/shoe14.jpg', 'price': '19.00'}, // L2
      {'id': '15','name': 'L-#103', 'image': 'assets/images/shoe15.jpg', 'price': '10.00'}, // L3
      {'id': '16','name': 'L-#104', 'image': 'assets/images/shoe16.jpg', 'price': '17.00'}, // L4
      {'id': '17','name': 'L-#105', 'image': 'assets/images/shoe17.jpg', 'price': '20.00'}, // L5
      {'id': '18','name': 'L-#106', 'image': 'assets/images/shoe18.jpg', 'price': '13.00'}, // L6

    ],




    'Kids': [

       {'id': '7','name': 'K-#101', 'image': 'assets/images/shoe7.jpg', 'price': '7.00'},  // K1
      {'id': '8','name': 'K-#102', 'image': 'assets/images/shoe8.png', 'price': '5.00'}, // K2
      {'id': '9','name': 'K-#103', 'image': 'assets/images/shoe9.jpg', 'price': '8.00'}, // K3
      {'id': '10','name': 'K-#104', 'image': 'assets/images/shoe10.jpg', 'price': '6.00'}, // K4
      {'id': '11','name': 'K-#105', 'image': 'assets/images/shoe11.png', 'price': '4.00'}, //K5
      {'id': '12','name': 'K-#106', 'image': 'assets/images/shoe12.jpg', 'price': '9.00'}, //K6






    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> getFilteredShoes() {
    return shoesData[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/nike_logo.png',
              height: 28,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.sports_soccer,
                size: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "Nike",
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
          // Search Toggle
          IconButton(
            onPressed: () => setState(() => _showSearch = !_showSearch),
            icon: Icon(
              _showSearch ? Icons.close : Icons.search,
              color: Colors.black,
              size: 24,
            ),
          ),
          // Cart with Badge
          Stack(
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
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
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
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search shoes, brands...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _showSearch = false);
                    },
                  ),
                ),
                onSubmitted: (value) {
                  print('Searching: $value');
                },
              ),
            ),
          // AppBar
          // Body Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          onPressed: () =>
                              setState(() => selectedCategory = 'All'),
                        ),
                        const SizedBox(width: 20),
                        NikeCategoryButton(
                          label: 'Men',
                          onPressed: () =>
                              setState(() => selectedCategory = 'Men'),
                        ),
                        const SizedBox(width: 20),
                        NikeCategoryButton(
                          label: 'Women',
                          onPressed: () =>
                              setState(() => selectedCategory = 'Women'),
                        ),
                        const SizedBox(width: 20),
                        NikeCategoryButton(
                          label: 'Kids',
                          onPressed: () =>
                              setState(() => selectedCategory = 'Kids'),
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
                    child: GridView.builder(
                      itemCount: getFilteredShoes().length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.6),
                      itemBuilder: (context, index) {
                        return ProductCard(shoe: getFilteredShoes()[index]);
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
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
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
              originalPrice: '', // Add original price if needed
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
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < 4 ? Icons.star : Icons.star_border,
                        size: 18,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${shoe['price']}",
                    style: const TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.purple,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
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
  final VoidCallback onPressed;
  const NikeCategoryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(label),
    );
  }
}
