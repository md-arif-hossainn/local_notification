import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key, required this.payload});
  final String payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
      ),
      body: Column(
        children: [
          Text('this is your $payload')
        ],
      ),
    );
  }
}
