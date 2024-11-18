import 'dart:async';
import 'dart:typed_data';

import 'package:azim_resume/data.dart';
import 'package:pdf/pdf.dart';

import 'screens/resume.dart';

var examples = const Example('Azim Resume', 'resume.dart', generateResume);

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, CustomData data);

class Example {
  const Example(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
