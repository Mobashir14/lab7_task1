import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _remainingTime = 10; // Countdown start time
  bool _isRunning = false; // Tracks whether the timer is active

  Future<void> startTimer() async {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _remainingTime = 10; // Reset the timer
    });

    while (_remainingTime > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return; // Ensure the widget is still mounted
      setState(() {
        _remainingTime--;
      });
    }

    setState(() {
      _isRunning = false; // Timer finished
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Countdown Timer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerDisplay(remainingTime: _remainingTime),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? null : startTimer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                _isRunning ? 'Running...' : 'Start Timer',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Timer Display Widget
class TimerDisplay extends StatelessWidget {
  final int remainingTime;

  const TimerDisplay({Key? key, required this.remainingTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time Remaining: $remainingTime seconds',
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
