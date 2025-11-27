import 'package:flutter/material.dart';
import 'screens/exercise1_listview.dart';
import 'screens/exercise2_gridview.dart';
import 'screens/exercise3_shared_preferences.dart';
import 'screens/exercise4_async.dart';
import 'screens/exercise5_isolate.dart';
import 'screens/exercise6_isolate_communication.dart';

void main() {
  runApp(const ExerciseWeek4App());
}

class ExerciseWeek4App extends StatelessWidget {
  const ExerciseWeek4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Week 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade800,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Helper to create a menu item
  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget screen,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal.shade600, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.navigate_next),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Week 4 - Menu')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          _buildMenuItem(
            context,
            title: 'Bài 1: ListView',
            subtitle: 'Danh sách contact có avatar',
            screen: const ContactListPage(),
            icon: Icons.contacts,
          ),
          _buildMenuItem(
            context,
            title: 'Bài 2: GridView',
            subtitle: 'Gallery ảnh với count() và extent()',
            screen: const GalleryPage(),
            icon: Icons.grid_on,
          ),
          _buildMenuItem(
            context,
            title: 'Bài 3: SharedPreferences',
            subtitle: 'Lưu, hiển thị và xóa dữ liệu',
            screen: const UserProfilePage(),
            icon: Icons.save,
          ),
          _buildMenuItem(
            context,
            title: 'Bài 4: Async',
            subtitle: 'Tải dữ liệu bất đồng bộ',
            screen: const AsyncLoadingPage(),
            icon: Icons.hourglass_top,
          ),
          _buildMenuItem(
            context,
            title: 'Bài 5: Isolate',
            subtitle: 'Tính giai thừa với compute()',
            screen: const FactorialPage(),
            icon: Icons.calculate,
          ),
          _buildMenuItem(
            context,
            title: 'Bài 6: Isolate Communication',
            subtitle: 'Giao tiếp giữa 2 isolate',
            screen: const IsolateCommunicationPage(),
            icon: Icons.sync_alt,
          ),
        ],
      ),
    );
  }
}
