import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'detail_product.dart';

class ProductCard extends StatelessWidget {
  // final String image_url;
  // final String name;
  // final String category;
  // final String price;
  // final String rate;
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

  // Product({
  ProductCard({
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
  // });
    // required this.image_url,
    // required this.name,
    // required this.category,
    // required this.price,
    // required this.rate,
    super.key,
  });

  final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailPage(
            idProduk: idProduk,
            namaPenjual: namaPenjual,
            namaProduk: namaProduk,
            namaToko: namaToko,
            kategori: kategori,
            hargaProduk: hargaProduk,
            descProduk: descProduk,
            gambarProduk1: gambarProduk1,
            gambarProduk2: gambarProduk2,
            gambarProduk3: gambarProduk3,
            gambarProduk4: gambarProduk4,
            gambarProduk5: gambarProduk5,
            stokProduk: stokProduk,
            rate: rate,
          )),
        );
      },
      child: Card(
      color: Colors.white, // Atur warna Card di sini
      elevation: 0, // Hapus shadow dengan mengatur elevation menjadi 0
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity, // Lebar sesuai dengan parent (dalam hal ini Card)
            child: AspectRatio(
              aspectRatio: 1, // Rasio 1:1 untuk gambar persegi
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan radius yang Anda inginkan
                child: Image.asset(
                  gambarProduk1,
                  fit: BoxFit.cover, // Atur agar gambar memenuhi ruang yang tersedia
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaProduk,
                      maxLines: 2,  // Maksimum satu baris
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      kategori,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2), 
                // Expanded(child: Container()), 
                Row( // Using Row to display price and rate in the same line
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatCurrency.format(hargaProduk),
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$rate/5',
                          style: const TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          IconsaxPlusBold.star, // Contoh ikon yang digunakan (ganti dengan ikon yang Anda inginkan)
                          size: 17.0, // Ukuran ikon
                          color: Colors.orange, // Warna ikon
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