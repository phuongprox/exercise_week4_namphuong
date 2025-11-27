import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'package:flutter/material.dart';

/// Hàm entry point cho isolate phụ.
/// Phải là hàm top-level hoặc static.
void randomNumberSender(SendPort mainSendPort) {
  final secondaryReceivePort = ReceivePort();
  //Gửi SendPort của isolate phụ về cho isolate chính
  mainSendPort.send(secondaryReceivePort.sendPort);
  Timer? timer;
  //Bắt đầu gửi số ngẫu nhiên mỗi giây
  timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    final randomNumber = Random().nextInt(15) + 1; // Số ngẫu nhiên từ 1-15
    mainSendPort.send('[Isolate Phụ] Gửi số: $randomNumber');
    mainSendPort.send(randomNumber);
  });

  //Lắng nghe lệnh từ isolate chính
  secondaryReceivePort.listen((message) {
    if (message is String && message == 'STOP') {
      mainSendPort.send('[Isolate Phụ] Nhận lệnh STOP. Đang dừng...');
      timer?.cancel();
      secondaryReceivePort.close();
      Isolate.exit(); // Tự kết thúc isolate
    }
  });
}

class IsolateCommunicationPage extends StatefulWidget {
  const IsolateCommunicationPage({super.key});
  @override
  State<IsolateCommunicationPage> createState() =>
      _IsolateCommunicationPageState();
}

class _IsolateCommunicationPageState extends State<IsolateCommunicationPage> {
  int _total = 0;
  final List<String> _logs = [];
  Isolate? _secondaryIsolate;
  ReceivePort? _mainReceivePort;
  SendPort? _secondarySendPort;
  bool _isRunning = false;
  @override
  void dispose() {
    // Dọn dẹp khi widget bị hủy
    _stopIsolate();
    super.dispose();
  }

  void _startIsolate() async {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _logs.clear();
      _total = 0;
      _logs.add('[Isolate Chính] Bắt đầu...');
    });
    _mainReceivePort = ReceivePort();

    _secondaryIsolate = await Isolate.spawn(
      randomNumberSender,
      _mainReceivePort!.sendPort,
    );
    _mainReceivePort!.listen((message) {
      setState(() {
        if (message is SendPort) {
          _secondarySendPort = message;
          _logs.add('[Isolate Chính] Đã nhận SendPort từ isolate phụ.');
        } else if (message is int) {
          _total += message;
          if (_total > 100) {
            _logs.add('[Isolate Chính] Tổng > 100. Gửi lệnh STOP.');
            _secondarySendPort?.send('STOP');
            _stopIsolate(graceful: true);
          }
        } else if (message is String) {
          _logs.add(message);
        }
      });
    });
  }

  void _stopIsolate({bool graceful = false}) {
    if (!_isRunning) return;

    if (!graceful) {
      _secondaryIsolate?.kill(priority: Isolate.immediate);
      _logs.add('[Isolate Chính] Đã buộc dừng isolate phụ.');
    }
    _secondaryIsolate = null;
    _mainReceivePort?.close();
    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 6: Isolate Communication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tổng hiện tại: $_total',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isRunning ? null : _startIsolate,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Bắt đầu'),
                ),
                ElevatedButton.icon(
                  onPressed: _isRunning ? _stopIsolate : null,
                  icon: const Icon(Icons.stop),
                  label: const Text('Dừng'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Logs:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade200,
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) => Text(_logs[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
