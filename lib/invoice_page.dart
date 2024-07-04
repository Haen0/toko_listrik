import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'main.dart';

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Invoice'),
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
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildInvoiceHeader(),
                  SizedBox(height: 20),
                  _buildOrderStatus(),
                  SizedBox(height: 20),
                  _buildInvoiceDetails(),
                  SizedBox(height: 20),
                  _buildProductDetails(),
                  SizedBox(height: 20),
                  _buildShippingInfo(),
                  SizedBox(height: 20),
                  _buildPaymentOptions(),
                  SizedBox(height: 20),
                  _buildCostSummary(),
                  SizedBox(height: 20),
                  _buildBackToHomeButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NO. Pesanan: 45', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('Tanggal Pembelian: 2024-07-04', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildOrderStatus() {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 8),
        Text('Status Pesanan: Unpaid', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildInvoiceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Detail Produk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(),
      ],
    );
  }

  Widget _buildProductDetails() {
    // You can dynamically build this part based on the list of products
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductItem('Setrika Listrik', 1, 150000),
        // _buildProductItem('Product 2', 1, 30),
        // _buildProductItem('Product 3', 3, 20),
      ],
    );
  }

  Widget _buildProductItem(String name, int qty, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: TextStyle(fontSize: 16))),
          Text('Qty: $qty ', style: TextStyle(fontSize: 16)),
          Text('Rp$price', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildShippingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Informasi Pengiriman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(),
        Text('Opsi Pengiriman: Ambil di Tempat', style: TextStyle(fontSize: 16)),
        Text('Alamat Penerima: -', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Metode Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(),
        Text('Dana', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildCostSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rincian Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(),
        _buildCostItem('Subtotal Produk', 150000),
        _buildCostItem('Subtotal Pengiriman', 0),
        _buildCostItem('Biaya Layanan', 5000),
        Divider(),
        _buildCostItem('Total Pembayaran', 155000, isBold: true),
      ],
    );
  }

  Widget _buildCostItem(String label, double cost, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text('\Rp$cost', style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push( context,
          MaterialPageRoute(builder: (context) => MainPage()),
          );
        },
        child: Text('Back to Home'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InvoicePage(),
  ));
}



// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class InvoicePage extends StatefulWidget {
//   final String idPesanan;

//   const InvoicePage({Key? key, required this.idPesanan}) : super(key: key);

//   @override
//   _InvoicePageState createState() => _InvoicePageState();
// }

// class _InvoicePageState extends State<InvoicePage> {
//   late Future<Map<String, dynamic>> _futureInvoice;

//   @override
//   void initState() {
//     super.initState();
//     _futureInvoice = fetchInvoice(widget.idPesanan);
//   }

//   Future<Map<String, dynamic>> fetchInvoice(String idPesanan) async {
//     final url = 'http://192.168.56.1/db_toko_listrik/detail_invoice.php?id_pesanan=$idPesanan';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load invoice');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _futureInvoice,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final invoice = snapshot.data!;
//             return CustomScrollView(
//               slivers: <Widget>[
//                 SliverAppBar(
//                   title: Text('Invoice'),
//                   backgroundColor: Colors.white,
//                   floating: true,
//                   pinned: true,
//                   snap: false,
//                   centerTitle: true,
//                   leading: IconButton(
//                     icon: Icon(Icons.arrow_left, color: Colors.black),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 SliverPadding(
//                   padding: EdgeInsets.all(20.0),
//                   sliver: SliverList(
//                     delegate: SliverChildListDelegate(
//                       [
//                         _buildInvoiceHeader(invoice),
//                         SizedBox(height: 20),
//                         _buildOrderStatus(invoice),
//                         SizedBox(height: 20),
//                         _buildInvoiceDetails(),
//                         SizedBox(height: 20),
//                         _buildProductDetails(invoice),
//                         SizedBox(height: 20),
//                         _buildShippingInfo(invoice),
//                         SizedBox(height: 20),
//                         _buildPaymentOptions(invoice),
//                         SizedBox(height: 20),
//                         _buildCostSummary(invoice),
//                         SizedBox(height: 20),
//                         _buildBackToHomeButton(context),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildInvoiceHeader(Map<String, dynamic> invoice) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('NO. Pesanan: #${invoice['orderNo']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         Text('Tanggal Pembelian: ${invoice['date']}', style: TextStyle(fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildOrderStatus(Map<String, dynamic> invoice) {
//     return Row(
//       children: [
//         Icon(Icons.check_circle, color: Colors.green),
//         SizedBox(width: 8),
//         Text('Status Pesanan: ${invoice['status']}', style: TextStyle(fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildInvoiceDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Detail Produk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         Divider(),
//       ],
//     );
//   }

//   Widget _buildProductDetails(Map<String, dynamic> invoice) {
//     List<dynamic> items = invoice['items'];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: items.map((item) => _buildProductItem(item['name'], item['qty'], double.parse(item['price']))).toList(),
//     );
//   }

//   Widget _buildProductItem(String name, int qty, double price) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(child: Text(name, style: TextStyle(fontSize: 16))),
//           Text('Qty: $qty', style: TextStyle(fontSize: 16)),
//           Text('\$$price', style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }

//   Widget _buildShippingInfo(Map<String, dynamic> invoice) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Informasi Pengiriman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         Divider(),
//         Text('Opsi Pengiriman: ${invoice['shippingOption']}', style: TextStyle(fontSize: 16)),
//         Text('Alamat Penerima: ${invoice['shippingAddress']}', style: TextStyle(fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildPaymentOptions(Map<String, dynamic> invoice) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Metode Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         Divider(),
//         Text('${invoice['paymentMethod']}', style: TextStyle(fontSize: 16)),
//       ],
//     );
//   }

//   Widget _buildCostSummary(Map<String, dynamic> invoice) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Rincian Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         Divider(),
//         _buildCostItem('Subtotal Produk', double.parse(invoice['subtotal'])),
//         _buildCostItem('Subtotal Pengiriman', double.parse(invoice['shippingCost'])),
//         _buildCostItem('Biaya Layanan', double.parse(invoice['serviceFee'])),
//         Divider(),
//         _buildCostItem('Total Pembayaran', double.parse(invoice['total']), isBold: true),
//       ],
//     );
//   }

//   Widget _buildCostItem(String label, double cost, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//           Text('\Rp${cost.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//         ],
//       ),
//     );
//   }

//   Widget _buildBackToHomeButton(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           // Navigator.pushReplacement( // Mengganti halaman agar tidak ada navigasi kembali ke InvoicePage
//           //   context,
//           //   MaterialPageRoute(builder: (context) => MainPage()),
//           // );
//         },
//         child: Text('Back to Home'),
//       ),
//     );
//   }
// }
