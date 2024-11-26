import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TokenImage extends StatefulWidget {
  final String imageUrl;
  final String accessToken;

  const TokenImage(
      {super.key, required this.imageUrl, required this.accessToken});

  @override
  _TokenImageState createState() => _TokenImageState();
}

class _TokenImageState extends State<TokenImage> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
    try {
      final response = await http.get(
        Uri.parse(widget.imageUrl),
        headers: {'x-api-key': 'Bearer ${widget.accessToken}'},
      );
      print(widget.accessToken);
      if (response.statusCode == 200) {
        setState(() {
          _imageBytes = response.bodyBytes;
        });
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return _imageBytes != null
        ? Image.memory(_imageBytes!)
        : const CircularProgressIndicator();
  }
}
