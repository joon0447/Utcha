
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void ChangeDialog(BuildContext context) async{
  String? result = await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return AlertDialog(
        title: const Text("닉네임을 변경하시겠어요?"),
        content: const Text("닉네임은 90일에 한 번 변경 가능합니다."),
        actions: <Widget[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:  const Color.fromARGB(99, 224, 224, 224),
                  ),
                  child: const Text("취소", style: TextStyle(fontSize: 17, 
                  fontWeight: FontWeight.w600, 
                  color:Color.fromARGB(98, 139, 139, 139),
                  ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:  const Color.fromARGB(255, 48, 48, 48),
                  ),
                  child: const Text("변경하기" ,style: TextStyle(fontSize: 17, 
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  );
}