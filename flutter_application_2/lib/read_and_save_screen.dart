// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadAndSaveScreen extends StatefulWidget {
  @override
  _ReadAndSaveScreenState createState() => _ReadAndSaveScreenState();
}

class _ReadAndSaveScreenState extends State<ReadAndSaveScreen> {
  final TextEditingController textController = TextEditingController();

  void _saveData() {
    String text = textController.text;

    if (text.isNotEmpty) {
      FirebaseFirestore.instance.collection('example').add({
        'text': text,
      });
      // Clear the text field after saving
      textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read and Save Data to Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('example').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var documents = snapshot.data?.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: documents?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(documents?[index]['text']),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Enter Text'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save Data'),
            ),
          ],
        ),
      ),
    );
  }
}
