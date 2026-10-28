import 'package:flutter/material.dart';

class Ecran extends StatelessWidget {
  const Ecran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "premier exemple",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 2,
      ),
      body: const Center(
        child: Text("hello world"),
      ),
    );
  }
}
