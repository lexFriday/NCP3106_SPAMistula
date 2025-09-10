import 'package:flutter/material.dart';

class TestSection extends StatelessWidget {
  const TestSection({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building TestSection');
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'TEST SECTION - This should be visible',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

