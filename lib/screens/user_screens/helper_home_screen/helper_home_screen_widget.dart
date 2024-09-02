import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../content_detail_screen/content_detail_widget.dart';
import '../mypage_screen/mypage_widget.dart';
import '../address_screen/address_input_widget.dart';
import '../notification_screen/notification_widget.dart';

class HelperHomeScreen extends StatefulWidget {
  const HelperHomeScreen({super.key});

  @override
  State<HelperHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HelperHomeScreen> {
  String? _selectedAddress;
  String? _selectedSortOption = '거리 순'; // 두 번째 드롭다운의 기본값 설정
  List<String> _addressItems = []; // 드롭다운에 보여줄 주소 목록
  List<String> _sortOptions = ['거리 순', '최근 등록 순', '금액 높은 순', '신청자 적은 순']; // 두 번째 드롭다운 옵션

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        List<dynamic> addresses = userDoc.get('addresses') ?? [];
        setState(() {
          _addressItems = addresses.map((address) {
            Map<String, dynamic> addressMap = address as Map<String, dynamic>;
            return addressMap['address'] as String? ?? '';
          }).toList();
        });
      }
    }

    _addressItems.add('주소 추가하기');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Image.asset(
          'assets/utcha_logo.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationWidget()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('내 주소를 설정해주세요'),
                    icon: Icon(Icons.expand_more, color: Colors.black),
                    iconSize: 24,
                    value: _selectedAddress,
                    items: _addressItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == '주소 추가하기') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddressInputScreen(),
                          ),
                        ).then((_) {
                          _loadAddresses();
                        });
                      } else {
                        setState(() {
                          _selectedAddress = newValue;
                        });
                      }
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return _addressItems.map<Widget>((String value) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, right: 8.0),
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                SizedBox(width: 30),

                //거리순 드롭다운 버튼
                DropdownButton<String>(
                  value: _selectedSortOption,
                  icon: Icon(Icons.expand_more, color: Colors.black),
                  iconSize: 24,
                  items: _sortOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: SizedBox(
                        width: 100,
                        child: Text(option),
                      )
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSortOption = newValue;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: ListView.builder(
                itemCount: 10, // 임시로 10개
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('8월 16일 (금) 18:00 대덕구 오정동'),
                        const Text('8인용 소파 내려주세요.'),
                        const Text('4명 모집 | 인당 10,000원 | 1일 전'),
                      ],
                    ),
                    trailing: Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentDetailWidget(), // ContentDetailWidget으로 이동
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () {
                // 홈 버튼
              },
            ),
            IconButton(
              icon: Icon(Icons.chat, color: Colors.black),
              onPressed: () {
                // 채팅
              },
            ),
            IconButton(
              icon: Icon(Icons.history, color: Colors.black),
              onPressed: () {
                // 이용 내역
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MypageScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
