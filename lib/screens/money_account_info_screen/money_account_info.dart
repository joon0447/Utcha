import 'package:flutter/material.dart';

class MoneyAccountInfo extends StatefulWidget {
  const MoneyAccountInfo({super.key});

  @override
  State<MoneyAccountInfo> createState() => _MoneyAccountInfoState();
}

class _MoneyAccountInfoState extends State<MoneyAccountInfo> {
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
        title: const Text("계좌 관리",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      ),
    );
  }
}