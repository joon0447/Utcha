import 'package:flutter/material.dart';

class JoinPostScreen extends StatefulWidget {
  const JoinPostScreen({super.key});

  @override
  State<JoinPostScreen> createState() => _JoinPostScreenState();
}

class _JoinPostScreenState extends State<JoinPostScreen> {
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
          "참여한 글",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
