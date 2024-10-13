import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  String? _downloadURL;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_profileImage == null) return;
    try {
      String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.png';

      // رفع الصورة إلي Firebase
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(_profileImage!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      // تخزين رابط الصورة في Firebase
      _saveImageURLToFirestore(downloadURL);

      setState(() {
        _downloadURL = downloadURL; // تخزين رابط التحميل لعرض الصورة
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // دالة لحفظ رابط الصورة في Firestore
  Future<void> _saveImageURLToFirestore(String downloadURL) async {
    User? user = FirebaseAuth.instance.currentUser; // الحصول على المستخدم الحالي
    if (user == null) {
      print('المستخدم غير مسجل الدخول.');
      return; // إذا لم يكن هناك مستخدم مسجل، نخرج من الدالة
    }
    // تحديث ملف المستخدم في Firestore برابط الصورة الجديدة
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(user.uid).update({
      'profileImage': downloadURL,
    }).catchError((error) {
      print('Error saving image URL to Firestore: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: _downloadURL != null
                                ? NetworkImage(_downloadURL!)
                                : const NetworkImage(
                              'https://i.pinimg.com/originals/ac/11/aa/ac11aa2add3b0193c8769e0a17d13535.jpg',
                            ),
                          ),
                          // أيقونة الكاميرا
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Ahmed',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'rezk888@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildProfileOption(
                      icon: Icons.accessibility, title: 'My habits', onTap: () {}),
                  _buildProfileOption(
                      icon: Icons.alarm, title: 'Reminder', onTap: () {}),
                  _buildProfileOption(
                      icon: Icons.notifications, title: 'Notification', onTap: () {}),
                  _buildProfileOption(
                    icon: Icons.privacy_tip,
                    title: 'Privacy policy',
                    onTap: () {},
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
