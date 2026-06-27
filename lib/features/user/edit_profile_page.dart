import 'dart:typed_data'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  Uint8List? _selectedImageBytes; // Stores bytes instead of File
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AppStateNotifier>(context, listen: false).currentUser;
    _nameController = TextEditingController(text: user?.name ?? "");
    _selectedImageBytes = user?.profileImageBytes;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      // .readAsBytes() works on both Web and Mobile
      Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() => _selectedImageBytes = imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(backgroundColor: Colors.transparent, title: const Text("EDIT IDENTITY")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                // Use MemoryImage for bytes
                backgroundImage: _selectedImageBytes != null ? MemoryImage(_selectedImageBytes!) : null,
                child: _selectedImageBytes == null ? const Icon(Icons.camera_alt, size: 40) : null,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "NAME", labelStyle: TextStyle(color: Colors.cyanAccent)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.updateProfile(_nameController.text, _selectedImageBytes);
                Navigator.pop(context);
              },
              child: const Text("SAVE CHANGES"),
            ),
          ],
        ),
      ),
    );
  }
}