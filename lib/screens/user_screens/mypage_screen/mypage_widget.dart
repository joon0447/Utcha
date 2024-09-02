import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'mypage_controller.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  late MypageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MypageController();
    _controller.loadUserProfile();
  }

  void _showImageSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택하기'),
                onTap: () {
                  Navigator.of(context).pop();
                  _controller.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 촬영하기'),
                onTap: () {
                  Navigator.of(context).pop();
                  _controller.pickImage(ImageSource.camera);
                },
              ),
              if (_controller.profileImageUrl.value !=
                  'https://firebasestorage.googleapis.com/v0/b/utcha-7d76e.appspot.com/o/user_profile%2Fprofile.png?alt=media&token=a1f4f763-a467-4c0c-8e93-8e88f0f9c848')
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('프로필 이미지 삭제'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _controller.deleteProfileImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('마이페이지'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              '프로필 설정',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: _controller.profileImageUrl,
                  builder: (context, profileImageUrl, child) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      profileImageUrl.isNotEmpty ? NetworkImage(profileImageUrl) : null,
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _showImageSourceSelector(context),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 28,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),

            //닉네임
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '닉네임',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller.nicknameController,
              decoration: const InputDecoration(
                hintText: '닉네임을 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _controller.isNicknameValid = _controller.validateNickname(value);
                });
              },
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '닉네임은 2~6글자의 한글, 숫자만 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

            //자기소개
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '자기소개',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller.selfIntroductionController,
              decoration: const InputDecoration(
                hintText: '자기소개를 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _controller.isSelfIntroductionValid = _controller.validateSelfIntroduction(value);
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _controller.isNicknameValid || _controller.isSelfIntroductionValid
                    ? () async {
                  await _controller.saveNickname(context);
                  await _controller.saveSelfIntroduction(context);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _controller.isNicknameValid || _controller.isSelfIntroductionValid ? Colors.black : Colors.grey,
                ),
                child: const Text(
                  '저장',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}