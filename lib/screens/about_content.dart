import 'package:flutter/material.dart';
import 'about_simple.dart';
import 'main_layout.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: const AboutSimple(),
    );
  }
}
