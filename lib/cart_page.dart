import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'checkout_page_cart.dart';
import 'package:http/http.dart' as http;

class Product {
  final String imageUrl;
  final String name;
  final double price;
  final int id; // Tambahkan id produk
  int quantity;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.id,
    this.quantity = 1,
  });
}

final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Product> products = []; // List kosong untuk menyimpan produk dari database

   // Metode untuk mengambil data produk dari API
  Future<void> fetchCartItems() async {
    final url = Uri.parse('http://192.168.56.1/db_toko_listrik/tb_keranjang.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse JSON response
      List<dynamic> data = jsonDecode(response.body);

      // Map JSON data to Product objects
      setState(() {
        products = data.map((item) {
          // Handle null values gracefully
          String imageUrl = item['gambar_produk_1'] ?? '';
          String name = item['nama_produk'] ?? '';
          double price = double.tryParse(item['harga_produk'] ?? '0.0') ?? 0.0;
          int id = int.tryParse(item['id_produk'] ?? '0') ?? 0;
          int quantity = int.tryParse(item['quantity'].toString() ?? '0') ?? 0;

          return Product(
            imageUrl: imageUrl,
            name: name,
            price: price,
            id: id,
            quantity: quantity,
          );
        }).toList();
      });
    } else {
      // Handle HTTP error
      throw Exception('Failed to load cart items');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems(); // Panggil metode fetchCartItems saat initState
  }

  Future<void> deleteCartItem(int productId) async {
    final url = Uri.parse('http://192.168.56.1/db_toko_listrik/hapus_dikeranjang.php');
    final response = await http.post(url, body: {'product_id': productId.toString()});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == null) {
        // Penghapusan berhasil
        setState(() {
          products.removeWhere((product) => product.id == productId);
        });
      } else {
        // Tampilkan pesan error dari server
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(data['error']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Handle HTTP error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Gagal terhubung ke server'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();
    int totalItems = calculateTotalItems();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Keranjang'),
            backgroundColor: Colors.white,
            floating: true, // Mengatur SliverAppBar agar muncul saat digulir ke atas
            pinned: true, // Menyematkan SliverAppBar di bagian atas
            snap: false, // Jika true, SliverAppBar akan langsung muncul saat digulir ke atas
            centerTitle: true, // Memusatkan title di tengah
            leading: IconButton(
              icon: Icon(IconsaxPlusLinear.arrow_left_3, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildCartItem(products[index]);
              },
              childCount: products.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(-2, 2),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total: ${formatCurrency.format(totalPrice)}',
                      style: TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Total Items: $totalItems',
                      style: TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol checkout ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600], // Warna latar belakang tombol
                    foregroundColor: Colors.white, // Warna teks tombol
                    shadowColor: Colors.grey[100], // Warna bayangan tombol
                    elevation: 5, // Ketinggian bayangan tombol
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Sudut tombol
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white), // Warna teks tombol
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget buildCartItem(Product product) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    product.imageUrl,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        maxLines: 1,  // Maksimum satu baris
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '${formatCurrency.format(product.price)}',
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(IconsaxPlusLinear.minus, size: 16.0,),
                            onPressed: () {
                              setState(() {
                                if (product.quantity > 1) {
                                  product.quantity--;
                                }
                              });
                            },
                          ),
                          Text(
                            product.quantity.toString(),
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(IconsaxPlusLinear.add, size: 16.0,),
                            onPressed: () {
                              setState(() {
                                product.quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(IconsaxPlusBold.trash, size: 18.0,),
                      color: Colors.red,
                      onPressed: () {
                        // Menampilkan dialog loading
                        showDialog(
                          context: context,
                          barrierDismissible: false, // dialog tidak bisa ditutup dengan tap di luar
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Row(
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20.0),
                                  Text("Menghapus..."),
                                ],
                              ),
                            );
                          },
                        );

                        deleteCartItem(product.id).then((_) {
                          Navigator.of(context).pop(); // Menutup dialog setelah proses selesai
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
          height: 3.0,
          indent: 50.0,
          endIndent: 50.0,
        ),
      ],
    );
  }
  
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var product in products) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  int calculateTotalItems() {
    int totalItems = 0;
    for (var product in products) {
      totalItems += product.quantity;
    }
    return totalItems;
  }
}
