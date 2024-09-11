import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../components/enquiry.dart';
import '../models/global_state.dart';


class UserEnquiryPage extends StatefulWidget {
  const UserEnquiryPage({super.key});

  @override
  State<UserEnquiryPage> createState() => _UserEnquiryPageState();
}

class _UserEnquiryPageState extends State<UserEnquiryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to add data to Firestore
  addData(String name, String email, String phoneNo, String subject, String description) async {
    if ([name, email, phoneNo, subject, description].any((element) => element.isEmpty)) {
      log("Enter Required Fields");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection("users").doc(subject).set({
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "subject": subject,
        "description": description,
      });
      log("Data inserted into Firestore");
    } catch (error) {
      log("Failed to add data: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Enquiry Page', style: GoogleFonts.breeSerif(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Your inquiries are our opportunity to help. Reach out, and we will guide you through.',
                  style: GoogleFonts.breeSerif(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              _buildTextField(_nameController, 'Name', Icons.person, 'Enter your name', 'Please enter your name'),
              _buildTextField(_emailController, 'Email', Icons.email, 'Enter your email address', 'Please enter a valid email', emailValidation: true),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 70,
                  width: 330,
                  child: IntlPhoneField(
                    controller: _phoneController,
                    decoration: _inputDecoration('Phone No.', Icons.phone),
                  ),
                ),
              ),
              _buildTextField(_subjectController, 'Subject', Icons.subject, 'Enter the subject of your enquiry', 'Please enter a subject'),
              _buildDescriptionField(),
              SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon, String hintText, String errorMsg,
      {bool emailValidation = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        width: 330,
        child: TextFormField(
          controller: controller,
          decoration: _inputDecoration(label, icon),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorMsg;
            }
            if (emailValidation && !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintStyle: TextStyle(color: Colors.grey.shade600),
      prefixIcon: Icon(icon, color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 330,
        height: 60,
        child: TextFormField(
          controller: _descriptionController,
          decoration: _inputDecoration('Description', Icons.description),
          maxLines: 5,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 70,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Enquiry enquiry = Enquiry(
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                subject: _subjectController.text,
                description: _descriptionController.text,
              );
              GlobalState.addEnquiry(enquiry);
              addData(
                _nameController.text,
                _emailController.text,
                _phoneController.text,
                _subjectController.text,
                _descriptionController.text,
              );

              // Clear fields after submission
              _nameController.clear();
              _emailController.clear();
              _phoneController.clear();
              _subjectController.clear();
              _descriptionController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Enquiry Submitted')),
              );
            }
          },
          child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 19)),
        ),
      ),
    );
  }
}