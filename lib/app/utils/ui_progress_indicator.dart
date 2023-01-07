import 'package:flutter/material.dart';

class UiProgressIndicator extends StatelessWidget {
  final String message;

  const UiProgressIndicator({
    Key? key,
    this.message = "Process...",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Material(
            elevation: 6.0,
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(message),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
