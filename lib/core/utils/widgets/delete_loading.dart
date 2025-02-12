import 'package:flutter/material.dart';

class DeleteLoading extends StatelessWidget {
  const DeleteLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
