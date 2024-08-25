import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
          },
        ),
        title: const Text("서비스 이용 약관",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: const Menu(text: "서비스 이용 약관",)),
            GestureDetector(
              onTap: () {},
              child: const Menu(text: "개인정보 수집 및 이용 동의")),
            GestureDetector(
              onTap: () {},
              child: const Menu(text: "위치기반 서비스 약관 동의")),
        ],),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final String text;
  const Menu({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.grey, size: 18),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}