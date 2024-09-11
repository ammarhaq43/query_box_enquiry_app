// Mock Enquiry class for demonstration purposes
class Enquiry {
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String description;

  Enquiry({
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.description,
  });
}

// Global list to store pending enquiries
List<Enquiry> pendingEnquiries = [];