import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PendingEnquiryDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot enquiry;

  PendingEnquiryDetailScreen({required this.enquiry});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Enquiry Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject: ${enquiry['subject']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Email: ${enquiry['email']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Phone No: ${enquiry['phoneNo']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Description: ${enquiry['description']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Confirm Enquiry",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Delete Enquiry",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}