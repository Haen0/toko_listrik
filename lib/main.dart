import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'home_page.dart';
import 'new_products.dart';
import 'transaction_page.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  // final String userId;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    NewProductPage(),
    TransactionPage(),
    SettingProfile(),
    // LoginPage(),
    // Awalan(title: 'Selamat Datang!'),
    // PilihLogin(title: 'Selamat Datang!'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent, // Mengatur warna splash menjadi transparent
        highlightColor: Colors.transparent, // Mengatur warna highlight menjadi transparent
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            // Optionally, you can add boxShadow for a shadow effect
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconsaxPlusLinear.home_1 : IconsaxPlusLinear.home,
                  ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 1 ? IconsaxPlusLinear.box_1 : IconsaxPlusLinear.box,
                  ),
                label: 'Produk Baru',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 2 ? IconsaxPlusLinear.receipt_2 : IconsaxPlusLinear.receipt_2_1,
                  ),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconsaxPlusLinear.profile_2user : IconsaxPlusLinear.profile,
                  ),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ),
    );
  }
  // int _selectedIndex = 0;

  // static const List<Widget> _widgetOptions = <Widget>[
  //   HomePage(),
  //   NewProductPage(),
  //   TransactionPage(),
  //   ProfilePage(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: Container(
  //       decoration: BoxDecoration(
  //         color: const Color.fromARGB(255, 255, 0, 0),
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(50.0),
  //           topRight: Radius.circular(20.0),
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black26,
  //             blurRadius: 10,
  //             offset: Offset(0, -2),
  //           ),
  //         ],
  //       ),
  //       child: BottomNavigationBar(
  //         type: BottomNavigationBarType.fixed,
  //         currentIndex: _selectedIndex,
  //         selectedItemColor: Colors.black,
  //         unselectedItemColor: Colors.grey,
  //         onTap: _onItemTapped,
  //         showSelectedLabels: true,
  //         showUnselectedLabels: true,
  //         selectedLabelStyle: TextStyle(
  //           fontSize: 12,
  //           color: Colors.blue,
  //         ),
  //         unselectedLabelStyle: TextStyle(
  //           fontSize: 12,
  //           color: Colors.grey,
  //         ),
  //         items: const <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //             icon: Padding(
  //               padding: EdgeInsets.only(top: 8.0),
  //               child: Icon( _selectedIndex == 0 ? IconsaxPlusLinear.home_1 : IconsaxPlusLinear.home),
  //             ),
  //             label: 'Home',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Padding(
  //               padding: EdgeInsets.only(top: 8.0),
  //               child: Icon(IconsaxPlusLinear.box),
  //             ),
  //             label: 'New Products',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Padding(
  //               padding: EdgeInsets.only(top: 8.0),
  //               child: Icon(IconsaxPlusLinear.receipt_2_1),
  //             ),
  //             label: 'Transactions',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Padding(
  //               padding: EdgeInsets.only(top: 8.0),
  //               child: Icon(IconsaxPlusLinear.profile),
  //             ),
  //             label: 'Profile',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}