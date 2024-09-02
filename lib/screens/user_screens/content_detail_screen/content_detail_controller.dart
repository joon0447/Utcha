import 'package:flutter/material.dart';

class ContentDetailController {
  // 상태 변수
  bool isFavorite = false; // 하트 버튼 상태 관리
  //지원 상태 관리 변수
  bool isSupported = false;

  // 데이터를 처리하는 함수들
  String imageUrl = ''; // 이미지 URL
  String title = '8인용 소파 내려주세요.';
  String description = '빌라에서 사용하던 소파 처분하려고 합니다. 8인용 소파 내려주실 분 구해요. 따로 엘리베이터는 없고, 계단으로 이동해야 합니다. 무게가 꽤 나가서 4명 정도 필요할 것 같습니다.';
  String location = '마포구 합정동';
  String day = '8월 16일 (금) 18:00'; //날짜 요일 시간
  String distance = '150';
  int numberOfPeople = 4;
  String pricePerPerson = '20,000';
  int dDay = 2;
  String elevator = '없음';
  String together = 'X';
  String gender = '무관';
  List<String> nearbyPosts = ['게시물1', '게시물2', '게시물3', '게시물4']; // 근처 게시물

  // 하트 팝업 함수
  void showHeartPopup(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Icon(
          Icons.favorite,
          color: Colors.black,
          size: 100,
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // 0.5초 후에 팝업 제거
    Future.delayed(Duration(milliseconds: 500), () {
      overlayEntry.remove();
    });
  }

  void toggleFavoriteStatus(BuildContext context) {
    isFavorite = !isFavorite;
    if (isFavorite) {
      showHeartPopup(context);
    }
  }

  void toggleSupportStatus(BuildContext context) {
    isSupported = !isSupported;
  }
}
