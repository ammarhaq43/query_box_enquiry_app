import '../components/enquiry.dart';

class GlobalState {
  static List<Enquiry> _enquiries = [];

  static List<Enquiry> get enquiries => _enquiries;

  static void setEnquiries(List<Enquiry> enquiries) {
    _enquiries = enquiries;
  }

  static void addEnquiry(Enquiry enquiry) {
    _enquiries.add(enquiry);
  }

  static List<Enquiry> filterEnquiries(String query) {
    return _enquiries.where((enquiry) {
      return enquiry.subject!.toLowerCase().contains(query.toLowerCase()) ||
          enquiry.name!.toLowerCase().contains(query.toLowerCase()) ||
          enquiry.email!.toLowerCase().contains(query.toLowerCase()) ||
          enquiry.phone!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
