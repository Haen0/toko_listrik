import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildOrderStatusButton(context, 'Unpaid Orders', Colors.orange, '/unpaidOrders'),
                  SizedBox(height: 10),
                  _buildOrderStatusButton(context, 'Orders in Process', Colors.blue, '/inProcessOrders'),
                  SizedBox(height: 10),
                  _buildOrderStatusButton(context, 'Ready Orders', Colors.green, '/readyOrders'),
                  SizedBox(height: 10),
                  _buildOrderStatusButton(context, 'Completed Orders', Colors.grey, '/completedOrders'),
                  SizedBox(height: 10),
                  _buildOrderStatusButton(context, 'Canceled Orders', Colors.red, '/canceledOrders'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusButton(BuildContext context, String title, Color color, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => OrderListPage(),
      '/unpaidOrders': (context) => UnpaidOrdersPage(),
      '/inProcessOrders': (context) => InProcessOrdersPage(),
      '/readyOrders': (context) => ReadyOrdersPage(),
      '/completedOrders': (context) => CompletedOrdersPage(),
      '/canceledOrders': (context) => CanceledOrdersPage(),
    },
  ));
}

class UnpaidOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unpaid Orders')),
      body: Center(child: Text('List of unpaid orders')),
    );
  }
}

class InProcessOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders in Process')),
      body: Center(child: Text('List of orders in process')),
    );
  }
}

class ReadyOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ready Orders')),
      body: Center(child: Text('List of ready orders')),
    );
  }
}

class CompletedOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Orders')),
      body: Center(child: Text('List of completed orders')),
    );
  }
}

class CanceledOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canceled Orders')),
      body: Center(child: Text('List of canceled orders')),
    );
  }
}
