import 'dart:math';

import 'constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> currentList = [];

  String currentCaptain = 'Select Your Team Name';
  String rollNo = " ";
  bool isLoading = false;

  void chooseRandomCaptain() {
    setState(() {
      int randomIndex = Random().nextInt(currentList.length);
      currentCaptain = currentList[randomIndex]['name']!;
      rollNo = "Roll No: ${currentList[randomIndex]['rollNumber']!}";
      // updateTextWithDelay();
    });
  }

  void toggleList(String choice) {
    setState(() {
      if (choice == 'Team 1') {
        currentList = studentsData1;
      } else {
        currentList = studentsData2;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    currentList = studentsData1;
  }


  void updateTextWithDelay() {

    setState(() {
      isLoading = true;
    });

    // Simulating a 3-second loading time
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        chooseRandomCaptain();
      });

      Navigator.pop(context);
    });

    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:const SpinKitCircle(
              color: Colors.blue,
              size: 60.0,
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF121212),
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 80),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Who is Lucky?',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo2.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                Text(
                  currentCaptain,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  rollNo,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: isLoading ? null : updateTextWithDelay,
                  child: const Text(
                    'Find',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                ),

                const SizedBox(height: 20),

                ToggleButtons(
                  isSelected: [
                    currentList == studentsData1,
                    currentList == studentsData2,
                  ],
                  onPressed: (index) {
                    if (index == 0) {
                      toggleList('Team 1');
                    } else {
                      toggleList('Team 2');
                    }
                  },
                  color: Colors.white,
                  borderColor: Colors.white70,
                  borderRadius: BorderRadius.circular(5),
                  selectedColor: Colors.white,
                  selectedBorderColor: Colors.white70,
                  fillColor: Colors.blue.shade600,

                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Stack',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Queue',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
