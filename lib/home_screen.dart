import 'package:flutter/material.dart';

class MainHomeContent extends StatefulWidget {
  const MainHomeContent({super.key});

  @override
  State<MainHomeContent> createState() => _MainHomeContentState();
}

class _MainHomeContentState extends State<MainHomeContent> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "Hello every body",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
    );
  }
}
