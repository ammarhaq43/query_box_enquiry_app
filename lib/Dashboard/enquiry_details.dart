import 'package:flutter/material.dart';

class EnquiryDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> enquiryData;

  const EnquiryDetailsScreen({Key? key, required this.enquiryData}) : super(key: key);

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
            Text('Name: ${enquiryData['name'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${enquiryData['email'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Phone: ${enquiryData['phoneNo'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Subject: ${enquiryData['subject'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Description: ${enquiryData['description'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
