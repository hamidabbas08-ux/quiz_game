import '../models/question.dart';

final Map<String, List<Question>> questionBank = {
  'en': [
    Question(questionText: "What is the capital of Pakistan?", options: ["Lahore", "Islamabad", "Karachi", "Peshawar"], correctAnswer: "Islamabad"),
    Question(questionText: "Which is the largest ocean on Earth?", options: ["Atlantic", "Indian", "Pacific", "Arctic"], correctAnswer: "Pacific"),
    Question(questionText: "How many days are there in a leap year?", options: ["365", "366", "364", "368"], correctAnswer: "366"),
  ],
  'ur': [
    Question(questionText: "پاکستان کا دارالحکومت کونسا شہر ہے؟", options: ["لاہور", "اسلام آباد", "کراچی", "پشاور"], correctAnswer: "اسلام آباد"),
    Question(questionText: "دنیا کا سب سے بڑا سمندر کونسا ہے؟", options: ["بحر اوقیانوس", "بحر ہند", "بحر الکاہل", "بحر منجمد شمالی"], correctAnswer: "بحر الکاہل"),
    Question(questionText: "قرآن پاک کی سب سے بڑی سورت کونسی ہے؟", options: ["سورت آل عمران", "سورت البقرہ", "سورت یٰسین", "سورت الرحمٰن"], correctAnswer: "سورت البقرہ"),
  ],
  'hi': [
    Question(questionText: "पाकिस्तान की राजधानी कौन सा शहर है?", options: ["लाहौर", "इस्लामाबाद", "कराची", "पेशावर"], correctAnswer: "इस्लामाबाद"),
    Question(questionText: "दुनिया का सबसे बड़ा महासागर कौन सा है?", options: ["अटलांटिक", "हिंद महासागर", "प्रशांत महासागर", "आर्कटिक"], correctAnswer: "प्रशांत महासागर"),
    Question(questionText: "एक लीप वर्ष में कितने दिन होते हैं?", options: ["365", "366", "364", "368"], correctAnswer: "366"),
  ],
  'ar': [
    Question(questionText: "ما هي عاصمة باكستان؟", options: ["لاهور", "إسلام آباد", "كراتشي", "بيشاور"], correctAnswer: "إسلام آباد"),
    Question(questionText: "ما هو أكبر محيط في العالم؟", options: ["الأطلسي", "الهندي", "الهادئ", "المتجمد الشمالي"], correctAnswer: "الهادئ"),
    Question(questionText: "ما هي أطول سورة في القرآن الكريم؟", options: ["آل عمران", "البقرة", "يس", "الرحمن"], correctAnswer: "البقرة"),
  ],
};
