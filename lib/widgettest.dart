import 'package:bunbunmart/utilities/popups/bun_popup.dart';
import 'package:flutter/material.dart';

class LoaderTestWidget extends StatelessWidget {
  const LoaderTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            key: const Key('showLoaderButton'),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const PopupLoader(message: "Loading. . ."),
              );
            },
            child: const Text("Show Loader"),
          ),
        ),
      ),
    );
  }
}
