import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class EditYourProfile extends StatefulWidget {
  const EditYourProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditYourProfileState createState() => _EditYourProfileState();
}

class _EditYourProfileState extends State<EditYourProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();

  User? user;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController hostelAddressController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  File? _profilePic;
  String? _existingProfilePicUrl; // To store the existing profile pic URL

  bool _isLoading = false; // To track the loading state

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('client_user').doc(user!.uid).get();
      setState(() {
        firstnameController.text = userDoc['firstName'];
        lastnameController.text = userDoc['lastName'];
        hostelAddressController.text = userDoc['company_address'];
        phoneNoController.text = userDoc['phone'];
        companyNameController.text = userDoc['company_name'];
        companyEmailController.text = userDoc['company_email'];
        companyIdController.text = userDoc['company_id'];
        _existingProfilePicUrl =
            userDoc['profile_pic']; // Store the existing URL
      });
    }
  }

  Future<void> _updateUserDetails() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });

      String? imageUrl;

      if (_profilePic != null) {
        // Delete the existing image if a new one is uploaded
        if (_existingProfilePicUrl != null) {
          await _storage.refFromURL(_existingProfilePicUrl!).delete();
        }

        final storageRef =
            _storage.ref().child('user_client_profile/${user!.uid}');
        final uploadTask = await storageRef.putFile(_profilePic!);
        imageUrl = await uploadTask.ref.getDownloadURL();
      } else {
        // If no new image is uploaded, keep the existing one
        imageUrl = _existingProfilePicUrl;
      }

      await _firestore.collection('client_user').doc(user!.uid).update({
        'firstName': firstnameController.text,
        'lastName': lastnameController.text,
        'company_address': hostelAddressController.text,
        'phone': phoneNoController.text,
        'company_name': companyNameController.text,
        'company_email': companyEmailController.text,
        'company_id': companyIdController.text,
        'profile_pic': imageUrl, // Update with the new or existing URL
      });

      setState(() {
        _isLoading = false; // Stop loading
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Future<void> _pickProfilePic() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profilePic = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Stack(
            // Use Stack to overlay the loading indicator
            children: [
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: GestureDetector(
                      onTap: _pickProfilePic,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: _profilePic != null
                            ? FileImage(_profilePic!)
                            : (_existingProfilePicUrl != null
                                ? NetworkImage(_existingProfilePicUrl!)
                                : null),
                        child: _profilePic == null &&
                                _existingProfilePicUrl == null
                            ? const Icon(Icons.camera_alt, size: 50)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Personal Info'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: firstnameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: lastnameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneNoController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text('Company/Campus Info'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: companyNameController,
                    readOnly: true,
                    decoration:
                        const InputDecoration(labelText: 'Company/Campus Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your company name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: companyEmailController,
                    decoration: const InputDecoration(
                        labelText: 'Company/Campus Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your company email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: hostelAddressController,
                    decoration: const InputDecoration(
                        labelText: 'Desk/Room/Office Address'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your hostel address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: companyIdController,
                    decoration:
                        const InputDecoration(labelText: 'Company/Campus ID'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your company ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : _updateUserDetails, // Disable button while loading
                    child: const Text('Save changes'),
                  ),
                ],
              ),
              if (_isLoading) // Show loading indicator if _isLoading is true
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
