import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/points_model.dart';
import 'package:ferdinand_coffee/pages/points-system/task_video.dart';
import 'package:ferdinand_coffee/pages/product_details/product_details.dart';
import 'package:ferdinand_coffee/services/admin/view_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

class AwardPointsPage extends StatefulWidget {
  const AwardPointsPage({Key? key}) : super(key: key);
  static String route = '/award-points';
  @override
  State<AwardPointsPage> createState() => _AwardPointsPageState();
}

class _AwardPointsPageState extends State<AwardPointsPage> {
  var future;
  @override
  void initState() {
    ViewTasksApi viewTasksApi = ViewTasksApi();
    future = viewTasksApi.viewTask(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.awardPoints,
      ),
      body: FutureBuilder<PointsModel?>(
        future: future,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.builder(
                itemCount: snapShot.data?.task?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TaskVideoPage(
                            taskDetails: {
                              "taskId": snapShot.data?.task?[index].sId,
                              "video":
                                  '${Constants.baseUrl}/admin/download-image/${snapShot.data?.task?[index].task}/${Constants.imageBucket}',
                            },
                          );
                        }));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            'Erledigte Aufgabe ${index + 1}, Zum Ansehen klicken',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  );
                });
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(
                'Aufgaben abrufen...',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }
          {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noTask,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
