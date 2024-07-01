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
        Text('NO. Pesanan: #123456', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('Tanggal Pembelian: 2023-06-24', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildOrderStatus() {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 8),
        Text('Status Pesanan: Delivered', style: TextStyle(fontSize: 16)),
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
        _buildProductItem('Product 1', 2, 50),
        _buildProductItem('Product 2', 1, 30),
        _buildProductItem('Product 3', 3, 20),
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
          Text('Qty: $qty', style: TextStyle(fontSize: 16)),
          Text('\$$price', style: TextStyle(fontSize: 16)),
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
        Text('Alamat Penerima: Jl. Indramayu', style: TextStyle(fontSize: 16)),
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
        _buildCostItem('Subtotal Produk', 180),
        _buildCostItem('Subtotal Pengiriman', 10),
        _buildCostItem('Biaya Layanan', 5),
        Divider(),
        _buildCostItem('Total Pembayaran', 195, isBold: true),
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
