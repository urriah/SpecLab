import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  final String userEmail;

  const ProfilePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF381E72)),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the Dashboard
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF381E72),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),


              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF381E72),
                backgroundImage: AssetImage('assets/images/default_profile.png'),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/default_profile.png',
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF381E72),
                ),
              ),

              const SizedBox(height: 4),

              // User Role
              const Text(
                'User',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF381E72),
                ),
              ),

              const SizedBox(height: 40),

              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.edit,
                      label: 'Your Builds',
                      onTap: () {
                        Navigator.pushNamed(context, '/builds'); // Navigate to Builds Page
                      },
                    ),      
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Sign Out Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst); // Navigate back to the login screen
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF381E72),
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF381E72),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF381E72),
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF381E72)),
        ],
      ),
    );
  }
}