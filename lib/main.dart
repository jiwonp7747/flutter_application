import 'package:flutter/material.dart';
import 'package:flutter_application_3/button_horiz_rail.dart';
import 'package:flutter_application_3/content_card.dart';
import 'package:flutter_application_3/my_appbar.dart';
import 'package:flutter_application_3/boarder_input_page.dart';
import 'board.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // jsonDecode 사용을 위해 import 해준다. 
import 'package:shared_preferences/shared_preferences.dart';
import 'app_constant.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async { //최
  WidgetsFlutterBinding.ensureInitialized();  // 플러그인 초기화를 위해 필요

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  // User user = FirebaseAuth.instance.currentUser!;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late String title;

  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late Future<List<Board>> futureBoards;
  // String baseUrl = 'http://192.168.0.10:8080'; // 나중에는 서버 주소로 변경해야 함.
  String baseUrl = 'http://223.194.153.183:8080';
  @override
  void initState() {
     super.initState();    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadData();
      setState(() {
        futureBoards = fetchBoards();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(baseUrl)),
      );
    });
  }
  
  Future<User?> _signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          return null; // 사용자가 로그인 프로세스를 취소했을 경우
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      } catch (e) {
        print(e);
        return null;
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar.withValue(
        title: 'Flutter', 
        actions: const[
          Icon(Icons.tv),
          Icon(Icons.notifications),
          Icon(Icons.search),
        ], 
        leading: const Icon(Icons.home)
      ),
      body: LayoutBuilder( // 위젯을 반환하는 함수가 필요 
        builder: (context, constraints) {
          return ConstrainedBox(constraints: const BoxConstraints(
              minWidth: 300,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4,
                  ),
                  Container(
                    child: const ButtonHorizRail(items: ['동영상', '게임', '음악', '나중에 볼 영상', '좋아요 한 영상'],),
                  ),
                  Container(
                    height: 8,
                  ),
                  FutureBuilder(
                    future: futureBoards, 
                    builder: (context, snapshot) {
                     if(snapshot.connectionState==ConnectionState.waiting){
                       return const CircularProgressIndicator();

                      }else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                        return const Text('No data');
                      }else{
                        return Column(
                          children: snapshot.data!.map((e) => ContentCard(board: e, baseUrl: baseUrl,)).toList(),
                          
                        );
                      }
                    }
                  ),
            
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.white),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BoardInputPage(userId: '1', baseUrl: baseUrl,))
                );
                
                print('result: $result');
                // 업로드 결과가 성공적으로 이루어졌다면..
                if (result == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('게시글이 성공적으로 업로드되었습니다.')),
                  );
                  
                  setState(() {                    
                    futureBoards = fetchBoards(); // 게시글 목록 다시 불러오기           
                  });
                } 
              }              
            ),
          ],
        ),
      )
    
    );
  }
  
  Future<List<Board>> fetchBoards() async {
    if (baseUrl.isEmpty) {
      baseUrl = AppConstants.baseUrlDefault;
    }

    final response = await http.get(
        Uri.parse('$baseUrl/api/board/page?page=0&pageSize=20'),        
        headers: {'content-type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      return (json.decode(utf8.decode(response.bodyBytes))['content'] as List)
          .map((data) => Board.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load boards');
    }
  }


  Future<void> _saveData(Map<String, dynamic> data) async {
      final prefs = await SharedPreferences.getInstance();
      for (var entry in data.entries) {
        await prefs.setString(entry.key, entry.value.toString());
      }
      // await prefs.setString(key, value);
    }

  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // SharedPreferences에 저장된 값이 없을 경우, AppConstants에 정의된 기본값을 사용한다.
      baseUrl = prefs.getString(AppConstants.baseUrlKey) ?? AppConstants.baseUrlDefault;
    } catch (e) {
      baseUrl = AppConstants.baseUrlDefault;
      print('Error: $e');
    }
    
  }
  
}

class MyText extends StatelessWidget {
  final String text;
  final int condition;

  MyText({super.key, this.text='MyText', this.condition=0});
  
  @override
  Widget build(BuildContext context) {

    Color color;
    switch (condition) {
      case 0:
        color = Colors.black;
        break;
      case 1:
        color = Colors.red;
        break;
      case 2:
        color = Colors.blue;
        break;
      default:
        color = Colors.black;
    }

    TextStyle? style = TextStyle(color: color, fontSize: 16);

    return Text('MyText', style:style,);
  }
}