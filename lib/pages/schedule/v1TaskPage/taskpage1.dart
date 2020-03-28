import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/api/schedule_api.dart';
import 'package:flutter_secret_chat/models/schedule_user.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:flutter_secret_chat/providers/schedule.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_button.dart';
import 'package:flutter_secret_chat/widgets/notification/local_notifications_helpers.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../../../app_config.dart';
import 'dart:convert';

class TaskPage extends StatefulWidget {
  final userId;

  const TaskPage({Key key, this.userId}) : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class Job {
  final int id;
  final String date;
  final String description;

//  Job({this.id, this.position, this.company, this.description});
  Job({this.id, this.date,  this.description});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      date: json['date'],
      description: json['description'],

    );
  }
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;

          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl = 'http://192.168.0.18:5000/api/v1/users/getUserSchedule';
    final response = await http.post(
        jobsListAPIUrl, body: { "userId": "5e671cd405a72504f8d81e15"});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].date, data[index].description, Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
}