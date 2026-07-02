import 'package:flutter/material.dart';
import 'data/questions.dart';


void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Quiz Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  String _selectedLang = 'en'; // ڈیفالٹ زبان انگریزی ہے
  int _currentIndex = 0;
  int _score = 0;
  bool _quizFinished = false;

  // زبانوں کے خوبصورت ناموں کا نقشہ
  final Map<String, String> _langNames = {
    'en': 'English',
    'ur': 'اردو (Urdu)',
    'hi': 'हिंदी (Hindi)',
    'ar': 'العربية (Arabic)'
  };

  void _checkAnswer(String selectedOption, String correctAnswer) {
    setState(() {
      if (selectedOption == correctAnswer) {
        _score++;
      }
      
      final currentQuestions = questionBank[_selectedLang] ?? [];
      if (_currentIndex < currentQuestions.length - 1) {
        _currentIndex++;
      } else {
        _quizFinished = true;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _quizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestions = questionBank[_selectedLang] ?? [];
    final currentQuestion = currentQuestions.isNotEmpty ? currentQuestions[_currentIndex] : null;

    // اردو اور عربی کے لیے دائیں سے بائیں (RTL) لاجک
    final isRtl = _selectedLang == 'ur' || _selectedLang == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: const Text('MULTILINGUAL QUIZ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          // زبان تبدیل کرنے کا ڈراپ ڈاؤن مینیو
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (String langCode) {
              setState(() {
                _selectedLang = langCode;
                _resetQuiz(); // زبان بدلتے ہی کوئز شروع سے شروع ہوگا
              });
            },
            itemBuilder: (BuildContext context) {
              return _langNames.entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizFinished || currentQuestion == null
            ? Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
                        const SizedBox(height: 16),
                        const Text('QUIZ COMPLETED!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Your Score: $_score / ${currentQuestions.length}', style: const TextStyle(fontSize: 18, color: Colors.indigo, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _resetQuiz,
                          icon: const Icon(Icons.replay),
                          label: const Text('PLAY AGAIN'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // اسٹیٹس بار (انگلش میں)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Language: ${_langNames[_selectedLang]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Question: ${_currentIndex + 1}/${currentQuestions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / currentQuestions.length,
                    backgroundColor: Colors.grey[300],
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 32),
                  
                  // سوال کارڈ (زبان کے مطابق الائنمنٹ)
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        currentQuestion.questionText,
                        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
                        textAlign: isRtl ? TextAlign.right : TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // جوابات کے آپشن بٹنز
                  ...currentQuestion.options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: OutlinedButton(
                        onPressed: () => _checkAnswer(option, currentQuestion.correctAnswer),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Colors.indigo, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          option,
                          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                          style: const TextStyle(fontSize: 16, color: Colors.indigo, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                ],
              ),
      ),
    );
  }
}
