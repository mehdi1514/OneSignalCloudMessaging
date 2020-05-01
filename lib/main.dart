import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String notifyContent = '';

  @override
  void initState() {
    configOneSignal();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eample App"),
      ),
      body: Center(
        child: Text(notifyContent),
      ),
    );
  }

  void configOneSignal() async{
    try{
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
      await OneSignal.shared.init("24256d7c-3c41-4031-a42c-de8b6d276646");

      OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

      OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
        // will be called whenever a notification is received
        setState(() {
          notifyContent = notification.jsonRepresentation().replaceAll("\\n", "\n");
        });
      });


    }catch(e){
      print("The error is $e");
    }
  }
}


