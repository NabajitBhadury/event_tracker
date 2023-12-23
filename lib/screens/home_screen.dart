import 'package:event_tracker/screens/qr_scanner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> mealCount = {
    'Breakfast': 0,
    'Lunch': 0,
    'Dinner': 0,
  };

  Map<String, DateTime> lastScanTimes = {
    'Breakfast': DateTime(2000),
    'Lunch': DateTime(2000),
    'Dinner': DateTime(2000),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Breakfast'),
                  Text('${mealCount['Breakfast'] ?? 0}'),
                ],
              ),
              onTap: () {
                DateTime now = DateTime.now();
                DateTime today = DateTime(now.year, now.month, now.day,
                    now.hour, now.minute, now.second);
                if (lastScanTimes['Breakfast']!.day != today.day) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScannerScreen(
                        onScan: (String scanResult) {
                          setState(() {
                            mealCount['Breakfast'] =
                                (mealCount['Breakfast'] ?? 0) + 1;
                          });
                        },
                      ),
                    ),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text('Scan limit exceeded'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              )
                            ]);
                      });
                }
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Lunch'),
                  Text('${mealCount['Lunch'] ?? 0}'),
                ],
              ),
              onTap: () {
                DateTime now = DateTime.now();
                DateTime today = DateTime(now.year, now.month, now.day,
                    now.hour, now.minute, now.second);
                if (lastScanTimes['Lunch']!.day != today.day) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScannerScreen(
                        onScan: (String scanResult) {
                          setState(() {
                            mealCount['Lunch'] = (mealCount['Lunch'] ?? 0) + 1;
                          });
                        },
                      ),
                    ),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text('Scan limit exceeded'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              )
                            ]);
                      });
                }
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dinner'),
                  Text('${mealCount['Dinner'] ?? 0}'),
                ],
              ),
              onTap: () {
                DateTime now = DateTime.now();
                DateTime today = DateTime(now.year, now.month, now.day,
                    now.hour, now.minute, now.second);
                if (lastScanTimes['Dinner']!.day != today.day) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScannerScreen(
                        onScan: (String scanResult) {
                          setState(() {
                            mealCount['Dinner'] =
                                (mealCount['Dinner'] ?? 0) + 1;
                          });
                        },
                      ),
                    ),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text('Scan limit exceeded'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              )
                            ]);
                      });
                }
              },
            ),
          ],
        ));
  }
}
