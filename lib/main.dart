import 'package:flutter/material.dart';
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
      },
      home: const MyHomePage(title: 'Powerplants'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
