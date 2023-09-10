
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String? loadingMessage;
  final Color? color;

  Loader({Key? key, this.loadingMessage, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
