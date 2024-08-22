import 'package:flutter/material.dart';

import 'another_page.dart';
import 'local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    listenNotification();
    super.initState();
  }
  
  //to listen any notification
  
  listenNotification(){
    LocalNotifications.onClickNotification.stream.listen((event){
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => AnotherPage(payload: event)));
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification testing'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
              icon: const Icon(Icons.notifications),
              onPressed: (){
                LocalNotifications.showSimpleNotification(
                    title: 'test',
                    body: 'I have big dream',
                    payload: "I have a notification");
              },
              label: const Text('Simple notification'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.timer),
            onPressed: (){
              LocalNotifications.showPeriodicNotification(
                  title: 'periodic',
                  body: 'periodic notification',
                  payload: "I have a notification");
            },
            label: const Text('periodic notification'),
          ),

          ElevatedButton.icon(
            icon: const Icon(Icons.timer),
            onPressed: (){
              LocalNotifications.cancel(1);
            },
            label: const Text('close periodic notification'),
          ),

          ElevatedButton.icon(
            icon: const Icon(Icons.schedule_outlined),
            onPressed: (){
              LocalNotifications.showScheduleNotification(
                  title: 'schedule notification',
                  body: 'periodic notification',
                  payload: "I have a notification");
            },
            label: const Text('schedule notification'),
          ),

          ElevatedButton.icon(
            icon: const Icon(Icons.timer),
            onPressed: (){
              LocalNotifications.cancelAll();
            },
            label: const Text('close all notification'),
          ),

        ],
      ),
    );
  }
}
