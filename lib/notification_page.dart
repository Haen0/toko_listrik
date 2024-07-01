// import 'package:flutter/material.dart';

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});

//   final String backgroundImage = 'assets/images/background.jpg'; // Sesuaikan dengan path gambar Anda

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Background Image Example'),
//         ),
        
//         // Menggunakan Container sebagai latar belakang dengan gambar
//         backgroundColor: Colors.transparent, // Atur latar belakang Scaffold menjadi transparan
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(backgroundImage),
//               fit: BoxFit.cover, // Menyesuaikan gambar untuk menutupi seluruh latar belakang
//             ),
//           ),
//           child: Center(
//             child: Text(
//               'Content goes here',
//               style: TextStyle(fontSize: 20.0, color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverPadding(
//             padding: EdgeInsets.all(20.0),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) => _buildNotificationCard(notifications[index]),
//                 childCount: notifications.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNotificationCard(Map<String, dynamic> notification) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 20),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               notification['title'],
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               notification['message'],
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Order No: ${notification['orderNo']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Status: ${notification['status']}',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: _getStatusColor(notification['status']),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'Ready':
//         return Colors.blue;
//       case 'Cancelled':
//         return Colors.red;
//       case 'Processing':
//         return Colors.orange;
//       case 'Completed':
//         return Colors.green;
//       default:
//         return Colors.black;
//     }
//   }
// }

// // Example notifications
// final List<Map<String, dynamic>> notifications = [
//   {
//     'title': 'Order Ready',
//     'message': 'Your order is ready for pickup.',
//     'orderNo': '123456',
//     'status': 'Ready',
//   },
//   {
//     'title': 'Order Cancelled',
//     'message': 'Your order has been cancelled.',
//     'orderNo': '123457',
//     'status': 'Cancelled',
//   },
//   {
//     'title': 'Order Processing',
//     'message': 'Your order is being processed.',
//     'orderNo': '123458',
//     'status': 'Processing',
//   },
//   {
//     'title': 'Order Completed',
//     'message': 'Your order has been completed.',
//     'orderNo': '123459',
//     'status': 'Completed',
//   },
//   // Add more notifications here
// ];

// void main() {
//   runApp(MaterialApp(
//     home: NotificationsPage(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
  final List<Map<String, String>> notifications = [
    {'orderNo': '123456', 'message': 'Your order #123456 is ready.'},
    {'orderNo': '123457', 'message': 'Your order #123457 has been cancelled.'},
    {'orderNo': '123458', 'message': 'Your order #123458 is being processed.'},
    // Add more notifications here
  ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Notifikasi'),
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
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildNotificationCard(notifications[index]),
                childCount: notifications.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> notification) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          notification['message']!,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationsPage(),
  ));
}
