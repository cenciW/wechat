import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage, {super.key});

  final Function({String? text, File? imgFile}) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _messageController = TextEditingController();

  void _reset() {
    _messageController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () async {
              final picker = ImagePicker();
              final XFile? imgFile =
                  (await picker.pickImage(source: ImageSource.camera));
              if (imgFile == null) return;
              widget.sendMessage(imgFile: File(imgFile.path));
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration.collapsed(
                  hintText: "Enviar uma mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _messageController.text);
                    _reset();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
