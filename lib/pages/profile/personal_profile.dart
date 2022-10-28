import 'package:ferdinand_coffee/components/custominputfield.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/pages/product_details/product_details.dart';
import 'package:ferdinand_coffee/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/mainsubmitbutton.dart';
import '../../services/auth/profile.dart';
import '../../utils/helpers/fetch_image.dart';

class PersonalProfilePage extends StatefulWidget {
  static const routeName = "/home/personal_profile";
  const PersonalProfilePage({Key? key}) : super(key: key);

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  @override
  void initState() {
    UserProfileApi profileApi = UserProfileApi();
    final currentUser =
        Provider.of<ProfileProvider>(context, listen: false).myprofileModel;
    firstName = TextEditingController(text: currentUser?.firstName ?? "");
    lastName = TextEditingController(text: currentUser?.lastName ?? "");
    phoneNumber = TextEditingController(text: currentUser?.phoneNumber ?? "");
    email = TextEditingController(text: currentUser?.email ?? "");
    profileApi.userProfile(context);
    super.initState();
  }

  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? phoneNumber;
  TextEditingController? email;
  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<ProfileProvider>(context, listen: false).myprofileModel;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.personalProfile,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: '',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                            text: AppLocalizations.of(context)!.yourProfileInfo,
                            style: const TextStyle(
                              fontSize: 12,
                            )),
                      ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        fetchImage(
                            currentUser?.image != null
                                ? '${Constants.baseUrl}/admin/download-image/${currentUser?.image}/${Constants.imageBucket}'
                                : 'https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg',
                            100,
                            100,
                            true),
                        Positioned(
                          top: 80,
                          left: 90,
                          child: Image.asset(
                            'assets/icons/Icon feather-ed.png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.4,
                    child: InputTextFormField(
                      controller: firstName,
                      labeltext: AppLocalizations.of(context)!.firstName,
                      preiconimage: 'assets/icons/Path 11746.png',
                      suficonimage: 'assets/icons/Path 11133.png',
                    ),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: width * 0.4,
                    child: InputTextFormField(
                      controller: lastName,
                      labeltext: AppLocalizations.of(context)!.lastName,
                      preiconimage: 'assets/icons/Path 11746.png',
                      suficonimage: 'assets/icons/Path 11133.png',
                    ),
                  ),
                ],
              ),
              InputTextFormField(
                controller: phoneNumber,
                labeltext: AppLocalizations.of(context)!.phoneNumber,
                preiconimage: 'assets/icons/Path 11745.png',
                suficonimage: 'assets/icons/Path 11133.png',
              ),
              InputTextFormField(
                controller: email,
                labeltext: 'Email',
                preiconimage: 'assets/icons/envelope.png',
                suficonimage: 'assets/icons/Path 11133.png',
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: MainSubmitButton(
                  function: () {
                    Map<String, dynamic> data = {
                      "first_name": firstName?.text,
                      "last_name": lastName?.text,
                      "phone_number": phoneNumber?.text
                    };
                    UpdateUserProfileApi _updateProfile =
                        UpdateUserProfileApi();
                    _updateProfile.updateProfile(data, context);
                  },
                  buttonlabel: AppLocalizations.of(context)!.saveChanges,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
