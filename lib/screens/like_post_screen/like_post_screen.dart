import 'package:flutter/material.dart';

class LikePostScreen extends StatefulWidget {
  const LikePostScreen({super.key});

  @override
  State<LikePostScreen> createState() => _LikePostScreenState();
}

class _LikePostScreenState extends State<LikePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "좋아요한 글",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
