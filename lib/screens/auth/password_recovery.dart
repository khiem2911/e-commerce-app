import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:ecommerce_app/utils/constant/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _onSendOTP() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then((_) {
        setState(() {
          isLoading = false;
        });
        DelightToastBar(
                builder: (context) {
                  return const ToastCard(
                      leading: Icon(
                        Icons.notifications_active_rounded,
                        size: 32,
                      ),
                      title: Text('We have sent a link to your email'));
                },
                autoDismiss: true,
                snackbarDuration: Durations.extralong4)
            .show(context);
        Navigator.of(context).pop();
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Password Recovery',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 28),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Enter your email id for verification process, we will send a link to your email',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.normal, color: neutral900),
              ),
              const SizedBox(
                height: 48,
              ),
              const Text('Email'),
              const SizedBox(
                height: 8,
              ),
              Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    validator: emaildValidator.call,
                    onSaved: (value) {
                      setState(() {
                        _emailController.text = value!;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your email',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: neutral950)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: neutral500))),
                  )),
              const SizedBox(
                height: 48,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : BoxButton(title: 'Send Code', onTap: _onSendOTP)
            ],
          ),
        ));
  }
}
