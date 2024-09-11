import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/enquiry.dart';

class MyEnquiries extends StatefulWidget {
  final Enquiry enquiry;
  const MyEnquiries({required this.enquiry});

  @override
  State<MyEnquiries> createState() => _MyEnquiriesState();
}

class _MyEnquiriesState extends State<MyEnquiries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry Details', style: GoogleFonts.breeSerif()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.enquiry.name}', // Use widget.enquiry
              style: GoogleFonts.breeSerif(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${widget.enquiry.email}', // Use widget.enquiry
              style: GoogleFonts.breeSerif(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: ${widget.enquiry.phone}', // Use widget.enquiry
              style: GoogleFonts.breeSerif(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Subject: ${widget.enquiry.subject}', // Use widget.enquiry
              style: GoogleFonts.breeSerif(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: GoogleFonts.breeSerif(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              widget.enquiry.description, // Use widget.enquiry
              style: GoogleFonts.breeSerif(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
