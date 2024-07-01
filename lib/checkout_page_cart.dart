import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'invoice_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

}
  final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

List<String> _alamat = ['-'];
List<String> _opsiPembayaran = ['Dana'];
List<String> _opsiPengiriman = ['Ambil di Tempat'];

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Product> products = []; // Menyimpan produk dari database

  @override
  void initState() {
    super.initState();
    fetchCartData(); // Memuat data produk saat halaman diinisialisasi
  }

  void removeCartItems() async {
    final url = Uri.parse('http://192.168.18.9/db_toko_listrik/hapus_keranjang_checkout.php'); // Sesuaikan dengan URL endpoint PHP untuk menghapus produk dari keranjang
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // Produk berhasil dihapus dari keranjang
      setState(() {
        products.clear(); // Menghapus semua produk dari keranjang di aplikasi Flutter
      });
    } else {
      // Gagal menghapus produk dari keranjang, tampilkan pesan atau lakukan tindakan yang sesuai
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to remove cart items.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  // Fungsi untuk mengambil data produk dari database
  Future<void> fetchCartData() async {
    final url = Uri.parse('http://192.168.18.9/db_toko_listrik/tb_keranjang.php'); // Ganti dengan URL endpoint PHP Anda
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        products = jsonData.map((item) {
          return Product(
            id: item['id_produk'],
            imageUrl: item['gambar_produk_1'],
            name: item['nama_produk'],
            price: double.parse(item['harga_produk']),
            quantity: int.parse(item['quantity']),
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void sendOrderData(Map<String, dynamic> data) async {
  final url = Uri.parse('http://192.168.18.9/db_toko_listrik/tambah_pesanan.php'); // Ganti dengan URL endpoint PHP Anda
  final response = await http.post(url, body: data);

  if (response.statusCode == 200) {
    // Jika permintaan berhasil, lakukan navigasi ke halaman invoice atau tampilkan pesan sukses
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InvoicePage()),
    );
    removeCartItems();
  } else {
    // Jika terjadi kesalahan, tampilkan pesan atau tindakan yang sesuai
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to place order.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();
    int totalItems = calculateTotalItems();
    double admin =  5000;
    double totalPembayaran  = calculateTotalPembayaran(totalPrice, admin);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Keranjang'),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Checkout'),
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
            // Menyesuaikan atribut lainnya seperti elevation, brightness, dll.
          ),
          SliverToBoxAdapter(
            child:DropdownFormFieldExample(),
          ),
          SliverToBoxAdapter(
            child:Divider(
              color: Colors.grey[400],
              thickness: 1.0,
              height: 4.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0, bottom: 5.0),
              child: Row(
                children: [
                  Image.asset('assets/images/shipping.png',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.cover,
                  ), // Icon di sebelah kiri teks
                  SizedBox(width: 10), // Jarak antara ikon dan teks
                  Text(
                    'Opsi Pengiriman',
                    style: TextStyle(fontFamily: 'CustomFont', color: Colors.black, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: InputPilihanPengiriman(),
            ),
          ),
          SliverToBoxAdapter(
            child:Divider(
              color: Colors.grey[400],
              thickness: 1.0,
              height: 4.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0, bottom: 5.0),
              child: Text('Detail Pesanan', style: TextStyle(fontFamily: 'CustomFont', fontWeight: FontWeight.w600),),
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
          SliverToBoxAdapter(
            child:Divider(
              color: Colors.grey[400],
              thickness: 1.0,
              height: 4.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0, bottom: 5.0),
              child: InputPilihanPembayaran(),
            ),
          ),
          SliverToBoxAdapter(
            child:Divider(
              color: Colors.grey[400],
              thickness: 1.0,
              height: 4.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(right: 35.0, left: 35.0, top: 20.0, bottom: 5.0),
              child: Text('Rincian Pembayaran', style: TextStyle(fontFamily: 'CustomFont', fontWeight: FontWeight.w600),),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(right: 35.0, left: 35.0, top: 10.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Subtotal Produk:',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${formatCurrency.format(totalPrice)}',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Subtotal Pengiriman:',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Rp0',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Biaya Layanan:',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${formatCurrency.format(admin)}',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
              ),
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
            // Optionally, you can add boxShadow for a shadow effect
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
                      'Total: ${formatCurrency.format(totalPembayaran)}',
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
                    // Mengambil data alamat terpilih
                    String alamatPenerima = '-';
                    
                    // Mengambil metode pembayaran terpilih
                    String metodePembayaran = 'Dana';

                    // Mengambil data produk yang dibeli
                    List<Map<String, dynamic>> produkPesanan = products.map((product) {
                      return {
                        'id_produk': product.id, // Ganti dengan id produk jika tersedia
                        'quantity': product.quantity,
                      };
                    }).toList();

                    // Membuat payload data untuk dikirim ke backend
                    Map<String, dynamic> data = {
                      'id_pembeli': '1', // Ganti dengan id pembeli jika tersedia
                      'alamat': alamatPenerima,
                      'metode_pembayaran': metodePembayaran,
                      'total_pembayaran': totalPembayaran.toString(),
                      'produk_pesanan': jsonEncode(produkPesanan),
                    };

                    // Mengirim data ke backend menggunakan HTTP POST
                    sendOrderData(data);
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
                    'Bayar Sekarang',
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
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                            product.quantity.toString(),
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                      SizedBox(height: 5.0),
                      Text(
                        '${formatCurrency.format(product.price)}',
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    product.imageUrl,
                    width: 65.0,
                    height: 65.0,
                    fit: BoxFit.cover,
                  ),
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
    double totalPrice = 0;
    for (var product in products) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  double calculateTotalPembayaran(double totalPrice, double admin) {
    double totalPembayaran = 0;
    totalPembayaran = totalPrice + admin;
    return totalPembayaran;
  }

  int calculateTotalItems() {
    int totalItems = 0;
    for (var product in products) {
      totalItems += product.quantity;
    }
    return totalItems;
  }
}


class DropdownFormFieldExample extends StatefulWidget {
  @override
  _DropdownFormFieldExampleState createState() => _DropdownFormFieldExampleState();
}

class _DropdownFormFieldExampleState extends State<DropdownFormFieldExample> {
  String? _selectedValue; // Make sure to use nullable type

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),  // Padding di luar DropdownButtonFormField
      child: DropdownButtonFormField<String>(
        
        isExpanded: true, 
        decoration: InputDecoration(
          label: Row(
            children: [
              Image.asset('assets/images/address.png',
                width: 20.0,
                height: 20.0,
                fit: BoxFit.cover,
              ), // Replace with your desired icon
              SizedBox(width: 8.0),
              Text('Alamat Penerima', style: TextStyle(color: Colors.black),),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 1.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0), 
        ),
        value: _selectedValue,
        items: _alamat.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: 'CustomFont', fontSize: 14.0),),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        validator: (String? value) => value == null ? 'Please select an option' : null,
      ),
    );
  }
}

class InputPilihanPengiriman extends StatefulWidget {
  @override
  _InputPilihanPengirimanState createState() => _InputPilihanPengirimanState();
}

class _InputPilihanPengirimanState extends State<InputPilihanPengiriman> {
  int _selectedIndex = -1;

  void _onCardTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCardTap(1),
      child: Card(
        color: _selectedIndex == 1 ? Colors.blueGrey.shade400 : Colors.white,
        child: ListTile(
          title: Text('Ambil di Tempat'),
          leading: Radio<int>(
            value: 1,
            groupValue: _selectedIndex,
            activeColor: Colors.white,
            onChanged: (int? value) {
              setState(() {
                _selectedIndex = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}

class InputPilihanPembayaran extends StatefulWidget {
  @override
  _InputPilihanPembayaranState createState() => _InputPilihanPembayaranState();
}

class _InputPilihanPembayaranState extends State<InputPilihanPembayaran> {
  String? _selectedValuePembayaran;

  void _showBottomSheetPembayaran() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white, // Atur warna background modal sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0), // Atur padding untuk konten
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _opsiPembayaran.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  _opsiPembayaran[index],
                  style: TextStyle(
                    fontFamily: 'CustomFont', // Gaya teks
                    fontSize: 16.0, // Ukuran teks
                    color: Colors.black, // Warna teks
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedValuePembayaran = _opsiPembayaran[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        label: Text('Opsi Pembayaran', style: TextStyle(fontFamily: 'CustomFont', color: Colors.black, fontSize: 14.0),),
        border: InputBorder.none, // Menghilangkan border
        enabledBorder: InputBorder.none, // Menghilangkan border saat tidak fokus
        focusedBorder: InputBorder.none, //
        icon: Image.asset('assets/images/payment.png',
          width: 30.0,
          height: 30.0,
          fit: BoxFit.cover,
        ),
        hintText: _selectedValuePembayaran ?? 'Opsi Pembayaran',
        // contentPadding: EdgeInsets.only(left: 0.0, right: 5.0),
      ),
      onTap: _showBottomSheetPembayaran,
    );
  }
}