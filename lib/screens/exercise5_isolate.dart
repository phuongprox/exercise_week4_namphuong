import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Hàm tính giai thừa. Phải là hàm top-level hoặc static để compute có thể gọi.
BigInt _calculateFactorial(int number) {
  if (number < 0) return BigInt.zero;
  BigInt result = BigInt.one;
  for (int i = 2; i <= number; i++) {
    result *= BigInt.from(i);
  }
  return result;
}

class FactorialPage extends StatefulWidget {
  const FactorialPage({super.key});

  @override
  State<FactorialPage> createState() => _FactorialPageState();
}

class _FactorialPageState extends State<FactorialPage> {
  final _numberController = TextEditingController(text: '20');
  String _result = 'Kết quả sẽ hiển thị ở đây.';
  bool _isCalculating = false;
  Future<void> _runFactorialCalculation() async {
    final number = int.tryParse(_numberController.text);
    if (number == null || number < 0) {
      setState(() {
        _result = 'Vui lòng nhập một số nguyên không âm.';
      });
      return;
    }
    setState(() {
      _isCalculating = true;
      _result = 'Đang tính toán...';
    });
    // Sử dụng compute để chạy hàm _calculateFactorial trên một isolate khác
    final factorialResult = await compute(_calculateFactorial, number);
    setState(() {
      _isCalculating = false;
      _result = 'Giai thừa của $number là:\n${factorialResult.toString()}';
    });
  }

  @override //GỌi giao diện bài 5
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 5: Isolate - Tính giai thừa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Nhập số để tính giai thừa',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isCalculating ? null : _runFactorialCalculation,
              child: _isCalculating
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Tính toán'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Kết quả:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  color: Colors.grey.shade200,
                  child: SelectableText(
                    _result,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
