class PointsModel {
  List<Task>? task;

  PointsModel({this.task});

  PointsModel.fromJson(Map<String, dynamic> json) {
    if (json['task'] != null) {
      task = <Task>[];
      json['task'].forEach((v) {
        task!.add(new Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.task != null) {
      data['task'] = this.task!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
  String? sId;
  int? points;
  String? task;
  String? user;

  Task({this.sId, this.points, this.task, this.user});

  Task.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    points = json['points'];
    task = json['task'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['points'] = this.points;
    data['task'] = this.task;
    data['user'] = this.user;
    return data;
  }
}
