import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/global_state.dart';
import 'my_enquiries_screen.dart';

class UserAllEnquiryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Enquiries', style: GoogleFonts.breeSerif()),
      ),
      body: ListView.builder(
        itemCount: GlobalState.enquiries.length,
        itemBuilder: (context, index) {
          final enquiry = GlobalState.enquiries[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            child: ListTile(
              title: Text(
                enquiry.subject ?? 'No Subject',
                style: GoogleFonts.breeSerif(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyEnquiriesScreen(enquiry: enquiry),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
