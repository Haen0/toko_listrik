import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'product_card.dart';
import 'search_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart_page.dart';
import 'notification_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final int idProduk;
  final String namaPenjual;
  final String namaProduk;
  final String namaToko;
  final String kategori;
  final int hargaProduk;
  final String descProduk;
  final String gambarProduk1;
  final String gambarProduk2;
  final String gambarProduk3;
  final String gambarProduk4;
  final String gambarProduk5;
  final int stokProduk;
  final double rate;

  Product({
    required this.idProduk,
    required this.namaPenjual,
    required this.namaProduk,
    required this.namaToko,
    required this.kategori,
    required this.hargaProduk,
    required this.descProduk,
    required this.gambarProduk1,
    required this.gambarProduk2,
    required this.gambarProduk3,
    required this.gambarProduk4,
    required this.gambarProduk5,
    required this.stokProduk,
    required this.rate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProduk: int.parse(json['id_produk']),
      namaPenjual: json['nama_penjual'],
      namaProduk: json['nama_produk'] ?? '',
      namaToko: json['nama_toko'] ?? '',
      kategori: json['kategori'] ?? '',
      hargaProduk: int.parse(json['harga_produk']),
      descProduk: json['desc_produk'] ?? '',
      gambarProduk1: json['gambar_produk_1'] ?? '',
      gambarProduk2: json['gambar_produk_2'] ?? '',
      gambarProduk3: json['gambar_produk_3'] ?? '',
      gambarProduk4: json['gambar_produk_4'] ?? '',
      gambarProduk5: json['gambar_produk_5'] ?? '',
      stokProduk: int.parse(json['stok_produk']),
      rate: json['rate'] != null ? double.parse(json['rate']) : 0.0,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late Future<List<Product>> futureProducts;

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.56.1/db_toko_listrik/tb_products.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    List<String> bannerImages = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png'
    ]; // Variabel untuk melacak halaman saat ini
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 70.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row( // Using Row to display price and rate in the same line
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Set cross axis alignment to start
                    children: [
                      Text(
                        'Selamat datang',
                        style: const TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Farhan',
                        style: const TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                          );
                        },
                        child: const Icon(
                          IconsaxPlusLinear.shopping_cart,
                          size: 25.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationsPage()),
                          );
                        },
                        child: const Icon(
                          IconsaxPlusLinear.notification,
                          size: 25.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 5.0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Icon(IconsaxPlusLinear.search_normal_1, size: 20.0, color: Colors.black),
                      SizedBox(width: 16.0),
                      Text(
                        'Cari apa hari ini...',
                        style: TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 200.0, // Height of the carousel
                child: CarouselSlider.builder(
                  itemCount: bannerImages.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.75, // Visible fraction of the next item
                    aspectRatio: 16/9, // Aspect ratio of each item (width/height)
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 5), // Interval between auto play animation
                    autoPlayAnimationDuration: Duration(milliseconds: 1000), // Animation duration
                    scrollPhysics: BouncingScrollPhysics(), // Optional: Physics for the carousel
                  ),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        child: AspectRatio(
                          aspectRatio: 16/9, // Ensure 16:9 aspect ratio
                          child: Image.asset(
                            bannerImages[index],
                            fit: BoxFit.cover, // Cover the container while maintaining aspect ratio
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Set cross axis alignment to start
                children: <Widget>[
                  Text(
                    'Mungkin\nyang anda suka',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
            sliver: FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('No products found')),
                  );
                } else {
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.8,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = snapshot.data![index];
                        return ProductCard(
                          idProduk: product.idProduk,
                          namaPenjual: product.namaPenjual,
                          namaProduk: product.namaProduk,
                          namaToko: product.namaToko,
                          kategori: product.kategori,
                          hargaProduk: product.hargaProduk,
                          descProduk: product.descProduk,
                          gambarProduk1: product.gambarProduk1,
                          gambarProduk2: product.gambarProduk2,
                          gambarProduk3: product.gambarProduk3,
                          gambarProduk4: product.gambarProduk4,
                          gambarProduk5: product.gambarProduk5,
                          stokProduk: product.stokProduk,
                          rate: product.rate,
                          // image_url: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                          // name: 'Product apa ajah toko listrik ke sekian kalinya - $index',
                          // category: 'Hehe',
                          // price: '100.000',
                          // rate: '0',
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                }
              },
            ),
          //   padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
          //   sliver:  SliverGrid(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       mainAxisSpacing: 5,
          //       crossAxisSpacing: 15,
          //       childAspectRatio: 2 / 3.22,
          //     ),
          //     delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         return ProductCard(
          //           idProduk: 'product.idProduk',
          //           idPenjual: 'product.idPenjual',
          //           namaProduk: 'product.namaProduk',
          //           kategori: 'product.kategori',
          //           hargaProduk: 'product.hargaProduk',
          //           descProduk: 'product.descProduk',
          //           gambarProduk1: 'product.gambarProduk1',
          //           gambarProduk2: 'product.gambarProduk2',
          //           gambarProduk3: 'product.gambarProduk3',
          //           gambarProduk4: 'product.gambarProduk4',
          //           gambarProduk5: 'product.gambarProduk5',
          //           stokProduk: 'product.stokProduk',
          //           rate: 'product.rate',
          //           // image_url: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          //           // name: 'Product apa ajah toko listrik ke sekian kalinya - $index',
          //           // category: 'Hehe',
          //           // price: '100.000',
          //           // rate: '0',
          //         );
          //       },
          //       childCount: 20,
          //     ),
          //   ),
          ),
        ],
      ),
    );
  }
}
