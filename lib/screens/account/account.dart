import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    void _onSignOut() async {
      await FirebaseAuth.instance.signOut().then((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, loginRoute, ((Route<dynamic> route) => false));
      });
    }

    return Scaffold(
        appBar: AppBar(
            title: ListTile(
          title: Text(
            'Account',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
          ),
          trailing: const Icon(Icons.notifications_none_outlined),
        )),
        body: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, profileRoute),
              child: ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: Text(
                  'Your Profile',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: neutral200, width: 1)),
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, orderRoute),
              child: ListTile(
                leading: const Icon(Icons.list_alt),
                title: Text(
                  'My Order',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: neutral200, width: 1)),
            ),
            const SizedBox(
              height: 48,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: alert200,
              ),
              title: InkWell(
                onTap: _onSignOut,
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: alert200),
                ),
              ),
            )
          ],
        ));
  }
}
