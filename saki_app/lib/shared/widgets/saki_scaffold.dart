import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'saki_drawer.dart';

class SakiScaffold extends ConsumerWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const SakiScaffold({
    super.key,
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      drawer: const SakiDrawer(),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
