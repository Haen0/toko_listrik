import 'package:flutter/material.dart';
import 'package:toko_listrik/login.dart';
import 'pilih_login.dart';


class Awalan extends StatefulWidget {
  // Mengizinkan key untuk bernilai null dengan menggunakan tipe Key?
  Awalan({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AwalanState createState() => _AwalanState();
}


class _AwalanState extends State<Awalan> {
  // const Awalan({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(widget.title),
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/login.png'), // Ganti 'assets/shopping_bags.png' dengan path gambar Anda
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Tersedia segala kebutuhan listrik Anda di aplikasi Rumah Toko Listrik! Temukan beragam produk berkualitas untuk kebutuhan rumah dan bisnis Anda di sini.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PilihLogin(title: 'Selamat Datang!')),
                );
              },
              child: Text('Daftar Sekarang'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Sudah punya akun? Login disini'),
            ),
          ],
        ),
      ),
      
    );
  }
}