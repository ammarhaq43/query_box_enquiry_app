import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:query_box_enquiry_app/Dashboard/user_all_enquiry_screen.dart';
import 'package:query_box_enquiry_app/Dashboard/user_current_enquiries_screen.dart';
import 'package:query_box_enquiry_app/Dashboard/user_enquiry_page.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 370,
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/home_page.webp'), fit: BoxFit.cover),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Your questions are the compass to our solutions. Submit an inquiry and let us guide you to the answers you seek.', style:
                      GoogleFonts.breeSerif(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100), topRight: Radius.circular(15),
                    ),
                    color: Colors.white
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 350,
                    height: 85,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserAllEnquiryScreen()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.file_copy, size: 22,color: Colors.white,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50, top: 1),
                                  child: Text('All Enquiries', style: GoogleFonts.breeSerif(
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 98),
                                  child: Icon(Icons.arrow_forward, size: 22,),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15),
                    ),
                    color: Colors.white
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 350,
                    height: 85,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.ad_units_rounded, size: 22,color: Colors.white,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 47, top: 1),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserCurrentEnquiriesScreen()));
                                  },
                                  child: Text('Current Enquiries', style: GoogleFonts.breeSerif(
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 52),
                                child: Icon(Icons.arrow_forward, size: 22,),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15),
                    ),
                    color: Colors.white
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 350,
                    height: 85,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.add, size: 22,color: Colors.white,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50, top: 1),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserEnquiryPage()));
                                  },
                                  child: Text('Add a new enquiry', style: GoogleFonts.breeSerif(
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Icon(Icons.arrow_forward, size: 22,),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
