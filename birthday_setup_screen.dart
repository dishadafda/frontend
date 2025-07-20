import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matrimony_api/screens/welcome_screen.dart';



class BirthdaySetupScreen extends StatefulWidget {
  final String username;
  final String name;
  final String bio;
  final String? profilePhotoPath;

  const BirthdaySetupScreen({
    Key? key,
    required this.username,
    required this.name,
    required this.bio,
    this.profilePhotoPath, String? avatarSvg,
  }) : super(key: key);

  @override
  _BirthdaySetupScreenState createState() => _BirthdaySetupScreenState();
}

class _BirthdaySetupScreenState extends State<BirthdaySetupScreen> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _finishSetup() {
    if (_selectedDate != null) {
      // Here, you would send all the collected user data (username, name, bio,
      // profile photo URL, birthdate) to your backend to create the user entry in MongoDB.

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(username: widget.username),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your birthdate.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Set Your Birthdate', style: TextStyle(color: Colors.deepPurpleAccent),)
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/download (1).jpeg'), // 👈 Save your uploaded image here
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                color: Colors.black.withOpacity(0.2), // Optional dark overlay
              ),
            ),
          ),
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white, // 🎨 Background color
                  borderRadius: BorderRadius.circular(30), // 🟠 Rounded corners
                  border: Border.all(
                    color: Colors.black, // 🟢 Border color
                    width: 2,
                  ),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Match outer container
                  ),
                  title: Text(
                    _selectedDate == null
                        ? 'Select Birthdate'
                        : 'Birthdate: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  trailing: const Icon(Icons.calendar_today,color: Colors.deepPurpleAccent,),
                  onTap: () => _selectDate(context),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _finishSetup,
                child: const Text('Finish Setup',style: TextStyle(color: Colors.deepPurpleAccent),),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}

