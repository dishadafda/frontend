import 'dart:ui';
import 'package:flutter/material.dart';

class BlockedUsersScreen extends StatefulWidget {
  @override
  _BlockedUsersScreenState createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  List<String> _blockedUsers = ['blockedUser1', 'blockedUser2', 'blockedUser3']; // Dummy data

  void _unblockUser(String user) {
    setState(() {
      _blockedUsers.remove(user);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$user has been unblocked.')),
    );
    // Call API to unblock user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users', style: TextStyle(color: Colors.deepPurpleAccent)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🖼 Background Image with Blur
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/download (1).jpeg'), // Use the same background image
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Optional dark overlay
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Leave space for app bar
            child: _blockedUsers.isEmpty
                ? const Center(
              child: Text('No users blocked.',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _blockedUsers.length,
              itemBuilder: (context, index) {
                final user = _blockedUsers[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.deepPurpleAccent, width: 2),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      user,
                      style: const TextStyle(color: Colors.deepPurpleAccent),
                    ),
                    trailing: TextButton(
                      onPressed: () => _unblockUser(user),
                      child: const Text(
                        'Unblock',
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
