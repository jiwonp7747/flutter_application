
import 'package:flutter/material.dart';
import 'package:flutter_application_3/board.dart';


class ContentCard extends StatelessWidget{

  final Board board;
  final String baseUrl;

  const ContentCard({
    super.key,
    required this.board,
    required this.baseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          Stack( //레이어드 하는 위젯 
            children: [
              (board.imageUrls.isEmpty) ?
              Image.asset('assets/images/0.webp', fit: BoxFit.cover, width: double.infinity,) :
              Image.network('$baseUrl${board.imageUrls[0]}', fit: BoxFit.cover, width: double.infinity,), // 메인 이미지 
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(board.title, style: TextStyle(color: Colors.white, fontSize: 12),),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row( // 영상 아래 아이콘과 타이틀 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/1.webp'),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 12,
                  child: Column( //메인타이틀과 서브타이틀을 나누기 위해 
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(board.text, style: const TextStyle(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis,),
                      //TextOverflow.ellipsis: 글자가 너무 길어서 표시되지 않을 때 ...으로 표시 
                      Text(board.userNickName, style: const TextStyle(fontSize: 12, color: Colors.grey, overflow: TextOverflow.ellipsis,),),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}