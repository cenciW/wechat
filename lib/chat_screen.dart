import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wechat/text_composer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _sendMessage({String? text, File? imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      TaskSnapshot taskSnapshot;
      try {
        taskSnapshot = await task;
      } on FirebaseException catch (e) {
        print('Error: ${e.message}');
        return;
      }
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);

      data["imgUrl"] = url;
    }

    if (text != null) data["text"] = text;

    FirebaseFirestore.instance.collection("messages").add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Olá"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data!.docs.reversed.toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var data =
                              documents[index].data() as Map<String, dynamic>?;
                          return ListTile(title: Text(data?["text"] ?? ''));
                        },
                        reverse: true,
                        itemCount: documents.length,
                      );
                  }
                }),
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}
