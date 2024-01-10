import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadDataScreen extends StatelessWidget {
  const ReadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Data from Firestore'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('example').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(documents?[index]['text']),
              );
            },
          );
        },
      ),
    );
  }
}
