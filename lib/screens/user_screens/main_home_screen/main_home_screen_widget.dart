import 'package:flutter/material.dart';

import '../helper_home_screen/helper_home_screen_widget.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset(
          'assets/utcha_logo.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // 알림 페이지 이동
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                '읏차와 함께 빠르고 간단하게\n물건을 버려보세요!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              //버리기 버튼
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 물건 버리기
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('물건 버리기'),
                            SizedBox(height: 8),
                            Text('혼자 버리기 힘든\n물건 버리기'),
                            SizedBox(height: 8),
                            Icon(Icons.image, size: 50), // 이미지 자리
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 70), // 버튼 높이
                        backgroundColor: Colors.white, // 버튼 배경색
                        foregroundColor: Colors.black, // 버튼 텍스트색
                        side: BorderSide(color: Colors.black), // 테두리 색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelperHomeScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('물건 버려주기'),
                            SizedBox(height: 8),
                            Text('내 주변 사람\n물건 버려주기'),
                            SizedBox(height: 8),
                            Icon(Icons.image, size: 50), // 이미지 자리
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 70), // 버튼 높이 설정
                        backgroundColor: Colors.white, // 버튼 배경색 설정
                        foregroundColor: Colors.black, // 버튼 텍스트 색상 설정
                        side: BorderSide(color: Colors.black), // 테두리 색상
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // 모서리 라운딩 10
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // 읏차 서비스 사용법
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('읏차 서비스 사용법 확인하기'),
                    Icon(Icons.image, size: 50), // 이미지 자리
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // 버튼 배경색 설정
                  foregroundColor: Colors.black, // 버튼 텍스트 색상 설정
                  side: BorderSide(color: Colors.black), // 테두리 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // 모서리 라운딩 10
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // 스티커 구매하기
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('스티커 구매하기'),
                    Icon(Icons.image, size: 50), // 이미지 자리
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // 버튼 배경색 설정
                  foregroundColor: Colors.black, // 버튼 텍스트 색상 설정
                  side: BorderSide(color: Colors.black), // 테두리 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // 모서리 라운딩 10
                  ),
                ),
              ),
              SizedBox(height: 20),

              // EventBanner 자리
              Container(
                height: 100,
                color: Colors.grey[300], // 배너 자리
                child: Center(child: Text('EventBanner')),
              ),
              SizedBox(height: 20),

              //읏차 사전
              Text(
                '읏차 사전',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // 읏차 사전 버튼들
              ElevatedButton(
                onPressed: () {
                },
                child: Text('대형 폐기물에는 어떤 것들이 해당되나요?'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // 버튼 배경색 설정
                  foregroundColor: Colors.black, // 버튼 텍스트 색상 설정
                  side: BorderSide(color: Colors.black), // 테두리 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // 모서리 라운딩 10
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

