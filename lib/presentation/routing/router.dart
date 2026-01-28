import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herodex/presentation/pages/detail_screen.dart';
import 'package:herodex/presentation/pages/home.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Router App')),
      body: child, // router swaps this part
      bottomNavigationBar: Row(
        children: [
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: Icon(Icons.home),
          ),
          ElevatedButton(
            onPressed: () => context.go('/details'),
            child: Icon(Icons.details),
          ),
        ],
      ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(title: ''),
        ),
        GoRoute(path: '/details', builder: (context, state) => DetailsScreen()),
      ],
    ),
  ],
);
