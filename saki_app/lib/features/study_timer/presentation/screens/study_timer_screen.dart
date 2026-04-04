import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/saki_scaffold.dart';
import '../../../../core/constants/app_strings.dart';

class StudyTimerScreen extends ConsumerWidget {
  const StudyTimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SakiScaffold(
      title: AppStrings.studyTimer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '25:00',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // start timer
              },
              child: const Text('Start Focus'),
            )
          ],
        ),
      ),
    );
  }
}
