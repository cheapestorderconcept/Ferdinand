import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/services/auth/upload_task.dart';
import 'package:ferdinand_coffee/services/images/upload_images.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/fluttertoast.dart';

class EarnPointsPage extends StatefulWidget {
  const EarnPointsPage({Key? key}) : super(key: key);
  static String route = '/earn-points';
  @override
  State<EarnPointsPage> createState() => _EarnPointsPageState();
}

class _EarnPointsPageState extends State<EarnPointsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 25,
        title: Text(AppLocalizations.of(context)!.earnPoints,
            style: const TextStyle()),
        actions: [
          Image.asset(
            'assets/icons/logo.png',
            scale: 6,
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.pointsWelcome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.pointsInstruction,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            PointsInstruction(
              sn: '1.',
              instruction: AppLocalizations.of(context)!.instructionOne,
            ),
            const SizedBox(
              height: 20,
            ),
            PointsInstruction(
              sn: '2.',
              instruction: AppLocalizations.of(context)!.instructionTwo,
            ),
            const SizedBox(
              height: 20,
            ),
            PointsInstruction(
              sn: '3.',
              instruction: AppLocalizations.of(context)!.instructionThree,
            ),
            const SizedBox(
              height: 20,
            ),
            PointsInstruction(
              sn: '4.',
              instruction: AppLocalizations.of(context)!.instructionFour,
            ),
            const SizedBox(
              height: 20,
            ),
            PointsInstruction(
              sn: '5.',
              instruction: AppLocalizations.of(context)!.instructionFive,
            ),
            const SizedBox(
              height: 20,
            ),
            PointsInstruction(
              sn: '6.',
              instruction: AppLocalizations.of(context)!.instructionSix,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.pointsWarningOne,
              // strutStyle: StrutStyle(),
              style: const TextStyle(color: Colors.white, height: 2),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.pointsWarningTwo,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.taskAppreciation,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            MainSubmitButton(
                function: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ["mp4"]);
                  if (result != null) {
                    ImageUploader image = ImageUploader();
                    String? key = await image.uploadImage('bobo',
                        '${result.files.single.path}', 'video', 'mp4', context);
                    if (key != null) {
                      UploadTaskApi uploadTaskApi = UploadTaskApi();
                      uploadTaskApi.upload(key, context);
                    } else {
                      displayToast(Colors.red, Colors.white,
                          'Aufgabe nicht erfolgreich hochgeladen');
                    }
                  } else {
                    displayToast(Colors.red, Colors.white,
                        "Please select a video to upload");
                  }
                },
                buttonlabel: AppLocalizations.of(context)!.uploadTask),
          ],
        ),
      ),
    );
  }
}

class PointsInstruction extends StatelessWidget {
  const PointsInstruction({Key? key, this.sn, this.instruction})
      : super(key: key);
  final String? sn;
  final String? instruction;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$sn',
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            '$instruction',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
