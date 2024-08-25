import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utcha/functions/phoneNumberFormat.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  String uid = 'aESOL5i5KtG2VnM8X6Au'; // 임시

  getUserInfo() async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return result.data();
  }
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
        title: const Text("계정 정보",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          String phoneNumber = formatPhoneNum('0${(snapshot.data as Map)['phoneNumber'].toString().substring(3)}');
          TextEditingController nameController = TextEditingController(text: (snapshot.data as Map)['displayName']);
          TextEditingController phoneController = TextEditingController(text : phoneNumber);
          return snapshot.hasData 
          ? Padding(padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  const Text("이름", style: TextStyle(fontSize: 15),),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )
                      ),
                    ),
                  ),
                  const Text("휴대폰 번호", style: TextStyle(fontSize: 15),),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )
                      ),
                    ),
                  ),
                ],
              )
            ],
            ),
            ) : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}