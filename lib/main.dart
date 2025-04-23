import 'package:flutter/material.dart';
import 'package:frontend/screens/add_plant.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/group_overview.dart';
import 'package:frontend/screens/home_activity_history.dart';
import 'package:frontend/screens/home_overview.dart';
import 'package:frontend/screens/plant_overview.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/sign_in.dart';
import 'package:frontend/screens/sing_up.dart';
import 'package:frontend/screens/start.dart';
import 'package:frontend/screens/task_overview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Powerplants',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Manrope',
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('de')],
      routes: {
        '/start': (context) => const Start(),
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
        '/homeoverview': (context) => const HomeOverview(),
        '/dashboard': (context) => const Dashboard(),
        '/groupoverview': (context) => const GroupOverview(),
        '/plantoverview': (context) => const PlantOverview(),
        '/taskoverview': (context) => const TaskOverview(),
        '/profile': (context) => const Profile(),
        '/homeactivityhistory': (context) => const HomeActivityHistory(),
        '/addplant': (context) => const AddPlant(),
      },
      home: GroupOverview(),
    );
  }
}
