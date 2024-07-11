import 'package:flutter/material.dart';

class ButtonHorizRail extends StatelessWidget{

  final List<String> items; // 버튼들에 들어갈 텍스트
  final double spacing; // 버튼들 사이의 간격 

  
  const ButtonHorizRail({
    super.key,
    required this.items,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 스트링 리스트를 입력으로 받아서 버튼들을 수평방향 리스트 아이템으로 생성 
          ...List.generate(items.length, (index){
            return Padding(
              padding: EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 46, 46, 46)),
                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10),
                     ),
                   ),
                  ),
                ),
                child: Text(items[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                 // 버튼에 텍스트 추가
              ),
            );
          }),
        ],
      ),
    );
}
}