import 'package:ferdinand_coffee/components/form.dart';
import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/services/admin/accept_task.dart';
import 'package:ferdinand_coffee/services/admin/reject_task.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskVideoPage extends StatefulWidget {
  const TaskVideoPage({Key? key, this.taskDetails}) : super(key: key);
  static String route = '/task-video';
  final Map<String, dynamic>? taskDetails;
  @override
  State<TaskVideoPage> createState() => _TaskVideoPageState();
}

class _TaskVideoPageState extends State<TaskVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.taskDetails?["video"],
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  String? points;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Task video')),
      backgroundColor: Constants.scaffoldColor,
      body: ListView(children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            AppLocalizations.of(context)!.accepttaskInstruction(
                _controller.value.duration.inSeconds / 60),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MainSubmitButton(
            function: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            buttonlabel: _controller.value.isPlaying
                ? AppLocalizations.of(context)!.pauseVideo
                : AppLocalizations.of(context)!.playVideo),
        const SizedBox(
          height: 20,
        ),
        MainSubmitButton(
            function: () {
              //open a dilaog box and enter the points to be awarded
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.pointsAward),
                      content: CustomFormField(
                        inputType: TextInputType.number,
                        onChanged: (v) {
                          points = v;
                        },
                      ),
                      actions: [
                        MainSubmitButton(
                            function: () {
                              AcceptTasksApi acceptTasksApi = AcceptTasksApi();
                              acceptTasksApi.rejectTask(
                                  widget.taskDetails?["taskId"],
                                  points,
                                  context);
                            },
                            buttonlabel: 'Einreichen')
                      ],
                    );
                  });
            },
            buttonlabel: AppLocalizations.of(context)!.acceptTask),
        const SizedBox(
          height: 20,
        ),
        MainSubmitButton(
            buttoncolor: Colors.red,
            function: () {
              RejectTasksApi rejectTasksApi = RejectTasksApi();
              rejectTasksApi.rejectTask(widget.taskDetails?["taskId"], context);
            },
            buttonlabel: AppLocalizations.of(context)!.rejectTask),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
