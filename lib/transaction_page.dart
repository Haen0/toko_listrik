// import 'package:flutter/material.dart';

// class TransactionPage extends StatelessWidget {
//   const TransactionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Transaction Page'),
//         backgroundColor: Colors.white,
//       ),
//       backgroundColor: Colors.white,
//       body: const Center(
//         child: Text('Transaction Page Content'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );


class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text('Pesanan Saya', style: TextStyle(fontFamily: 'CustomFont'),),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Unpaid Orders'),
              Tab(text: 'Processing Orders'),
              Tab(text: 'Ready Orders'),
              Tab(text: 'Completed Orders'),
              Tab(text: 'Cancelled Orders'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, 'Unpaid'),
            _buildOrderList(context, 'Processing'),
            _buildOrderList(context, 'Ready'),
            _buildOrderList(context, 'Completed'),
            _buildOrderList(context, 'Cancelled'),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchOrders(String status) async {
    final url = Uri.parse('http://192.168.56.1/db_toko_listrik/tb_pesanan.php?status=$status');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((order) => order as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }


  Widget _buildOrderList(BuildContext context, String status) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchOrders(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No orders found'));
        } else {
          final orders = snapshot.data!;
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(20.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildOrderCard(orders[index]),
                    childCount: orders.length,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      color: Colors.blueGrey.shade100,
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order No: ${order['orderNo']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Date: ${order['date']}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Text('Buyer: ${order['buyer']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Column(
              children: List.generate(order['items'].length, (index) {
                return _buildOrderItem(order['items'][index]);
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pembayaran: Rp${order['total']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Status: ${order['status']}', style: TextStyle(fontSize: 16, color: _getStatusColor(order['status']))),
              ]
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: TextStyle(fontSize: 16)),
                Text('Qty: ${item['qty']}', style: TextStyle(fontSize: 16)),
                Text('Rp${item['price']}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Unpaid':
        return Colors.red;
      case 'Processing':
        return Colors.orange;
      case 'Ready':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: TransactionPage(),
//   ));
// }
