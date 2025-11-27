import 'package:flutter/material.dart';

/// Màn hình hiển thị danh sách các liên hệ.
class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});
  // Dữ liệu mẫu của danh bạ
  final List<Map<String, String>> contacts = const [
    {'name': 'Son Heung-Cao DOG', 'description': 'Bạn học'},
    {'name': 'Trần Thị Bình', 'description': 'Đồng nghiệp'},
    {'name': 'Lê Hoàng Cường', 'description': 'Giám đốc dự án'},
    {'name': 'Phạm Thị Dung', 'description': 'Khách hàng'},
    {'name': 'Võ Minh Hải', 'description': 'Gia đình'},
    {'name': 'Hoàng Thị Giang', 'description': 'Bạn thân'},
    {'name': 'Đặng Văn Hùng', 'description': 'Đối tác kinh doanh'},
    {'name': 'Bùi Thị Lan', 'description': 'Hàng xóm'},
    {'name': 'Dương Minh Long', 'description': 'Câu lạc bộ thể thao'},
    {'name': 'Mai Thị Ngọc', 'description': 'Bạn đại học'},
    {'name': 'Trịnh Văn Quang', 'description': 'Người quen'},
    {'name': 'Vũ Thị Thảo', 'description': 'Đồng nghiệp cũ'},
  ];

  // Hàm để lấy màu ngẫu nhiên cho các Avatar
  Color _getAvatarColor(String name) {
    return Colors.primaries[name.hashCode % Colors.primaries.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 1: Danh bạ ListView')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          final contact = contacts[index];
          final name = contact['name']!;
          final description = contact['description']!;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: _getAvatarColor(name),
                child: Text(
                  name.isNotEmpty
                      ? name[0].toUpperCase()
                      : '?', //Hiển thị chữ cái đầu tiên của tên trong dba
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(description),
              trailing: const Icon(Icons.phone),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gọi cho $name...'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
