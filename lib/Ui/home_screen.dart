import 'dart:io';

import 'package:dream_11_clone/firebase/firebase_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  File? image;

  Future<void> imagePick(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Update image and trigger rebuild
      });
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      imagePick(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      imagePick(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'Dream11',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: Container(
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.orange),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => showImagePicker(
                      context), // Function to show options for camera/gallery
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 60,
                            child: image == null
                                ? Image.asset(
                                    "assets/images/men1.png") // Default image
                                : Image.file(image!), // Show selected image
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                user?.email?.split('@')[0] ?? "Sumit Sonar",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseService service = FirebaseService();
                                  service.signOut();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text(
                                  "SignOut",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        Text("My Info & Settings")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.headphones_outlined),
                        Text("24x7 Help & Support")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Icon(Icons.gamepad), Text("How to Play")],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "VERSION 5.32.2",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // Upcoming Cricket Match Info
            Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'UPCOMING CRICKET MATCHES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Match Information (India vs Bangladesh)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/india_flag.png', // Replace with your asset
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text('India'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Match starts in',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '29h',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/bangladesh_flag.jpg', // Replace with your asset
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text('Pakistan'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      // Prize Pool Information
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹22 Crores',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '1st Prize ₹1.5 Crores',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.grey[300],
                        color: Colors.red,
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Space between left and right content
                        children: [
                          // Left side: "Join For" section with amounts
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align items to the left
                            children: [
                              Text(
                                "Join For",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0, // Smaller size
                                ),
                              ),
                              SizedBox(
                                  height:
                                      4.0), // Space between the title and the amount

                              // Row for displaying the amounts
                              Row(
                                children: [
                                  // Amount with cut line
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right:
                                                    4.0), // Space between icon and amount
                                            child: Icon(
                                                Icons.currency_rupee_sharp,
                                                size: 16), // Rupee icon
                                          ),
                                        ),
                                        TextSpan(
                                          text: '49',
                                          style: TextStyle(
                                            decoration: TextDecoration
                                                .lineThrough, // Cut line
                                            fontSize: 16.0, // Smaller size
                                            color: Colors
                                                .red, // Change color to indicate cut line
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.0), // Space between amounts

                                  // Amount without cut line
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right:
                                                    4.0), // Space between icon and amount
                                            child: Icon(
                                                Icons.currency_rupee_sharp,
                                                size: 16), // Rupee icon
                                          ),
                                        ),
                                        TextSpan(
                                          text: '1 Only',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0, // Smaller size
                                            color: Colors
                                                .black, // Regular color for the second amount
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Right side: "Join Now" button
                          ElevatedButton(
                            onPressed: () {
                              // Add your onPressed function here
                            },
                            child: Text(
                              "Join Now",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Button color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Padding for button
                              textStyle:
                                  TextStyle(fontSize: 16), // Button text size
                            ),
                          ),
                        ],
                      )
                    ])),
            SizedBox(height: 20.0),
            // Other upcoming matches
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All upcoming matches',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // "How to Play" Section
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(16.0), // Add padding to the container
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the row content
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center vertically
                children: [
                  // Ball Image
                  SizedBox(
                    height: 100, // Adjust size as needed
                    width: 100, // Adjust size as needed
                    child: Image.asset(
                      'assets/images/ball.png', // Replace with your ball asset
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10), // Space between the ball and the text
                  // Column for "How To Play" text and button
                  Expanded(
                    // Use Expanded to allow the Column to take available space
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Align text to start
                      children: [
                        Text(
                          'How To Play',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black, // Change to white if needed
                          ),
                        ),
                        SizedBox(height: 10), // Space between text and button
                        ElevatedButton.icon(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          icon: Icon(Icons.play_arrow),
                          label: Text(
                            'Watch 40 sec video',
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "MEET OUR WINNERS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 200, // Set a fixed height for the horizontal ListView
              child: ListView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                children: [
                  Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 60,
                              child: Image.asset('assets/images/men1.png')),
                          Text(
                            "Ashok Kumar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "Won ₹1 Crore",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          Text(
                            "My Skills and knownledge help me win big, Thankfull to Dream 11",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                  Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 60,
                              child: Image.asset('assets/images/men2.png')),
                          Text(
                            "Sandeep Nayak",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "Won ₹1 Crore",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          Text(
                            "I have given my Best, Thankfull to Dream 11",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                  Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 60,
                              child: Image.asset('assets/images/men3.png')),
                          Text(
                            "Mohd Arif",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "Won ₹1 Crore",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          Text(
                            "I am sure Dream 11 will fulfill nore dreams as it has mine",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.stadium),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "6+ Sports",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          Text(
                            "Cricket,football,Kabaddi and more",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "500+ Crorepatis",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          Text(
                            "From all over india",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "For the Fans, By the Fans.",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
