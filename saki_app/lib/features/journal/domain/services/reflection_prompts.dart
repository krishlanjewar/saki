import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reflection_prompts.g.dart';

class ReflectionPrompts {
  static const List<String> _prompts = [
    "What made you smile today?",
    "What did you learn today?",
    "What are you grateful for right now?",
    "How could today have been better?",
    "What's a challenge you overcame recently?",
    "Describe a moment of peace you had today.",
    "What are you looking forward to tomorrow?",
    "Who made a positive impact on your day?",
    "What is something you want to let go of?",
    "What made you feel proud today?",
  ];

  static String getPromptForToday() {
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return _prompts[dayOfYear % _prompts.length];
  }
}

@riverpod
String dailyPrompt(Ref ref) {
  return ReflectionPrompts.getPromptForToday();
}
