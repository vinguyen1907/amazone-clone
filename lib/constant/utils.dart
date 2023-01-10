import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      images = files.files.map((file) => File(file.path!)).toList();
    }
  } catch (error) {
    debugPrint(error.toString());
  }

  return images;
}

void httpErrorHandler(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, "Message: ${jsonDecode(response.body)['msg']}");
      break;
    case 401:
      showSnackBar(context, "Message: ${jsonDecode(response.body)['msg']}");
      break;
    case 500:
      showSnackBar(context, "Error: ${jsonDecode(response.body)['error']}");
      break;
    default:
      showSnackBar(context, response.body);
  }
}
