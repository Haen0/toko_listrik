import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'product_card.dart';
import 'cart_page.dart';
import 'notification_page.dart';

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


class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  late Future<List<Product>> futureProducts;

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.18.9/db_toko_listrik/tb_products.php'));

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PENCARIAN',
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'ANDA',
                        style: TextStyle(
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
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 5.0,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 2.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
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
                          // gambarProduk1: product.gambarProduk1, // Menggunakan gambar pertama sebagai gambar utama
                          // namaProduk: product.namaProduk,
                          // kategori: product.kategori,
                          // hargaProduk: product.hargaProduk.toString(),
                          // rate: product.rate.toString(),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
