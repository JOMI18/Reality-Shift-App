import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundLottieScaffold extends StatelessWidget {
  final String lottieAnimationPath;

  BackgroundLottieScaffold({required this.lottieAnimationPath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Lottie animation
        Positioned.fill(
          child: Lottie.asset(
            lottieAnimationPath,
            fit: BoxFit.cover,
          ),
        ),
        // Scaffold with content
        Scaffold(
          backgroundColor: Colors.transparent, // Makes the scaffold background transparent
          appBar: AppBar(
            title: const Text('Title'),
            backgroundColor: Colors.transparent, // Makes the AppBar background transparent
            elevation: 0, // Removes the AppBar shadow
          ),
          body: const Center(
            child: Text(
              'Content goes here',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BackgroundLottieScaffold(
      lottieAnimationPath: 'lib/assets/images/lottie/todo.json',
    ),
  ));
}
