import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/facts.dart';
import 'models/person.dart';

void main() {
  runApp(const MyApp());
}

// \/\/.*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Start',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Start'),
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
  Person developer = Person(firstName: 'Adam', lastName: 'Ivaniush');
  double personContainerHeight = 0; // Animated container height
  int factIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        personContainerHeight = 300;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: GoogleFonts.unbounded(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Container(
        // Background Gradient container
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-1.0, 1.0),
            radius: 1.4,
            colors: [Color(0xFFFFCBFF), Color(0xFFFFF0FF), Color(0xFFFFEDCB)],
            // Purple, White, Yellow
            stops: [0.0, 0.48, 1.0],
          ),
        ),
        child: Center(
          child: AnimatedSize(
            duration: const Duration(seconds: 2),
            alignment: Alignment.topCenter,
            curve: Curves.easeInOutCubic,
            child: Container(
              // Person Container
              width: 300,
              height: personContainerHeight, // Parameter to animate
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(developer.fullName,
                      style: GoogleFonts.unbounded(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 41, 255, 1))),
                  const SizedBox(height: 12),
                  Text('Вік: ${developer.age}',
                      style: GoogleFonts.unbounded(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 41, 255, 1))),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () => _getFact(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEDCB),
                      ),
                      child: Text(
                        'Отримати фактичний факт',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.unbounded(
                            fontSize: 14, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        _changeRandomPersonName();
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEDCB),
                      ),
                      child: Text(
                        'Змінити ім\'я та вік',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.unbounded(
                            fontSize: 14, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changeRandomPersonName() {
    int fullNameIndex = Random().nextInt(firstNameList.length);
    developer.firstName = firstNameList[fullNameIndex];
    developer.lastName = lastNameList[fullNameIndex];
    developer.setAge = Random().nextInt(40) + 20;
  }

  void _getFact(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, animation1, animation2, child) {
          String selectedFact = empatFacts[factIndex];
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation1),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0.3,
                end: 1,
              ).animate(animation1),
              child: AlertDialog(
                title: const Text('Факт'),
                content: Text(selectedFact),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Закрити'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _getFact(context);
                      },
                      child: const Text('Наступний факт')),
                ],
              ),
            ),
          );
        });
    factIndex++;
    if (factIndex >= empatFacts.length) factIndex = 0;
  }
}
