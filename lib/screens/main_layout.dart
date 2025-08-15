import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Header(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            widget.child,
            Footer(onScrollToTop: _scrollToTop),
          ],
        ),
      ),
    );
  }
}
