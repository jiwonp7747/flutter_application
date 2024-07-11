import 'package:flutter/material.dart';

class MyAppbar extends AppBar {
  
    MyAppbar.withValue({
      super.key,
      required String title,
      required List<Icon> actions,
      required Icon leading,
    }
  ):super(
    backgroundColor: Colors
      .black,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row( // AppBar의 앞부분, 홈아이콘, 타이틀 
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading, // 홈 아이콘, withValue() 생성자에서 입력으로 받음 
            SizedBox(width: 10), 
            Text(title, style: const TextStyle(color: Colors.white),), // 타이틀, withValue() 생성자에서 입력으로 받음 
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: actions[0],
              color: Colors.white,
              onPressed: () => {},
            ),
            const SizedBox(width: 4), 
            IconButton(
              icon: actions[1],
              color: Colors.white,
              onPressed: () => {},
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: actions[2],
              color: Colors.white,
              onPressed: () => {},
            ),
          ],
        ),
      ],
    ),
  );
}
