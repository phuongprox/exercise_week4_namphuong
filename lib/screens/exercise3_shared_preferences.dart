import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Thêm import để định dạng ngày giờ

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  String _savedData = 'Chưa có dữ liệu nào được lưu.';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Tải dữ liệu từ SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    // Dùng ?? để gán giá trị mặc định nếu key không tồn tại
    final name = prefs.getString('user_name') ?? '';
    final email = prefs.getString('user_email') ?? '';
    final age = prefs.getInt('user_age');
    final timestampStr = prefs.getString('user_timestamp');

    if (name.isNotEmpty) {
      // Định dạng lại timestamp để dễ đọc hơn
      final timestamp = timestampStr != null
          ? DateFormat(
              'HH:mm:ss dd/MM/yyyy',
            ).format(DateTime.parse(timestampStr))
          : 'Không rõ';

      setState(() {
        _savedData =
            'Tên: $name\nEmail: $email\nTuổi: $age\nLưu lúc: $timestamp';
        // Cập nhật lại các ô nhập liệu
        _nameController.text = name;
        _emailController.text = email;
        _ageController.text = age?.toString() ?? '';
      });
    }
  }

  // Lưu dữ liệu vào SharedPreferences
  Future<void> _saveUserData() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text);
    await prefs.setString('user_email', _emailController.text);
    await prefs.setInt('user_age', int.tryParse(_ageController.text) ?? 0);
    await prefs.setString('user_timestamp', DateTime.now().toIso8601String());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu thông tin thành công!')),
    );
    _loadUserData(); // Tải lại để hiển thị
  }

  // Xóa dữ liệu khỏi SharedPreferences
  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _savedData = 'Chưa có dữ liệu nào được lưu.';
      _nameController.clear();
      _emailController.clear();
      _ageController.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã xóa toàn bộ dữ liệu!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 3: SharedPreferences')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Vùng nhập liệu
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Tên'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Tuổi'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Các nút chức năng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveUserData,
                  icon: const Icon(Icons.save),
                  label: const Text('Lưu'),
                ),
                ElevatedButton.icon(
                  onPressed: _loadUserData,
                  icon: const Icon(Icons.visibility),
                  label: const Text('Hiển thị'),
                ),
                ElevatedButton.icon(
                  onPressed: _clearUserData,
                  icon: const Icon(Icons.delete),
                  label: const Text('Xóa'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Vùng hiển thị dữ liệu đã lưu
            const Text(
              'Dữ liệu đã lưu:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _savedData,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
