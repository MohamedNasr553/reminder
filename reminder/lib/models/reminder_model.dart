class ReminderAppModel{
  String? status;
  int? results;
  ReminderDataModel? data;

  ReminderAppModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    results = json['results'];
    data = json['data'] != null ? ReminderDataModel.fromJson(json['data']) : null;
  }
}

class ReminderDataModel {
  List<ReminderModel> reminderData = [];

  ReminderDataModel.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element) {
      reminderData.add(ReminderModel.fromJson(element));
    });
  }
}

class ReminderModel{
  String? _id;
  String? name;
  String? description;
  String? startDate;
  String? id;

  ReminderModel.fromJson(Map<String, dynamic> json){
    _id = json['_id'];
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    id = json['id'];
  }
}