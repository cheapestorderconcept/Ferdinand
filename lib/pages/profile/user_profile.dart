import 'package:ferdinand_coffee/components/common.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  static const routeName = "/user/profile";

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Personal Profile'),
        actions: [
          Image.asset('assets/icons/logo.png'),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Edit Profile',
              style: TextStyle(color: Constants.greyColor)),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'You can edit Personal details such as name and password',
                style: TextStyle(color: Constants.greyColor, fontSize: 11)),
          ),
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: CircleAvatar(
              radius: 49,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png'),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: textFieldTextStyle(),
                  decoration: InputDecoration(
                    border: textFieldBorder(),
                    enabledBorder: textFieldEnabledBorder(),
                    focusedBorder: textFieldFocusedBorder(),
                    labelText: 'First Name',
                    hintStyle: textFieldHintStyle(),
                    labelStyle: textFieldHintStyle(),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextFormField(
                  style: textFieldTextStyle(),
                  decoration: InputDecoration(
                    border: textFieldBorder(),
                    enabledBorder: textFieldEnabledBorder(),
                    focusedBorder: textFieldFocusedBorder(),
                    labelText: 'Last Name',
                    hintStyle: textFieldHintStyle(),
                    labelStyle: textFieldHintStyle(),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            style: textFieldTextStyle(),
            decoration: InputDecoration(
              border: textFieldBorder(),
              enabledBorder: textFieldEnabledBorder(),
              focusedBorder: textFieldFocusedBorder(),
              hintText: '+91 - 7000107778',
              hintStyle: textFieldHintStyle(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            style: textFieldTextStyle(),
            decoration: InputDecoration(
              border: textFieldBorder(),
              enabledBorder: textFieldEnabledBorder(),
              focusedBorder: textFieldFocusedBorder(),
              hintText: 'Email',
              hintStyle: textFieldHintStyle(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Constants.orangeColor,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Save Profile',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
