// lib/main.dart
import 'package:flutter/material.dart';
import 'package:news_summary_app/widgets/news_category_widget.dart'; // 後で作成

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI News Summary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 今後、ユーザーが追加するウィジェットのリストを管理する
  final List<Widget> _homeWidgets = [
    // 最初のウィジェットとしてニュースカテゴリを表示
    NewsCategoryWidget(category: 'テクノロジー'),
    NewsCategoryWidget(category: 'エンターテイメント'),
    NewsCategoryWidget(category: 'スポーツ'),
    // 必要に応じて他のカテゴリも追加
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AIニュースダッシュボード'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _homeWidgets.map((widget) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // ウィジェット間のスペース
              child: widget,
            )).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 後々、ウィジェットを追加するUIを実装
          print('新しいウィジェットを追加');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}