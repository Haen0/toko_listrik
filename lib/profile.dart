import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'awalan.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            buildListTileWithBorder(
              icon: Icons.person,
              title: 'Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            buildListTileWithBorder(
              icon: Icons.receipt,
              title: 'Pesanan Saya',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                );
              },
            ),
            buildListTileWithBorder(
              icon: Icons.chat,
              title: 'Chat',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatListPage()),
                );
              },
            ),
            buildListTileWithBorder(
              icon: Icons.help,
              title: 'Bantuan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
            buildListTileWithBorder(
              icon: Icons.info,
              title: 'Tentang',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            buildListTileWithBorder(
              icon: Icons.logout,
              title: 'Keluar',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Awalan(title: 'Selamat Datang!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTileWithBorder(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: onTap,
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _telpController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  String _imageUrl = 'assets/images/logo.jpg'; // Default image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(); // Method to show image picker
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(_imageUrl),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Edit Foto',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 1000, // Ubah lebar sesuai keinginan
                  child: TextFormField(
                    initialValue: 'Farhan',
                    decoration: InputDecoration(labelText: 'Nama'),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Nama tidak boleh kosong';
                    //   }
                    //   return null;
                    // },
                  ),
                ),

                SizedBox(height: 16),
                Container(
                  width: 1000, // Ubah lebar sesuai keinginan
                  child: TextFormField(
                    initialValue: 'farhan@gmail.com',
                    // controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Email tidak boleh kosong';
                    //   }
                    //   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    //     return 'Masukkan email yang valid';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 1000, // Ubah lebar sesuai keinginan
                  child: TextFormField(
                    initialValue: 'Masukan no. telp',
                    // controller: _telpController,
                    decoration: InputDecoration(labelText: 'No Telp'),
                    keyboardType: TextInputType.phone, // Menambahkan input type phone
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'No Telp tidak boleh kosong';
                    //   }
                    //   if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                    //     return 'Masukkan No Telp yang valid';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 1000, // Ubah lebar sesuai keinginan
                  child: TextFormField(
                    initialValue: '12345678',
                    // controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Kata Sandi'),
                    obscureText: true,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Kata sandi tidak boleh kosong';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profil berhasil diperbarui')),
                      );
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white70, // Ubah warna teks menjadi putih
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Ubah warna background tombol menjadi hitam
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Pilih dari Galeri'),
                  onTap: () {
                    _getImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Ambil Foto'),
                  onTap: () {
                    _getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Hapus Foto'),
                  onTap: () {
                    _deleteImage(); // Method to delete image
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  void _deleteImage() async {
    if (_imageUrl.isNotEmpty) {
      try {
        final file = File(_imageUrl);
        await file.delete(); // Hapus file dari penyimpanan lokal
      } catch (e) {
        print('Error deleting image file: $e');
        // Handle error, if any
      } finally {
        setState(() {
          _imageUrl = ''; // Reset URL gambar setelah dihapus
        });
      }
    }
  }
}

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  String _selectedProduct = 'Semua Produk';
  String _selectedStatus = 'Semua Status';
  String _selectedDate = 'Semua Tanggal';

  List<String> _productOptions = [
    'Semua Produk',
    'Lampu',
    'Kipas',
    'Peralatan Listrik Rumah Tangga Lainnya'
  ];
  List<String> _statusOptions = [
    'Semua Status',
    'Pesanan Diproses',
    'Pesanan Dikirim',
    'Pesanan Selesai',
    'Pesanan Batal'
  ];
  List<String> _dateOptions = [
    'Semua Tanggal',
    'Hari Ini',
    'Minggu Ini',
    'Bulan Ini',
    'Tahun Ini',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDropdown(
              'Produk',
              _selectedProduct,
              _productOptions,
              (newValue) {
                setState(() {
                  _selectedProduct = newValue!;
                });
              },
            ),
            buildDropdown(
              'Status',
              _selectedStatus,
              _statusOptions,
              (newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
            ),
            buildDropdown(
              'Tanggal',
              _selectedDate,
              _dateOptions,
              (newValue) {
                setState(() {
                  _selectedDate = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Apply filters
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Filter diterapkan')),
                );
              },
              child: Text('Terapkan Filter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    String selectedValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: selectedValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<String> stores = [
    'Store 1',
    'Store 2',
    'Store 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Toko'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stores[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(storeName: stores[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String storeName;

  ChatPage({required this.storeName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.storeName}'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessageItem(messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      setState(() {
                        messages.add({
                          'text': messageController.text,
                          'isUser': true,
                          'timestamp': DateTime.now().toString(),
                        });
                        messageController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageItem(Map<String, dynamic> message) {
    return ListTile(
      title: Text(message['text']),
      subtitle: Text(message['timestamp']),
      trailing: message['isUser'] ? Icon(Icons.person) : Icon(Icons.store),
    );
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Ini adalah halaman Bantuan.'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Ini adalah halaman Tentang.'),
      ),
    );
  }
}
