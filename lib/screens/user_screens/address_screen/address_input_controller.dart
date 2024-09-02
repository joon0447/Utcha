import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class AddressInputController {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController detailAddressController = TextEditingController();

  Future<void> saveAddress(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        List<Map<String, String>> addresses = [];

        if (userDoc.exists) {
          List<dynamic> fetchedAddresses = userDoc.get('addresses') ?? [];
          addresses = fetchedAddresses.map((address) {
            return (address as Map<String, dynamic>).map(
                  (key, value) => MapEntry(key as String, value as String),
            );
          }).toList();
        }

        Map<String, String> newAddress = {
          'address': addressController.text,
          'detailAddress': detailAddressController.text,
        };

        if (addresses.length < 3) {
          addresses.add(newAddress);
        } else {
          addresses[0] = newAddress;
        }

        addresses = List<Map<String, String>>.from(addresses.reversed);

        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'addresses': addresses,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('주소가 성공적으로 저장되었습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('주소 저장 중 오류가 발생했습니다: $e')),
      );
    }
  }

  Future<void> searchAddress(BuildContext context) async {
    KopoModel? model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    if (model != null) {
      addressController.text = '${model.address} ${model.buildingName ?? ''}'.trim();
    }
  }
}
