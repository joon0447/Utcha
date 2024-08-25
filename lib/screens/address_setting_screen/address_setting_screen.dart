import 'package:flutter/material.dart';

class AddressSettingScreen extends StatefulWidget {
  const AddressSettingScreen({super.key});

  @override
  State<AddressSettingScreen> createState() => _AddressSettingScreenState();
}

class _AddressSettingScreenState extends State<AddressSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        title: const Text("주소 설정",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),  
      ),
    );
  }
}