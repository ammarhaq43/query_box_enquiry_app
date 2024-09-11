import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../ui/admin_enquiry_detail_screen.dart';

class AdminAllEnquiriesScreen extends StatefulWidget {
  @override
  _AdminAllEnquiriesScreenState createState() => _AdminAllEnquiriesScreenState();
}

class _AdminAllEnquiriesScreenState extends State<AdminAllEnquiriesScreen> {
  void _handleDelete() {
    // Trigger a rebuild to refresh the list
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Enquiries')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final enquiries = snapshot.data!.docs;

          if (enquiries.isEmpty) {
            return Center(child: Text('No enquiries found.'));
          }

          return ListView.builder(
            itemCount: enquiries.length,
            itemBuilder: (context, index) {
              final enquiry = enquiries[index];
              return Card(
                child: ListTile(
                  title: Text(enquiry['name']),
                  subtitle: Text('Subject: ${enquiry['subject']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminEnquiryDetailScreen(
                          enquiry: enquiry,
                          onDelete: _handleDelete,
                        ),
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
