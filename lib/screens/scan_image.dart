import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './scanned_text.dart';

/*main() async {
  runApp(MaterialApp(home: MyApp()));
}*/

class ScanImage extends StatefulWidget {
  @override
  _ScanImageState createState() => _ScanImageState();
}

class _ScanImageState extends State<ScanImage> {
  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Recognition'),
          actions: [
            FlatButton(
              onPressed: scanText,
              child: Text(
                'Scan',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: Icon(Icons.add_a_photo),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null
              ? Image.file(
                  File(_image.path),
                  fit: BoxFit.fitWidth,
                )
              : Container(),
        ));
  }

  Future scanText() async {
    showDialog(
        context: context,
        child: Center(
          child: CircularProgressIndicator(),
        ));
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ScannedText(_text)));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}
