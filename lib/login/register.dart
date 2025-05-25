import 'package:bunbunmart/login/login.dart';
import 'package:bunbunmart/utilities/bun%20register/bun_regform.dart';
import 'package:bunbunmart/utilities/vertical_socialcontainer.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: screenWidth,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEFE8D8), Color(0xFFD3CAAB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    ClipRect(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: 260,
                        decoration: BoxDecoration(
                          color: Color(0xFF183B49),
                          image: DecorationImage(
                            image: AssetImage('assets/screentone/tone.jpg'),
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                            repeat: ImageRepeat.noRepeat,
                            opacity: 0.03,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(110),
                            bottomRight: Radius.circular(110),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: const Color(0xFFD3CAAB),
                                fontSize: 36,
                                fontFamily: 'DeliusSwashCaps',
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "Become part of the BunBun Family!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //container
                    Transform.translate(
                      offset: Offset(0, -90),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),

                          child: BunRegisterForm(),
                        ),
                      ),
                    ),

                    //Google, Facebook
                    Transform.translate(
                      offset: Offset(0, -100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            VerticalSocialContainer(
                              imagepath: 'assets/icons/facebook.png',
                              label: "Facebook",
                            ),
                            SizedBox(width: 20), // Space between the buttons
                            VerticalSocialContainer(
                              imagepath: 'assets/icons/google.png',
                              label: "Google",
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Login
                    Transform.translate(
                      offset: Offset(0, -70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              // Navigate to RegisterPage when the "Sign Up" text is pressed
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
