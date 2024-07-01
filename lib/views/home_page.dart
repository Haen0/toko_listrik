import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart'; // untuk mengaktifkan fitur on tap
import 'package:toko_listrik/views/register_page.dart';

void main() => runApp(
  MaterialApp (
    home: HomePage(),
  )
);

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff526D82),
              Color(0xff9DB2BF),
              // Color(0xffDDE6ED)
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                SizedBox(height: 10,),
                Text("Selamat Datang", style: TextStyle(color: Colors.white, fontSize: 18),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 200, 200, 200),
                            blurRadius: 20,
                            offset: Offset(0, 10)
                          )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: 40,),
                      // Text("Belum punya akun?", style: TextStyle(color: Colors.grey),),
                      // SizedBox(height: 40,),   


                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xffDDE6ED)
                        ),
                        child: Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),

              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Belum punya akun? ',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Aksi yang ingin dilakukan saat "Register" diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpForm()),
                          );
                        },
                    ),
                  ],
                ),
              ),
                     // SizedBox(height: 30,),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Container(
                      //         height: 50,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         color: Colors.blue
                      //       ),
                      //       ),
                      //     ),

                          // SizedBox(width: 30,),
                          //  Expanded(
                          //   child: Container(
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       color: Colors.black
                          //   ),
                          //   ),
                          // ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
