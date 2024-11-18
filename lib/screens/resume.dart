import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data.dart';

const PdfColor green = PdfColor.fromInt(0xFF00796B);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 170.0;

Future<Uint8List> generateResume(PdfPageFormat format, CustomData data) async {
  final doc = pw.Document(title: 'Azim Resume', author: 'Mohammed Azim Moula');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format, profileImage);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme.copyWith(
        margin:
            pw.EdgeInsets.zero, // Remove page margins for edge-to-edge layout
      ),
      footer: (pw.Context context) {
        // Only add page numbers if there is more than 1 page
        if (context.pagesCount > 1) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(
                bottom: 12, right: 12), // Adjust padding as needed
            child: pw.Align(
              alignment: pw.Alignment.bottomRight,
              child: pw.Text(
                'Page ${context.pageNumber}/${context.pagesCount}', // Page 1/2 format
                style: pw.TextStyle(
                  fontSize: 12, // Adjust the font size as needed
                  color: green,
                ),
              ),
            ),
          );
        }
        // Return an empty widget when there's only 1 page
        return pw.SizedBox();
      },
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              width: sep,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: sep,
                    padding: const pw.EdgeInsets.fromLTRB(10, 25, 10, 10),
                    color: green,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Center(
                          child: pw.ClipOval(
                            child: pw.Container(
                              width: 100,
                              height: 80,
                              child: profileImage != null
                                  ? pw.Image(profileImage)
                                  : pw.Text("No Image"),
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Center(
                          child: pw.Text(
                            'Azim Moula',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          '+91 93813 14150',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 12,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'azimmoula1@gmail.com',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 12,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Divider(color: PdfColors.white),
                        pw.Text(
                          'Skills',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        pw.Wrap(
                          children: [
                            pw.Bullet(
                              text: 'Flutter',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                            pw.Bullet(
                              text: 'Firebase',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                            pw.Bullet(
                              text: 'Java',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                            pw.Bullet(
                              text: 'Python',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                            pw.Bullet(
                              text: 'SQL',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                            pw.Bullet(
                              text: 'NoSQL',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                            pw.Bullet(
                              text: 'Git',
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Partition(
                child: pw.Padding(
              padding: pw.EdgeInsets.all(15),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.max,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _Category(title: 'Profile'),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(left: 15),
                    child: pw.Text(
                      'An App Developer skilled in Flutter, focused on building high-performance, user-friendly mobile apps for Android and iOS. Committed to clean code and continuous learning.',
                    ),
                  ),
                  _Category(title: 'Experience'),
                  ...[
                    _Block(
                      width: pageTheme.pageFormat.width,
                      title: 'App Development Lead',
                      subtitle: 'Google Developer Groups On Campus',
                      content:
                          'Currently serving as the App Development Lead in Google Developer Groups On Campus in MJCET.',
                    ),
                    _Block(
                      width: pageTheme.pageFormat.width,
                      title: 'Tech Head',
                      subtitle: 'Computer Society of India',
                      content:
                          'Currently serving as the Tech Head in Computer Society of India in MJCET.',
                    ),
                  ],
                  _Category(title: 'Education'),
                  ...[
                    _Block(
                      width: pageTheme.pageFormat.width,
                      title:
                          'Muffakham Jah College of Engineering and Technology',
                      content: 'B.E, Information Technology',
                      trailing: '2022 - 2026',
                    ),
                    _Block(
                      width: pageTheme.pageFormat.width,
                      title: 'Narayana Junior College',
                      content: 'Board of Intermediate Education, Hyderabad',
                      trailing: '2020 - 2022',
                    ),
                    _Block(
                      width: pageTheme.pageFormat.width,
                      title: 'Narayana Olympiad High School',
                      content: 'Board of Secondary Education, Hyderabad',
                      trailing: '2010 - 2020',
                    ),
                    _Category(title: 'Projects'),
                    ...[
                      _Block(
                        width: pageTheme.pageFormat.width,
                        title: 'CSI App',
                        subtitle: 'Event Management App',
                        content:
                            'Developed the front-end and back-end for an event management platform using Flutter, streamlining registrations and memberships for CSI MJCET.',
                      ),
                      _Block(
                        width: pageTheme.pageFormat.width,
                        title: 'QRIAN',
                        subtitle: 'Offline Indoor Navigation App',
                        content:
                            'Created an Offline Indoor Navigation App that helps users navigate through large complex spaces like Airports or Malls easily.',
                      ),
                      _Block(
                        width: pageTheme.pageFormat.width,
                        title: 'KindMap',
                        subtitle: 'Location-based Charity App',
                        content:
                            'Created a location-based charity app in Flutter to connect people in need with volunteers, improving community aid accessibility',
                      ),
                    ],
                    _Category(title: 'Achievements'),
                    ...[
                      _Block(
                        width: pageTheme.pageFormat.width,
                        title: 'Hack4SDG, The Global Goals Hackathon',
                        content:
                            'Top 7 Finalist from MJCET, addressing the United Nations SDGs, Conducted by AIESEC at IITH.',
                        trailing: 'Oct 2024',
                      ),
                      _Block(
                          width: pageTheme.pageFormat.width,
                          title: 'CMR Hackfest 1.0',
                          content:
                              'Top 75 Finalist for the 36-Hour Hackathon at CMRCET, Hyderabad.',
                          trailing: 'Mar 2024'),
                    ],
                  ],
                  pw.Container(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(
    PdfPageFormat format, pw.MemoryImage image) async {

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Container(
              width: sep,
              color: green,
              height: format.height,
            ),
          ],
        ),
      );
    },
  );
}

class _Block extends pw.StatelessWidget {
  _Block(
      {required this.title,
      this.subtitle,
      this.content,
      this.trailing,
      this.width});

  final String title;
  final String? subtitle;
  final String? content;
  final String? trailing;
  final double? width;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        mainAxisSize: pw.MainAxisSize.max,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Container(
                  width: width! - 210,
                  child: pw.Row(
                    mainAxisSize: pw.MainAxisSize.max,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          mainAxisSize: pw.MainAxisSize.max,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              title,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                            ),
                            pw.Text(
                              subtitle ?? '',
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    fontWeight: pw.FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Align(
                        alignment: pw.Alignment.bottomRight,
                        child: pw.Text(trailing ?? ''),
                      ),
                    ],
                  ),
                ),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Text(content ?? ''),
          ),
        ]);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class _Percent extends pw.StatelessWidget {
  _Percent({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;

  final double value;

  final pw.Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  pw.Widget build(pw.Context context) {
    final widgets = <pw.Widget>[
      pw.Container(
        padding: pw.EdgeInsets.only(left: 20),
        width: size,
        height: 5,
        decoration:
            pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(50)),
        child: pw.LinearProgressIndicator(
          value: value,
          backgroundColor: PdfColors.grey600,
          valueColor: PdfColors.white,
        ),
        // child: pw.Stack(
        //   alignment: pw.Alignment.center,
        //   fit: pw.StackFit.expand,
        //   children: <pw.Widget>[
        //     pw.Center(
        //       child: pw.Text(
        //         '${(value * 100).round().toInt()}%',
        //         textScaleFactor: fontSize,
        //       ),
        //     ),
        //     pw.LinearProgressIndicator(
        //       value: value,
        //       backgroundColor: backgroundColor,
        //       valueColor: color,
        //     ),
        //   ],
        // ),
      )
    ];

    widgets.add(title);

    return pw.Column(children: widgets);
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColor.fromInt(0xFF00796B), // Link color
          decoration: pw.TextDecoration.underline,
        ),
      ),
    );
  }
}
