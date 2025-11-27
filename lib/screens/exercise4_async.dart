import 'package:flutter/material.dart';

class AsyncLoadingPage extends StatefulWidget {
  const AsyncLoadingPage({super.key});
  @override //Gọi trạng thái của widget
  State<AsyncLoadingPage> createState() => _AsyncLoadingPageState();
}

class _AsyncLoadingPageState extends State<AsyncLoadingPage> {
  String _message = "Nhấn nút để bắt đầu tải...";
  bool _isLoading = false;
  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
      _message = "Loading user...";
    });
    // Chờ 3 giây :>
    await Future.delayed(const Duration(seconds: 3));
    // Cập nhật giao diện sau khi chờ xong
    if (mounted) {
      // Kiểm tra widget còn tồn tại không
      setState(() {
        _isLoading = false;
        _message = "User loaded successfully!";
      });
    }
  }

  @override //Goi giao diện bài 4
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 4: Async Loading')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isLoading ? null : _loadUser,
              child: const Text('Tải người dùng'),
            ),
          ],
        ),
      ),
    );
  }
}
