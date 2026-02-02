import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Heroes')),
      body: Center(
        child: Text(
          'This is the Saved Heroes Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
