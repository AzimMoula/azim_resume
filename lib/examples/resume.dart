import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> createResume(PdfPageFormat format, dynamic data) async {
  final doc = pw.Document();

  // Custom colors
  const PdfColor green = PdfColor.fromInt(0xFF00796B);
  const PdfColor lightGreen = PdfColor.fromInt(0xFFE0F2F1);
  const PdfColor darkText = PdfColor.fromInt(0xFF000000);

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(0),
      ),
      build: (context) => [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Left section
            pw.Container(
              width: 150,
              padding: const pw.EdgeInsets.all(10),
              color: green,
              height: format.height,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.ClipRRect(
                      horizontalRadius: 40,
                      verticalRadius: 40,
                      child: pw.Container(
                        width: 80,
                        height: 80,
                        child: pw.Image(profileImage),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Azim Moula',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'azim2909007@gmail.com',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 12,
                    ),
                  ),
                  pw.Divider(color: PdfColors.white),
                  pw.Text(
                    'Skills',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  pw.Bullet(
                    text: 'Excellent Communication Skills',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                  pw.Bullet(
                    text: 'Troubleshooting Skills',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                  pw.Bullet(
                    text: 'Multitasking Skills',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                  pw.Bullet(
                    text: 'Negotiation Skills',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                  pw.Bullet(
                    text: 'Marketing Strategies',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 10),
            // Right section
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Profile',
                    style: pw.TextStyle(
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    'Dedicated Customer Service Representative dedicated to providing quality care for ultimate customer satisfaction. Proven ability to establish and maintain excellent communication and relationships with clients. Adept in general accounting and finance transactions.',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Employment History',
                    style: pw.TextStyle(
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _buildEmploymentBlock(
                    title:
                        'Branch Customer Service Representative, AT&T Inc., Seattle',
                    dates: 'August 2014 - September 2019',
                    details: [
                      'Maintained up-to-date knowledge of products and services.',
                      'Handled customer calls and resolved issues.',
                      'Handled large volumes of calls daily.',
                      'Worked to address customer needs effectively.',
                    ],
                  ),
                  _buildEmploymentBlock(
                    title:
                        'Customer Service Representative, Gold Coast Hotel, Seattle',
                    dates: 'August 2012 - August 2014',
                    details: [
                      'Greeted customers with enthusiasm.',
                      'Effectively sold rooms to walk-in customers.',
                      'Processed payments and managed staff coordination.',
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Education',
                    style: pw.TextStyle(
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _buildEducationBlock(
                    degree: 'Bachelor of Communications, University of Seattle',
                    year: 'August 2007 - May 2011',
                    details: 'Graduated with High Honors.',
                  ),
                  _buildEducationBlock(
                    degree: 'High School Diploma, Hartwick High School',
                    year: 'September 2003 - May 2007',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  return doc.save();
}

pw.Widget _buildEmploymentBlock({
  required String title,
  required String dates,
  required List<String> details,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
      pw.Text(dates, style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
      ...details.map((detail) =>
          pw.Bullet(text: detail, style: pw.TextStyle(fontSize: 10))),
      pw.SizedBox(height: 10),
    ],
  );
}

pw.Widget _buildEducationBlock({
  required String degree,
  required String year,
  String? details,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        degree,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
      pw.Text(year, style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
      if (details != null) pw.Text(details, style: pw.TextStyle(fontSize: 10)),
      pw.SizedBox(height: 10),
    ],
  );
}
