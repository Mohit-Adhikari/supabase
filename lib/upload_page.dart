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

  try {
    // Upload the image to the correct bucket (`image`)
    await Supabase.instance.client.storage
        .from('image') // Use the correct bucket name
        .upload(path, _imageFile!);

    // Get the public URL
    final imageUrl = Supabase.instance.client.storage
        .from('image') // Use the correct bucket name
        .getPublicUrl(path);

    // Print the URL to the console
    print('Image URL: $imageUrl');

    // Show a snackbar to notify the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image uploaded: $imageUrl')),
    );
  } catch (e) {
    // Handle errors (e.g., bucket not found, upload failed)
    print('Error uploading image: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error uploading image: $e')),
    );
  }
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
