import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminEnquiryDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot enquiry;
  final VoidCallback onDelete; // Use VoidCallback for callback without parameters

  AdminEnquiryDetailScreen({required this.enquiry, required this.onDelete});

  void _deleteEnquiry(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(enquiry.id).delete();
      onDelete(); // Notify the parent screen to refresh
      Navigator.pop(context); // Navigate back to the previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enquiry has been deleted'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete enquiry: $e'),
        ),
      );
    }
  }

  void _moveToPending(BuildContext context) async {
    try {
      // Copy the enquiry to 'pending_enquiries'
      await FirebaseFirestore.instance.collection('pending_enquiries').doc(enquiry.id).set(enquiry.data() as Map<String, dynamic>);
      // Delete from 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(enquiry.id).delete();
      onDelete(); // Notify the parent screen to refresh
      Navigator.pop(context); // Navigate back to the previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enquiry has been moved to Pending'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to move enquiry to Pending: $e'),
        ),
      );
    }
  }

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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    _deleteEnquiry(context); // Handle submit action and deletion here
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    _moveToPending(context);
                  },
                  child: Text('Pending', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
