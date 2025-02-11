import 'dart:typed_data';

class SelectedFileModel{
  String? fileName;
  Uint8List? fileData;

  SelectedFileModel({this.fileData, this.fileName});
}