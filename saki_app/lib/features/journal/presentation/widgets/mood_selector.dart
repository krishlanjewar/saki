import 'package:flutter/material.dart';
import '../../domain/models/journal_entry.dart';

class MoodSelector extends StatelessWidget {
  final Mood selectedMood;
  final ValueChanged<Mood> onChanged;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,   
      children: const [Mood.excited, Mood.happy, Mood.calm, Mood.stressed, Mood.sad].map((mood) {
        final isSelected = selectedMood == mood;
        return GestureDetector(
          onTap: () => onChanged(mood),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? _getMoodColor(mood).withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? _getMoodColor(mood) : Colors.transparent,
                width: 2,
              ),
            ),
            child: Text(
              _getMoodEmoji(mood),
              style: TextStyle(fontSize: isSelected ? 32 : 24),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getMoodEmoji(Mood mood) {
    switch (mood) {
      case Mood.excited:
        return '🤩';
      case Mood.happy:
        return '😊';
      case Mood.calm:
        return '😌';
      case Mood.stressed:
        return '😫';
      case Mood.sad:
        return '😢';
    }
  }

  Color _getMoodColor(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return Colors.green;
      case Mood.calm:
        return Colors.blue;
      case Mood.excited:
        return Colors.orange;
      case Mood.stressed:
        return Colors.grey;
      case Mood.sad:
        return Colors.red;
    }
  }
}
