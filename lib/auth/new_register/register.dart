// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postalhub_client/auth/new_login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postalhub_client/src/navigator/navigator_services.dart';

class RegisterScreenNew extends StatefulWidget {
  const RegisterScreenNew({super.key});

  @override
  State<RegisterScreenNew> createState() => _RegisterScreenNewState();
}

int _index = 0;

class _RegisterScreenNewState extends State<RegisterScreenNew> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyId = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();

  String? _selectedCompany;
  List<String> _companyList = [];

  final textFieldFocusNode = FocusNode();

  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  final textFieldFocusNode2 = FocusNode();
  bool _obscured2 = true;
  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode2.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode2.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void emailErrorState() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('User not found'),
          );
        });
  }

  void passwordErrorState() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Ops incorrect password'),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _fetchCompanyList();
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String companyAddress = _companyAddressController.text;
      String phone = _phoneController.text;
      String companyId = _companyId.text;
      String companyName = _selectedCompany ?? '';
      String companyEmail = _companyEmailController.text;

      // Generate a unique ID
      String uniqueId = await generateUniqueId();

      // 1. Create the user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // 2.   Store user details in Firestore
      await FirebaseFirestore.instance
          .collection('client_user')
          .doc(
              userCredential.user!.uid) // Use the user's UID as the document ID
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'company_address': companyAddress,
        'phone': phone,
        'company_name': companyName,
        'company_id': companyId,
        'company_email': companyEmail,
        'membership_points': 5,
        'company_code': 'UTP',
        'profile_pic': '',
        'unique_id': uniqueId,
      });

      // 3. (Optional) Navigate to a new screen or show a success message
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Registration Successful'),
          );
        },
      );
      // Then navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AppNavigatorServices()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Authentication errors
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
      // Show   an error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registration Error'),
            content:
                Text(e.message ?? 'An error occurred during registration.'),
          );
        },
      );
    } catch (e) {
      // Handle errors if necessary
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  Future<String> generateUniqueId() async {
    String uniqueId = ''; // Initialize with an empty string or a default value
    bool exists = true;

    while (exists) {
      // Generates a 6-digit ID
      uniqueId = (100000 + (DateTime.now().millisecondsSinceEpoch % 900000))
          .toString();

      // Check if this ID already exists in Firestore
      var querySnapshot = await FirebaseFirestore.instance
          .collection('client_user')
          .where('unique_id', isEqualTo: uniqueId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        exists = false; // Unique ID found
      }
    }

    return uniqueId;
  }

  Future<void> _fetchCompanyList() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('company_list').get();
      List<String> companies =
          snapshot.docs.map((doc) => doc['company_name'] as String).toList();
      setState(() {
        _companyList = companies;
      });
    } catch (e) {
      // Handle errors if necessary
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          if (_isLoading)
            Container(
              color:
                  Colors.black.withOpacity(0.5), // Semi-transparent background
              child: const Center(
                child: CircularProgressIndicator(), // Loading indicator
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Material(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stepper(
                            currentStep: _index,
                            onStepCancel: () {
                              if (_index > 0) {
                                setState(() {
                                  _index -= 1;
                                });
                              }
                            },
                            onStepContinue: () {
                              if (_index < 2) {
                                // Change this to the maximum step index.
                                setState(() {
                                  _index += 1;
                                });
                              } else {
                                // Handle the final step submission, e.g., register the user.
                              }
                            },
                            onStepTapped: (int index) {
                              setState(() {
                                _index = index;
                              });
                            },
                            controlsBuilder: (BuildContext context,
                                ControlsDetails details) {
                              return Row(
                                children: <Widget>[
                                  if (_index !=
                                      2) // Only show "Next" or "Register" button if not on the last step
                                    TextButton(
                                      onPressed: details.onStepContinue,
                                      child: Text(
                                          _index == 2 ? 'Register' : 'Next'),
                                    ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: details.onStepCancel,
                                    child: const Text('Back'),
                                  ),
                                ],
                              );
                            },
                            steps: <Step>[
                              Step(
                                title: const Text('Create an account'),
                                content: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.email),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Personal email',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(
                                              Icons.password_rounded),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: IconButton(
                                              onPressed: _toggleObscured,
                                              icon: Icon(
                                                _obscured
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                        .visibility_off_rounded,
                                              ),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Password',
                                        ),
                                        obscureText: _obscured,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: _passwordController2,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(
                                              Icons.password_rounded),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: IconButton(
                                              onPressed: _toggleObscured2,
                                              icon: Icon(
                                                _obscured2
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                        .visibility_off_rounded,
                                              ),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Re-enter Password',
                                        ),
                                        obscureText: _obscured2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Step(
                                title: const Text('Enter personal details'),
                                content: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _firstNameController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.person),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'First Name',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _lastNameController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.person),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Last Name',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.phone),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Phone Number',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Step(
                                title:
                                    const Text('Enter company/campus detail'),
                                content: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      DropdownButtonFormField<String>(
                                        value: _selectedCompany,
                                        items:
                                            _companyList.map((String company) {
                                          return DropdownMenuItem<String>(
                                            value: company,
                                            child: Text(company),
                                          );
                                        }).toList(),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.work),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Company/Campus',
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedCompany = newValue;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _companyEmailController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon: const Icon(
                                              Icons.alternate_email_rounded),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Company/Campus Email',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _companyId,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon:
                                              const Icon(Icons.badge_rounded),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Company/Campus ID',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _companyAddressController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          prefixIcon:
                                              const Icon(Icons.holiday_village),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: 'Room/Desk/Office Address',
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Card(
                                          //color: Theme.of(context).colorScheme.surfaceVariant,
                                          elevation: 0,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: SizedBox(
                                              child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                child: Material(
                                                  color: const Color.fromARGB(
                                                      0, 255, 193, 7),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (_emailController.text.isEmpty ||
                                                          _passwordController
                                                              .text.isEmpty ||
                                                          _passwordController2
                                                              .text.isEmpty ||
                                                          _firstNameController
                                                              .text.isEmpty ||
                                                          _phoneController
                                                              .text.isEmpty ||
                                                          _lastNameController
                                                              .text.isEmpty ||
                                                          _companyId
                                                              .text.isEmpty ||
                                                          _companyEmailController
                                                              .text.isEmpty ||
                                                          _companyAddressController
                                                              .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: const Text(
                                                                'Details not complete'),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'OK',
                                                              onPressed: () {
                                                                // Code to execute.
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        // User is not registered, initiate the registration process
                                                        _registerUser();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 15,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            //width: MediaQuery.of(context).size.width - 180,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                        child: Padding(
                                                                            padding: EdgeInsets.only(),
                                                                            child: Text("Register",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w600,
                                                                                ))))
                                                                  ],
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
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Material(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Card(
                              //color: Theme.of(context).colorScheme.surfaceVariant,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: SizedBox(
                                  child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreenNew()),
                                          );
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                            top: 15,
                                            bottom: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                //width: MediaQuery.of(context).size.width - 180,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(),
                                                                child: Text(
                                                                    "Back to login page",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ))))
                                                      ],
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
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
