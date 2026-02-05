import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;
  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  // 1. FETCH CART ITEMS FROM DATABASE
  Future<void> fetchCartItems() async {
    try {
      print("🔄 Fetching cart items from database...");
      
      final response = await _supabase
          .from('cart')
          .select()
          .order('id', ascending: false);

      if (response != null && response is List) {
        print("✅ Received ${response.length} items");
        
        setState(() {
          cartItems = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
        
        print("📋 Items loaded: ${cartItems.map((item) => item['name']).toList()}");
      } else {
        print("⚠️ No items in cart or empty response");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Error fetching cart items: $e");
      setState(() {
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading cart: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 2. DELETE ITEM FROM DATABASE (THIS IS THE FIXED VERSION)
  Future<void> deleteItem(int id) async {
    try {
      print("🗑️ Attempting to delete item with ID: $id");
      
      // Check if item exists before deleting
      final checkResponse = await _supabase
          .from('cart')
          .select('id, name')
          .eq('id', id);
      
      if (checkResponse != null && checkResponse is List && checkResponse.isNotEmpty) {
        final itemName = checkResponse[0]['name'];
        print("📋 Found item to delete: $itemName (ID: $id)");
        
        // Perform the delete operation
        final deleteResponse = await _supabase
            .from('cart')
            .delete()
            .eq('id', id);
        
        print("✅ Delete operation completed");
        
        // Remove from local list
        setState(() {
          cartItems.removeWhere((item) => item['id'] == id);
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"$itemName" removed from cart'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Optional: Verify deletion
        final verifyResponse = await _supabase
            .from('cart')
            .select('id')
            .eq('id', id);
        
        if (verifyResponse is List && verifyResponse.isEmpty) {
          print("✅ Verified: Item deleted from database");
        }
      } else {
        print("⚠️ Item not found in database, removing from UI only");
        setState(() {
          cartItems.removeWhere((item) => item['id'] == id);
        });
      }
    } catch (e) {
      print("❌ Error deleting item: $e");
      print("Full error: ${e.toString()}");
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 3. UPDATE QUANTITY IN DATABASE
  Future<void> updateQuantity(int id, int newQuantity) async {
    try {
      print("📝 Updating quantity for ID $id to $newQuantity");
      
      if (newQuantity <= 0) {
        await deleteItem(id);
        return;
      }
      
      await _supabase
          .from('cart')
          .update({'quantity': newQuantity})
          .eq('id', id);
      
      print("✅ Quantity updated in database");
      
      // Update local data
      setState(() {
        final index = cartItems.indexWhere((item) => item['id'] == id);
        if (index != -1) {
          cartItems[index]['quantity'] = newQuantity;
        }
      });
    } catch (e) {
      print("❌ Error updating quantity: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update failed: $e'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  // 4. GET IMAGE FOR SHOE PRODUCT
  String? getImageForShoe(String name) {
    if (name.contains('M-#101')) return 'assets/images/shoe1.jpg';
    if (name.contains('M-#102')) return 'assets/images/shoe2.jpg';
    if (name.contains('M-#103')) return 'assets/images/shoe3.jpg';
    if (name.contains('M-#104')) return 'assets/images/shoe4.jpg';
    if (name.contains('M-#105')) return 'assets/images/shoe5.jpg';
    if (name.contains('M-#106')) return 'assets/images/shoe6.jpg';
    if (name.contains('K-#101')) return 'assets/images/shoe7.jpg';
    if (name.contains('K-#102')) return 'assets/images/shoe8.png';
    if (name.contains('K-#103')) return 'assets/images/shoe9.jpg';
    if (name.contains('K-#104')) return 'assets/images/shoe10.jpg';
    if (name.contains('K-#105')) return 'assets/images/shoe11.png';
    if (name.contains('K-#106')) return 'assets/images/shoe12.jpg';
    if (name.contains('L-#101')) return 'assets/images/shoe13.jpg';
    if (name.contains('L-#102')) return 'assets/images/shoe14.jpg';
    if (name.contains('L-#103')) return 'assets/images/shoe15.jpg';
    if (name.contains('L-#104')) return 'assets/images/shoe16.jpg';
    if (name.contains('L-#105')) return 'assets/images/shoe17.jpg';
    if (name.contains('L-#106')) return 'assets/images/shoe18.jpg';
    
    // Default images
    if (name.contains('M-#')) return 'assets/images/shoe1.jpg';
    if (name.contains('K-#')) return 'assets/images/shoe7.jpg';
    if (name.contains('L-#')) return 'assets/images/shoe13.jpg';
    
    return 'assets/images/shoe1.jpg';
  }

  // 5. CALCULATE SUBTOTAL
  double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      final price = double.tryParse(item['price'].toString()) ?? 0.0;
      final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
      total += price * quantity;
    }
    return total;
  }

  double get shipping => 49.0; // Fixed shipping cost
  double get totalAmount => subtotal + shipping;

  // 6. EDIT QUANTITY DIALOG
  void showEditDialog(Map<String, dynamic> item) {
    final TextEditingController controller = TextEditingController();
    final currentQuantity = int.tryParse(item['quantity'].toString()) ?? 1;
    controller.text = currentQuantity.toString();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Quantity'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newQtyText = controller.text.trim();
                if (newQtyText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a quantity'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                final newQty = int.tryParse(newQtyText);
                if (newQty == null || newQty <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid quantity (1 or more)'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                await updateQuantity(item['id'], newQty);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Update', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 7. DELETE CONFIRMATION DIALOG
  void showDeleteDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: Text('Are you sure you want to remove "${item['name']}" from your cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                deleteItem(item['id']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Remove', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 8. BUILD CART ITEM WIDGET
  Widget _buildCartItem(Map<String, dynamic> item) {
    final price = double.tryParse(item['price'].toString()) ?? 0.0;
    final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
    final totalPrice = price * quantity;
    final image = getImageForShoe(item['name']?.toString() ?? '');
    final productName = item['name']?.toString() ?? 'Unknown Product';
    final color = item['color']?.toString() ?? 'Black';
    final size = item['size']?.toString() ?? 'Size 10';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.grey[100],
              child: image != null
                  ? Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.shopping_bag, color: Colors.grey),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.shopping_bag, color: Colors.grey),
                    ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$color • $size',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        if (quantity > 1)
                          Text(
                            'Total: \$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),

                    // Quantity Controls
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            onPressed: () {
                              updateQuantity(item['id'], quantity - 1);
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                            splashRadius: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: () {
                              updateQuantity(item['id'], quantity + 1);
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                            splashRadius: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Column(
            children: [
              // Edit Button
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => showEditDialog(item),
                tooltip: 'Edit quantity',
              ),
              
              // Delete Button
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => showDeleteDialog(item),
                tooltip: 'Remove item',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 9. BUILD SUMMARY ROW
  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // 10. BUILD TOTAL ROW
  Widget _buildTotalRow(String label, double amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // 11. LOADING SCREEN
  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Loading your cart...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 12. EMPTY SCREEN
  Widget _buildEmptyScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
              ),
              child: const Text(
                'Continue Shopping',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 13. MAIN BUILD METHOD
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingScreen();
    }

    if (cartItems.isEmpty) {
      return _buildEmptyScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: fetchCartItems,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with total items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Items',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${cartItems.length} Items',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Cart Items List
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(cartItems[index]);
              },
            ),
          ),

          // Order Summary
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Subtotal
                _buildSummaryRow('Sub Total', subtotal),
                const SizedBox(height: 12),
                // Shipping
                _buildSummaryRow('Shipping', shipping),
                const SizedBox(height: 20),
                // Total Amount
                _buildTotalRow('Total Amount', totalAmount),
                const SizedBox(height: 24),
                // Checkout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Proceeding to checkout...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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