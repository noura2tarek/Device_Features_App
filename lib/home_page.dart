import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> pickedImages = [];
  final ImagePicker picker = ImagePicker();

  //-- Pick Multiple Image Method --//
  Future<void> _pickMultipleImage() async {
    // We don't need to check permission as this already handled by image_picker
    // Pick multiple images.
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      log('picked images count is ${images.length}');

      setState(() {
        pickedImages = images.map((e) => File(e.path)).toList();
      });
    } else {
      log('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            //-- Images Picked List --//
            if (pickedImages.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var image = pickedImages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.file(
                        height: 200.0,
                        width: double.infinity,
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  itemCount: pickedImages.length,
                ),
              ),
            //-- Pick Image button --//
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: OutlinedButton(
                  onPressed: _pickMultipleImage,
                  child: Text('Pick Image'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
