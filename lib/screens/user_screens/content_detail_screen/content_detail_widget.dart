import 'package:flutter/material.dart';
import 'package:utcha/screens/user_screens/support_complete_screen/support_complete_widget.dart';
import 'content_detail_controller.dart';

class ContentDetailWidget extends StatefulWidget {
  const ContentDetailWidget({super.key});

  @override
  _ContentDetailWidgetState createState() => _ContentDetailWidgetState();
}

class _ContentDetailWidgetState extends State<ContentDetailWidget> {
  final ContentDetailController _controller = ContentDetailController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //사진
            Container(
              height: 300,
              color: Colors.grey[300],
              child: _controller.imageUrl.isNotEmpty
                  ? Image.network(_controller.imageUrl, fit: BoxFit.cover)
                  : Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //제목 텍스트
                  Text(
                    _controller.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  // 설명 텍스트
                  Text(
                    '${_controller.day} ${_controller.location} ${_controller.distance} m 이내',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${_controller.numberOfPeople}명 모집 | 인당 ${_controller.pricePerPerson}원 | D-${_controller.dDay}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '엘리베이터 ${_controller.elevator} | 함께 운반 ${_controller.together} | 성별 ${_controller.gender}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),

                  //상세설명
                  Text(
                    _controller.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  // 위치 컨텐츠
                  Text(
                    '위치',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 150, // 위치를 보여주는 칸의 높이
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.map, size: 50, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '상세 주소는 수거 당일 확인 가능합니다.',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  SizedBox(height: 24),

                  // 해당 장소 근처 게시물
                  Text(
                    '해당 장소 근처 게시물',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8, //행 간격
                      crossAxisSpacing: 25, //수평 간격
                      childAspectRatio: 1, //정사각형
                    ),
                    itemCount: _controller.nearbyPosts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(Icons.image,
                                    size: 50, color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _controller.nearbyPosts[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),

                  // 추천 광고 배너
                  Text(
                    '[닉네임] 위한 추천',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('Banner1', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('Banner2', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                _controller.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _controller.isFavorite ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _controller.toggleFavoriteStatus(context);
                });
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.isSupported) {
                    _showCancelConfirmationDialog(context);
                  } else {
                    _showConfirmationDialog(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  _controller.isSupported ? '지원 취소하기' : '지원하기',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 지원하기 다이얼로그
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_controller.day}에\n내려드림을 지원하시겠어요?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '작성자가 승인할 경우, 최종 확정됩니다.',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // 취소 버튼
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16), //버튼 사이 간격
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _controller.toggleSupportStatus(context);
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SupportCompleteWidget(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16.0), //버튼 높이
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white, // 흰색 글씨색상
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      barrierDismissible: true, // 다이얼로그 바깥을 눌렀을 때 닫히게 설정
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  // 지원 취소하기 다이얼로그
  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '지원을 취소하시겠습니까?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '취소 후에는 다시 지원할 수 있습니다.',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // 취소 버튼
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16), //버튼 사이 간격
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _controller.toggleSupportStatus(context);
                          });
                          Navigator.of(context).pop(); // 확인을 누르면 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16.0), //버튼 높이
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white, // 흰색 글씨색상
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      barrierDismissible: true, // 다이얼로그 바깥을 눌렀을 때 닫히게 설정
      barrierColor: Colors.black.withOpacity(0.5), // 배경을 반투명하게
    );
  }
}
