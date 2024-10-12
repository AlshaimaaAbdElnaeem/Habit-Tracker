import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Policy for Habits App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildPolicySection(
                title: '1. Data Collection:',
                content: 'We collect data to help users track their habits efficiently, including daily progress, reminders, and custom habit settings. No sensitive personal information is collected without user consent.',
                cardColor: Colors.lightBlueAccent, // Custom card color
              ),
              _buildPolicySection(
                title: '2. Usage of Data:',
                content: 'The data collected is solely used for the purpose of providing a better user experience. We do not share or sell your data to third parties.',
                cardColor: Colors.lightBlueAccent, // Custom card color
              ),
              _buildPolicySection(
                title: '3. User Control:',
                content: 'Users can modify or delete their habit data at any time. Data stored locally on your device can be backed up securely if the feature is available.',
                cardColor: Colors.lightBlueAccent, // Custom card color
              ),
              _buildPolicySection(
                title: '4. Security:',
                content: 'We prioritize security and take necessary measures to ensure your data is safe. Regular updates are implemented to protect against potential threats.',
                cardColor: Colors.lightBlueAccent, // Custom card color
              ),
              _buildPolicySection(
                title: '5. Changes to Policy:',
                content: 'We reserve the right to modify this privacy policy at any time. Any significant changes will be communicated to users in advance.',
                cardColor: Colors.lightBlueAccent, // Custom card color
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content, Color? cardColor}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      color: cardColor, // Set the custom card color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Change text color if needed
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(color: Colors.white), // Change text color if needed
            ),
          ],
        ),
      ),
    );
  }
}
