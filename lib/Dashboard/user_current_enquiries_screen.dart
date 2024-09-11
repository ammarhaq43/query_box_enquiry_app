import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserCurrentEnquiriesScreen extends StatelessWidget {
  const UserCurrentEnquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Current Enquiries Screen',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('current_enquiries').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final currentEnquiries = snapshot.data!.docs;

          if (currentEnquiries.isEmpty) {
            return const Center(child: Text('No current enquiries found.'));
          }

          return ListView.builder(
            itemCount: currentEnquiries.length,
            itemBuilder: (context, index) {
              final enquiry = currentEnquiries[index];
              return Card(
                child: ListTile(
                  title: Text(enquiry['subject']),
                  subtitle: Text('Email: ${enquiry['email']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrentEnquiryDetailScreen(enquiry: enquiry),
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

class CurrentEnquiryDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot enquiry;

  const CurrentEnquiryDetailScreen({Key? key, required this.enquiry}) : super(key: key);

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this enquiry?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Delete enquiry from Firestore
                await FirebaseFirestore.instance
                    .collection('current_enquiries')
                    .doc(enquiry.id)
                    .delete();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your enquiry is deleted.'),
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDeleteConfirmationDialog(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enquiry Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject: ${enquiry['subject']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Email: ${enquiry['email']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Phone No: ${enquiry['phoneNo']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Description: ${enquiry['description']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 140,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}