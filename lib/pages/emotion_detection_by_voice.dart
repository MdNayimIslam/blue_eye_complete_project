import 'dart:io';
import 'package:blue_eye_complete_project/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class EmotionDetectionByVoicePage extends StatefulWidget {
  const EmotionDetectionByVoicePage({Key? key}) : super(key: key);

  @override
  State<EmotionDetectionByVoicePage> createState() =>
      _EmotionDetectionByVoicePageState();
}

class _EmotionDetectionByVoicePageState
    extends State<EmotionDetectionByVoicePage> {
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  late File _image;
  late List _results;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Emontion Detection By Voice",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          (imageSelect)
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(_image),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: const Opacity(
                    opacity: 0.8,
                    child: Center(
                      child: Text("No Voice Selected",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)
                  ? _results.map((result) {
                      return Card(
                        child: Container(
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Voice",
        child: const Icon(Icons.image),
      ),
    );
  }

  Future pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
