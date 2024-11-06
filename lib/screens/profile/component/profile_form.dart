import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileFormState();
  }
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final genderController = TextEditingController();
  final numberController = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  Future<void> _onSelecteDate() async {
    final DateTime? picked = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2200));

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _onSubmitForm() async {
    bool checked = _formKey.currentState!.validate();

    if (checked == false) {
      return;
    }

    _formKey.currentState!.save();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullname': fullNameController.text,
      'email': emailController.text,
      'date': dateController.text,
      'gender': genderController.text,
      'phone': numberController.text
    }, SetOptions(merge: true));
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    dateController.dispose();
    genderController.dispose();
    numberController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  void _getUserProfile() async {
    final res = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final fullname = res.data()!['fullname'] ?? '';
    final email =
        res.data()!['email'] ?? FirebaseAuth.instance.currentUser!.email;
    final date = res.data()!['date'] ?? '';
    final gender = res.data()!['gender'] ?? '';
    final phone = res.data()!['phone'] ?? '';

    setState(() {
      fullNameController.text = fullname;
      emailController.text = email;
      dateController.text = date;
      genderController.text = gender;
      numberController.text = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Full Name'),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: neutral200, width: 1)),
                child: TextFormField(
                  controller: fullNameController,
                  onSaved: (value) => setState(() {
                    fullNameController.text = value!;
                  }),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Email Address'),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: neutral200, width: 1)),
                child: TextFormField(
                  controller: emailController,
                  onSaved: (value) => setState(() {
                    emailController.text = value!;
                  }),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Date of Birth'),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: neutral200, width: 1)),
                child: TextFormField(
                  onSaved: (value) => setState(() {
                    dateController.text = value!;
                  }),
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: _onSelecteDate,
                          icon: const Icon(Icons.date_range))),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Gender'),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                hint: const Text(
                  'Select Your Gender',
                  style: TextStyle(fontSize: 14),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    genderController.text = value!;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Phone Number'),
              IntlPhoneField(
                controller: numberController,
                onSaved: (value) => setState(() {
                  numberController.text = value!.number.toString();
                }),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'VN',
              ),
              const SizedBox(
                height: 48,
              ),
              BoxButton(title: 'Saved', onTap: _onSubmitForm)
            ],
          ),
        ));
  }
}
