// lib/widgets/news_category_widget.dart
import 'package:flutter/material.dart';
// import 'package:news_summary_app/services/news_service.dart'; // 後で作成
// import 'package:news_summary_app/services/gemini_service.dart'; // 後で作成

class NewsCategoryWidget extends StatefulWidget {
  final String category;

  const NewsCategoryWidget({super.key, required this.category});

  @override
  State<NewsCategoryWidget> createState() => _NewsCategoryWidgetState();
}

class _NewsCategoryWidgetState extends State<NewsCategoryWidget> {
  List<String> _summarizedNews = []; // 要約されたニュースのリスト
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAndSummarizeNews();
  }

  Future<void> _fetchAndSummarizeNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // 実際にはここでニュースAPIから記事を取得
      // 例: List<Article> rawArticles = await NewsService.fetchNews(widget.category);

      // ここではダミーデータを使用
      List<String> dummyArticles = [
        'テクノロジーニュース1の本文。AIの進化について。',
        'テクノロジーニュース2の本文。新しいスマートフォンの発表。',
        'テクノロジーニュース3の本文。サイバーセキュリティの脅威。',
        // 実際にはもっと多くの記事を取得し、Geminiで要約
      ];

      List<String> summarized = [];
      // 実際のGemini要約処理はここで行う
      // for (var article in dummyArticles) {
      //   String summary = await GeminiService.summarizeText(article);
      //   summarized.add(summary);
      //   if (summarized.length >= 3) break; // 3つまで表示
      // }

      // ダミーの要約
      summarized = [
        'AIの進化が止まらない。',
        '最新のスマートフォンが登場。',
        'サイバー攻撃への対策が急務。'
      ];


      setState(() {
        _summarizedNews = summarized;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'ニュースの取得または要約に失敗しました: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.category}ニュース',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _summarizedNews.map((news) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text('• $news'),
                        )).toList(),
                      ),
            // Refreshボタン（任意）
            if (!_isLoading)
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _fetchAndSummarizeNews,
                  tooltip: '更新',
                ),
              ),
          ],
        ),
      ),
    );
  }
}