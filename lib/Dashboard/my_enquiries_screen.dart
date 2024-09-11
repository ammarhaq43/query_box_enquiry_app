import 'package:flutter/material.dart';
import '../components/enquiry.dart';

class MyEnquiriesScreen extends StatelessWidget {
  final Enquiry enquiry;

  const MyEnquiriesScreen({Key? key, required this.enquiry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${enquiry.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${enquiry.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Phone: ${enquiry.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Subject: ${enquiry.subject}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Description: ${enquiry.description}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
