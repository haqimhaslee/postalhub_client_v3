import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postalhub_client/auth/new_login/login.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _companyId = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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

  String? _selectedCompany;
  List<String> _companyList = [];

  @override
  void initState() {
    super.initState();
    _fetchCompanyList();
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

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                      borderRadius: BorderRadius.circular(10.0),
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text('Company Details'),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCompany,
                  items: _companyList.map((String company) {
                    return DropdownMenuItem<String>(
                      value: company,
                      child: Text(company),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.work),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Company',
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
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Company Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _companyId,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Staff/Student ID',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _companyAddressController,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.holiday_village),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Company Table/Room Address',
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text('Personal Email'),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Personal email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.password_rounded),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                        onPressed: _toggleObscured,
                        icon: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: _obscured,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController2,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.password_rounded),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                        onPressed: _toggleObscured2,
                        icon: Icon(
                          _obscured2
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Re-enter Password',
                  ),
                  obscureText: _obscured2,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SizedBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            child: Material(
                              color: const Color.fromARGB(0, 255, 193, 7),
                              child: InkWell(
                                onTap: () async {
                                  String firstName = _firstNameController.text;
                                  String lastName = _lastNameController.text;
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  String companyAddress =
                                      _companyAddressController.text;
                                  String phone = _phoneController.text;
                                  String companyId = _companyId.text;
                                  String companyName = _selectedCompany ?? '';
                                  String companyEmail =
                                      _companyEmailController.text;

                                  Map<String, dynamic> userData = {
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
                                    'profile_pic':
                                        'https://firebasestorage.googleapis.com/v0/b/postalhub.appspot.com/o/user_client_profile%2FFxVu4GjMMSX6oRwuLiqWAbiqNhx2?alt=media&token=87558fcd-42b0-4ea7-9886-dbbbd479d67b',
                                  };

                                  await authService
                                      .registerWithEmailAndPassword(
                                          email, password, userData);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                    padding: EdgeInsets.only(),
                                                    child: Text(
                                                      "Register",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Card(
                    //color: Theme.of(context).colorScheme.surfaceVariant,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SizedBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            child: Material(
                              color: const Color.fromARGB(0, 255, 193, 7),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                    padding: EdgeInsets.only(),
                                                    child: Text(
                                                      "Back to Login",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
