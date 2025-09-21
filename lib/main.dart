import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/my_bag_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/my_bag',
  routes: [
    GoRoute(
      path: '/my_bag',
      builder: (context, state) => const MyBagScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
