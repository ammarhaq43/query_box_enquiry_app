import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPendingEnquiriesScreen extends StatefulWidget {
  @override
  State<AdminPendingEnquiriesScreen> createState() => _AdminPendingEnquiriesScreenState();
}

class _AdminPendingEnquiriesScreenState extends State<AdminPendingEnquiriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pending Enquiries Screen', style: GoogleFonts.breeSerif(fontSize: 21)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pending_enquiries').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final pendingEnquiries = snapshot.data!.docs;

          if (pendingEnquiries.isEmpty) {
            return Center(child: Text('No pending enquiries found.'));
          }

          return ListView.builder(
            itemCount: pendingEnquiries.length,
            itemBuilder: (context, index) {
              final enquiry = pendingEnquiries[index];
              return Card(
                child: ListTile(
                  title: Text(enquiry['subject']),
                  subtitle: Text('Email: ${enquiry['email']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PendingEnquiryDetailScreen(enquiry: enquiry),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PendingEnquiryDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot enquiry;

  PendingEnquiryDetailScreen({required this.enquiry});

  // Function to confirm an enquiry
  void _confirmEnquiry(BuildContext context) async {
    // Add enquiry to 'confirmed_enquiries' collection
    await FirebaseFirestore.instance.collection('confirmed_enquiries').add({
      'subject': enquiry['subject'],
      'email': enquiry['email'],
      'phoneNo': enquiry['phoneNo'],
      'description': enquiry['description']
    });

    // Remove the enquiry from 'pending_enquiries'
    await FirebaseFirestore.instance.collection('pending_enquiries').doc(enquiry.id).delete();

    // Show a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enquiry confirmed.'),
        duration: Duration(seconds: 3),
      ),
    );

    // Navigate back to the previous screen after confirming
    Navigator.of(context).pop();
  }

  // Function to delete an enquiry
  void _deleteEnquiry(BuildContext context) async {
    // Show confirmation dialog and move data to 'current_enquiries'
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Enquiry'),
          content: Text('This enquiry will be moved to current enquiries on the user side.'),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('current_enquiries').add({
                  'subject': enquiry['subject'],
                  'email': enquiry['email'],
                  'phoneNo': enquiry['phoneNo'],
                  'description': enquiry['description']
                });
                await FirebaseFirestore.instance.collection('pending_enquiries').doc(enquiry.id).delete();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

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
                  onPressed: () {
                    _confirmEnquiry(context);
                  },
                  child: Text(
                    "Confirm Enquiry",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    _deleteEnquiry(context);
                  },
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
