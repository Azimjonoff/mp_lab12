// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveDataScreen extends StatefulWidget {
  @override
  _SaveDataScreenState createState() => _SaveDataScreenState();
}

class _SaveDataScreenState extends State<SaveDataScreen> {
  final TextEditingController textController = TextEditingController();
  String savedText = "";

  void _saveData() {
    String text = textController.text;

    if (text.isNotEmpty) {
      FirebaseFirestore.instance.collection('example').add({
        'text': text,
      });

      // Clear the text field after saving
      textController.clear();

      // Update the savedText to display the saved data
      setState(() {
        savedText = "Last saved text: $text";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Data to Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Enter Text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text('Save Data'),
            ),
            const SizedBox(height: 16),
            Text(savedText, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
