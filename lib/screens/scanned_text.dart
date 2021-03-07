import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ScannedText extends StatefulWidget {
  final String text;
  ScannedText(this.text);
  @override
  _ScannedTextState createState() => _ScannedTextState();
}

class _ScannedTextState extends State<ScannedText> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Scanned Text'),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              FlutterClipboard.copy(widget.text).then((value) => _key
                  .currentState
                  .showSnackBar(new SnackBar(content: Text('Copied'))));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? 'No Text Available' : widget.text),
      ),
    );
  }
}
