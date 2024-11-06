import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/screens/auth/component/bottom_alert.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:ecommerce_app/utils/constant/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {
  const Auth({super.key, required this.currentAuth});
  final bool currentAuth;

  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<Auth> {
  bool showPassword = false;
  bool showConfirmPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool authLoading = false;
  bool checkBox = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _showScafforlMessage(String title) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }

  void _modalBottomOverplay(String content) {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => BottomAlert(
              title: content,
            ));
  }

  void _onSubmit() async {
    final email = _emailController.text;
    final password = _passWordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (widget.currentAuth &&
        confirmPassword == '' &&
        confirmPassword != password) {
      _showScafforlMessage('Please match confirm password with password');
      return;
    }

    if (widget.currentAuth && checkBox == false) {
      _showScafforlMessage('Check agree term');
      return;
    }

    try {
      setState(() {
        authLoading = true;
      });
      _formKey.currentState!.save();
      if (widget.currentAuth == false) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((_) {
          _modalBottomOverplay('Login sucessful!');
        });
      } else {
        final crendital = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(crendital.user!.uid)
            .set({
          'email': email,
        }).then((_) {
          _modalBottomOverplay('Signup sucessful!');
        });
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() {
        authLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      _showScafforlMessage(e.message!);
      setState(() {
        authLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String authState =
        widget.currentAuth ? 'Signup with Email' : 'Login with Email';

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          authState,
          style:
              Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Email'),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: emaildValidator.call,
                            onSaved: (value) {
                              setState(() {
                                _emailController.text = value!;
                              });
                            },
                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: alert200, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: neutral500, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: neutral950, width: 1)),
                                border: InputBorder.none,
                                hintText: 'Enter your email',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: neutral500)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Password'),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _passWordController,
                            obscureText: !showPassword,
                            onSaved: (value) {
                              setState(() {
                                _passWordController.text = value!;
                              });
                            },
                            validator: passwordValidator.call,
                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: alert200, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: neutral500, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: neutral950, width: 1)),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(showPassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off_outlined),
                                ),
                                border: InputBorder.none,
                                hintText: 'Enter your password',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: neutral500)),
                          )
                        ],
                      ),
                      if (widget.currentAuth)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            const Text('Confirm Password'),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              obscureText: !showConfirmPassword,
                              onSaved: (value) {
                                setState(() {
                                  _confirmPasswordController.text = value!;
                                });
                              },
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: alert200, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: neutral500, width: 1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: neutral950, width: 1)),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showConfirmPassword =
                                            !showConfirmPassword;
                                      });
                                    },
                                    child: Icon(showConfirmPassword
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Enter your password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: neutral500)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: checkBox,
                                    onChanged: (value) {
                                      setState(() {
                                        checkBox = value!;
                                      });
                                    }),
                                const Text('Agree with Term & Condition')
                              ],
                            )
                          ],
                        ),
                      if (widget.currentAuth == false)
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, recoveryRoute),
                            child: Text(
                              'Forgot password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: neutral950),
                            ),
                          ),
                        )
                    ],
                  )),
              const SizedBox(
                height: 48,
              ),
              authLoading == false
                  ? BoxButton(
                      title: widget.currentAuth ? 'Signup' : 'Login',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _onSubmit();
                        }
                      })
                  : const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
