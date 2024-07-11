class Board{
  final int id;
  final String title;
  final String text;
  final int like;
  final int unlike;
  final int userId;
  final String userEmail;
  final String userNickName;
  final List<String> imageUrls;

  const Board({
    required this.id,
    required this.title,
    required this.text,
    required this.like,
    required this.unlike,
    required this.userId,
    required this.userEmail,
    required this.userNickName,
    required this.imageUrls,
  });

    factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      like: json['like'],
      unlike: json['unlike'],
      userId: json['userId'],
      userEmail: json['userEmail'],
      userNickName: json['userNickName'],
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }

  
}