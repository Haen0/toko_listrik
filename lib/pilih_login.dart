import 'package:flutter/material.dart';
import 'package:toko_listrik/regis.dart';

class PilihLogin extends StatefulWidget {
  PilihLogin({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PilihLoginState createState() => _PilihLoginState();
}

class _PilihLoginState extends State<PilihLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Silahkan buat akun anda agar bisa membeli/menjual produk',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset('assets/images/penjual.png'),
                      ),
                    ),
                    SizedBox(height: 10), // add some space
                    Text(
                      'Penjual',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Image.asset('assets/images/pembeli.png'),
                          ),
                        ),
                      ),
                    SizedBox(height: 10), // add some space
                    Text(
                      'Pembeli',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ), // added closing parenthesis
            SizedBox(height: 30),
            Text(
              'Bergabunglah bersama kami,\ndan nikmati berbagai fitur unggulan yang kami sediakan',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}