import 'package:flutter/material.dart';

class AdjustmentScreen extends StatefulWidget {
  const AdjustmentScreen({super.key});

  @override
  State<AdjustmentScreen> createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text("정산 관리",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      ),
    );
  }
}