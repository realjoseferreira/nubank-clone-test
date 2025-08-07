import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  File? _profileImage;
  String _greeting = "Olá, José";
  bool _editingGreeting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF8A05BE),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white24,
              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? const Icon(Icons.add_photo_alternate, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _editingGreeting = true);
              },
              child: _editingGreeting
                  ? TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        setState(() {
                          _greeting = value;
                          _editingGreeting = false;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Digite seu nome",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  : Text(
                      _greeting,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ),
          Row(
            children: const [
              Icon(Icons.remove_red_eye_outlined, color: Colors.white),
              SizedBox(width: 12),
              Icon(Icons.help_outline, color: Colors.white),
              SizedBox(width: 12),
              Icon(Icons.mail_outline, color: Colors.white),
            ],
          )
        ],
      ),
    );
  }
}
