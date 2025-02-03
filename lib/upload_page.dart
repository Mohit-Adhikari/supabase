import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _imageFile;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future uploadImage() async {
    if (_imageFile == null) {
      return;
    }
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';
    await Supabase.instance.client.storage
        .from('images')
        .upload(path, _imageFile!)
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Image uploaded'))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload Images'),
        ),
        body: Center(
          child: Column(
            children: [
              _imageFile == null
                  ? const Text('No image selected.')
                  : Image.file(_imageFile!),
              ElevatedButton(
                  onPressed: pickImage, child: const Text('Select Image')),
              ElevatedButton(
                onPressed: uploadImage,
                child: const Text('Upload Image'),
              )
            ],
          ),
        ));
  }
}
