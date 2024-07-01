// import 'package:flutter/material.dart';
// import 'package:iconsax_plus/iconsax_plus.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             IconButton(
//               icon: const Icon(IconsaxPlusLinear.arrow_left_3),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(IconsaxPlusLinear.search_normal_1),
//                 hintText: 'Search...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//               ),
//             ),
//             // Tambahkan widget lain sesuai kebutuhan Anda untuk tampilan pencarian
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _searchHistory = ['Laptop', 'Smartphone', 'Headphones', 'Camera'];
  TextEditingController _searchController = TextEditingController();

  void _deleteSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(IconsaxPlusLinear.arrow_left_3),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(IconsaxPlusLinear.search_normal_1),
                hintText: 'Cari apa hari ini...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Search History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: _deleteSearchHistory,
                        child: Text('Clear History'),
                      ),
                    ],
                  ),
                  ..._searchHistory.map((history) => _buildSearchHistoryItem(history)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHistoryItem(String history) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(history),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              _searchHistory.remove(history);
            });
          },
        ),
        onTap: () {
          setState(() {
            _searchController.text = history;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}
