// import 'package:flutter/material.dart';
// import 'package:toko_listrik/models/product_model.dart'; // Ganti dengan path yang benar

// class ProductDetailPage extends StatelessWidget {
//   final Product product;

//   ProductDetailPage({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         backgroundColor: Colors.white,
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Image.network(product.imageUrl, height: 250, fit: BoxFit.cover),
//             SizedBox(height: 16.0),
//             Text(
//               product.name,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               product.category,
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'Price: Rp${product.price}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'Rating: ${product.rate}/5',
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             SizedBox(height: 16.0),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:toko_listrik/checkout_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
// class ProductDetailPage extends StatefulWidget {
//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   int _selectedImageIndex = 0;

//   final List<String> _productImages = [
//     'assets/images/contoh_1.jpg',
//     'assets/images/contoh_2.jpg',
//     'assets/images/contoh_3.jpg',
//     'assets/images/contoh_4.jpg',
//     'assets/images/contoh_1.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             title: Text('Detail Produk'),
//             backgroundColor: Colors.white,
//             floating: true, // Mengatur SliverAppBar agar muncul saat digulir ke atas
//             pinned: true, // Menyematkan SliverAppBar di bagian atas
//             snap: false, // Jika true, SliverAppBar akan langsung muncul saat digulir ke atas
//             centerTitle: true, // Memusatkan title di tengah
//             leading: IconButton(
//               icon: Icon(IconsaxPlusLinear.arrow_left_3, color: Colors.black),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             // Menyesuaikan atribut lainnya seperti elevation, brightness, dll.
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 _buildImageSection(),
//                 _buildProductInfo(),
//                 _buildProductDescription(),
//                 _buildActionButtons(),
//                 _buildCustomerReviews(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageSection() {
//     return Column(
//       children: [
//         Container(
//           height: 300,
//           color: Colors.transparent,
//           child: Image.asset(
//             _productImages[_selectedImageIndex],
//             fit: BoxFit.cover,
//           ),
//         ),
//         SizedBox(height: 10),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: List.generate(_productImages.length, (index) {
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedImageIndex = index;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 5),
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: _selectedImageIndex == index ? Colors.blue : Colors.transparent,
//                     ),
//                   ),
//                   child: Image.asset(
//                     _productImages[index],
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProductInfo() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Lampu apa ngga tau saya juga', style: TextStyle(fontFamily: 'CustomFont', fontSize: 24, fontWeight: FontWeight.w600)),
//           SizedBox(height: 10),
//           Text('Lampu Smart', style: TextStyle(fontFamily: 'CustomFont', fontSize: 16)),
//           SizedBox(height: 10),
//           Row(
//             children: [
//               Icon(IconsaxPlusBold.star, color: Colors.orange, size: 20),
//               SizedBox(width: 5),
//               Text('4.5 (200 Reviews)', style: TextStyle(fontFamily: 'CustomFont', fontSize: 16)),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text('\Rp299.000.000', style: TextStyle(fontFamily: 'CustomFont', fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
//           SizedBox(height: 10),
//           Text('Stok: 99', style: TextStyle(fontFamily: 'CustomFont', fontSize: 16)),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductDescription() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Deskripsi', style: TextStyle(fontFamily: 'CustomFont', fontSize: 18, fontWeight: FontWeight.w600)),
//           SizedBox(height: 10),
//           Text(
//             'This rechargeable folding desk lamp and reading light from Auraglow has versatile design to take pride of place on any desk or wall. You can fold the adjustable arms into many different shapes and angle the light exactly where you need it.',
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               // Implement buy now functionality
//             },
//             child: Text('Beli Sekarang', style: TextStyle(fontFamily: 'CustomFont',),),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Implement add to cart functionality
//             },
//             child: Text('Masukan Keranjang', style: TextStyle(fontFamily: 'CustomFont',),),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCustomerReviews() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Review', style: TextStyle(fontFamily: 'CustomFont', fontSize: 18, fontWeight: FontWeight.w600)),
//           SizedBox(height: 10),
//           _buildReviewItem('Saya_Kayaknya', 'HAHAHAHHAHHA HEHEHHEHHEHHE HIHIHIH HUHUH', 5),
//           _buildReviewItem('Kayaknya_Kamu', 'Asd Dasdasd asd asdasod adasdasdadk daskd aksdasda sd a', 4),
//           _buildReviewItem('Inisih_Saya', 'aaaskdadkskas asd kask kksdkasd asdkaksd kaksdakkk', 3),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewItem(String reviewer, String review, int rating) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(reviewer, style: TextStyle(fontFamily: 'CustomFont', fontSize: 16, fontWeight: FontWeight.w600)),
//           SizedBox(height: 5),
//           Row(
//             children: List.generate(rating, (index) => Icon(Icons.star, color: Colors.orange, size: 20)),
//           ),
//           SizedBox(height: 5),
//           Text(review, style: TextStyle(fontFamily: 'CustomFont', fontSize: 16)),
//           Divider(),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ProductDetailPage(),
//   ));
// }


class ProductDetailPage extends StatefulWidget {
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

  ProductDetailPage({
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

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}


class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedImageIndex = 0;

  late List<String> _productImages;

  @override
  void initState() {
    super.initState();
    _productImages = [
      widget.gambarProduk1,
      widget.gambarProduk2,
      widget.gambarProduk3,
      widget.gambarProduk4,
      widget.gambarProduk5,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Detail Produk'),
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(IconsaxPlusLinear.arrow_left_3, color: Colors.black), // Mengganti ikon dengan panah kembali bawaan Flutter
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildImageSection(),
                _buildProductInfo(),
                _buildProductDescription(),
                _buildActionButtons(),
                _buildCustomerReviews(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart() async {
    // Simpan ke dalam keranjang belanja (implementasi berbasis API)
    try {
      // Panggil API untuk menyimpan ke keranjang
      // Misal menggunakan http package atau package lain sesuai kebutuhan
      final response = await http.post(
        Uri.parse('http://192.168.56.1/db_toko_listrik/tambah_kekeranjang.php'), // Ganti dengan URL endpoint API Anda
        body: {
          'id_pembeli': '1', // Ganti dengan id pembeli yang sesuai
          'id_produk': widget.idProduk.toString(), // Mengambil id_produk dari widget
          'quantity': '1', // Misalnya, sementara hardcode quantity 1, bisa disesuaikan dengan input pengguna
        },
      );

      if (response.statusCode == 200) {
        // Implementasi sukses
        // Tampilkan pesan sukses atau lakukan navigasi atau update UI sesuai kebutuhan
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Produk ditambahkan ke keranjang'),
          duration: Duration(seconds: 2),
        ));
      } else {
        // Gagal menyimpan ke keranjang
        // Tampilkan pesan atau notifikasi ke pengguna
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menambahkan produk ke keranjang'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      // Tangani error jika ada
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan. Silakan coba lagi nanti.'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

  Widget _buildImageSection() {
    return Column(
      children: [
        Container(
          height: 300,
          color: Colors.transparent,
          child: Image.asset(
            _productImages[_selectedImageIndex],
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_productImages.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedImageIndex == index ? Colors.blue : Colors.transparent,
                    ),
                  ),
                  child: Image.asset(
                    _productImages[index],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.namaProduk,
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 24, fontWeight: FontWeight.w600),
          ),
          // SizedBox(height: 10),
          Text(
            widget.kategori,
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 16),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              SizedBox(width: 5),
              Text(
                '${widget.rate} (0 Reviews)', // Menggunakan widget.rate untuk menampilkan rating produk
                style: TextStyle(fontFamily: 'CustomFont', fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Rp${formatCurrency.format(widget.hargaProduk)}', // Menggunakan widget.price untuk menampilkan harga produk
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blueGrey),
          ),
          SizedBox(height: 10),
          Text(
            '${widget.stokProduk} Stok', // Tetapkan nilai stok sesuai dengan data produk yang diterima
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDescription() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.namaToko,
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            widget.namaPenjual,
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          Text(
            'Deskripsi',
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Text(
            widget.descProduk, // Sesuaikan dengan deskripsi produk yang diterima
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color(0xff526D82), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Rounded corners
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                    idProduk: widget.idProduk,
                    namaProduk: widget.namaProduk,
                    namaPenjual:  widget.namaPenjual,
                    namaToko: widget.namaToko,
                    hargaProduk: widget.hargaProduk,
                    gambarProduk1: widget.gambarProduk1
                    // detailProduk: DetailProduk,
                  ),
                ),
              );
              // Implement buy now functionality
            },
            child: Text(
              'Beli Sekarang',
              style: TextStyle(fontFamily: 'CustomFont', color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color(0xff526D82), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Rounded corners
              ),
            ),
            onPressed: _addToCart,
            child: Text(
              'Masukan Keranjang',
              style: TextStyle(fontFamily: 'CustomFont', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerReviews() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review',
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          _buildReviewItem('Saya_Kayaknya', 'HAHAHAHHAHHA HEHEHHEHHEHHE HIHIHIH HUHUH', 5),
          _buildReviewItem('Kayaknya_Kamu', 'Asd Dasdasd asd asdasod adasdasdadk daskd aksdasda sd a', 4),
          _buildReviewItem('Inisih_Saya', 'aaaskdadkskas asd kask kksdkasd asdkaksd kaksdakkk', 3),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String reviewer, String review, int rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reviewer,
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Row(
            children: List.generate(rating, (index) => Icon(Icons.star, color: Colors.orange, size: 20)),
          ),
          SizedBox(height: 5),
          Text(
            review,
            style: TextStyle(fontFamily: 'CustomFont', fontSize: 16),
          ),
          Divider(),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: ProductDetailPage(),
//   ));
// }
