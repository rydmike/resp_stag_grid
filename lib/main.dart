import 'dart:math';

import 'package:flutter/material.dart';

import 'about.dart';
import 'random_color.dart';
import 'staggered_grid_example1.dart';
import 'staggered_grid_example3.dart';
import 'standard_grid_example.dart';

/// Demo of how to use breakpoints and varying column size with Flutter standard
/// Grid and by using Romain Rastel's Staggered Gridview package
/// https://pub.dev/packages/flutter_staggered_grid_view
///
/// This simple example is designed for Flutter Web and Desktop.
///
/// The 1st version of this demo was made with with
/// Flutter master v1.10.3-pre.67 on a Windows 10 desktop 18.9.2019
/// That build is still running here: https://rydmike.com/gridtest/#/
/// As a "side effect" it back then demoed how to setup Flutter WEB and Desktop
/// in the same project. Back then you needed 'dart.io' in Flutter Desktop but
/// it does not compile in Flutter WEB. To get around this the use of a
/// conditional Dart lib import was demonstrated. It used Staggered Grid version
/// 0.3.0 in that build
/// https://pub.dev/packages/flutter_staggered_grid_view/versions/0.3.0
///
///
/// These extra setups for combined desktop and web build are no longer needed
/// and we can build the same demo with latest release of Flutter 2.8.0 and
/// latest packages. We can however still see the
/// issues with Staggered Grid in that build when using Staggered Grid v 0.4.1
/// https://pub.dev/packages/flutter_staggered_grid_view/versions/0.4.1
/// It can be tested here:
///
/// But if we switch to the new one 0.5.0-dev.1 the issues are solved:
/// https://pub.dev/packages/flutter_staggered_grid_view/versions/0.5.0-dev.1
/// It can be tested here:
///

const int kItemCount = 200;

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Grid Demos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.indigo[700]!,
        ),
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final List<double> rndSpaceAbove = <double>[];
  final List<double> rndSpaceBelow = <double>[];
  final List<MaterialColor> randomColors = <MaterialColor>[];
  final Random random = Random();
  List<bool> isSelected = <bool>[false, true, false, false, false, false];
  // Value used to divide the amount of columns with that the breakpoint class
  // gives.
  int columnDiv = 2;

  @override
  void initState() {
    super.initState();
    // Make some random double numbers that we can use to size the grid
    // items with, but let's keep the same random numbers
    // so we can compare the layout results.
    for (int i = 0; i < kItemCount; i++) {
      rndSpaceAbove.add(20.0 + random.nextDouble() * 120);
      rndSpaceBelow.add(15.0 + random.nextDouble() * 100);
      randomColors.add(RandomColor().randomMaterialColor());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Grid Demos'),
        elevation: 0,
        actions: const <Widget>[AboutIconButton()],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                    const Expanded(
                      flex: 10,
                      child: Text(
                        'Demo of responsive grid layouts based on '
                        'breakpoints and changing column sizes',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                    const Expanded(
                      flex: 10,
                      child: Text(
                        'This example is designed for Flutter Desktop or WEB, '
                        'where you have larger surface and can resize the '
                        'window. It will run OK on phones and tablets as '
                        'well, but the demo is less interesting on them.\n'
                        'The used breakpoint system is based on the 12 column '
                        'Material design standard and is included in the '
                        'example code.',
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(children: <Widget>[
                  Expanded(child: Container()),
                  const Expanded(
                    flex: 10,
                    child: Text(
                      'To test different sized columns, choose a value below '
                      'to divide the total columns with. The total columns '
                      'refer to the number of columns that are available for '
                      "the current layout width's breakpoint.",
                    ),
                  ),
                  Expanded(child: Container()),
                ]),
                const SizedBox(height: 8),
                Row(children: <Widget>[
                  Expanded(child: Container()),
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          if (i == index) {
                            isSelected[i] = true;
                            columnDiv = index + 1;
                          } else {
                            isSelected[i] = false;
                          }
                        }
                      });
                    },
                    isSelected: isSelected,
                    children: <Widget>[
                      for (int i = 1; i <= 6; i++)
                        Padding(
                            padding: const EdgeInsets.fromLTRB(27, 10, 27, 10),
                            child: Text('$i')),
                    ],
                  ),
                  Expanded(child: Container()),
                ]),
                const SizedBox(height: 20),
                Row(children: <Widget>[
                  Expanded(child: Container()),
                  const Expanded(
                    flex: 10,
                    child: Text(
                      'The standard grid item is a fixed aspect ratio '
                      'rectangle and cannot vary its height to fit the '
                      'content. You can see the challenge with this '
                      'in this example if you make the columns too small by '
                      'selecting 1 or 2 above.',
                    ),
                  ),
                  Expanded(child: Container()),
                ]),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push<Widget>(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                              StandardGridExample(
                            spaceAbove: rndSpaceAbove,
                            spaceBelow: rndSpaceBelow,
                            colors: randomColors,
                            columnDiv: columnDiv,
                          ),
                        ),
                      );
                    },
                    child: const Text('Standard grid demo'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: <Widget>[
                  Expanded(child: Container()),
                  const Expanded(
                    flex: 10,
                    child: Text(
                      'The staggered grid can fit the height and make a '
                      'masonry style layout automatically. \nThere is however '
                      'an issue that makes it occasionally drop items '
                      'from the grid when you resize the window width. '
                      'Sometimes it also does not rebuild correctly when '
                      'resizing the window size, especially if changing only '
                      'the width. This issue occurs on all versions before '
                      '0.5.0-dev.1.',
                    ),
                  ),
                  Expanded(child: Container()),
                ]),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push<Widget>(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                              StaggeredGridExample1(
                            spaceAbove: rndSpaceAbove,
                            spaceBelow: rndSpaceBelow,
                            colors: randomColors,
                            columnDiv: columnDiv,
                          ),
                        ),
                      );
                    },
                    child: const Text('Staggered grid demo'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: <Widget>[
                  Expanded(child: Container()),
                  const Expanded(
                    flex: 10,
                    child: Text(
                      'We can also use the Staggered Grid View in a Sliver!',
                    ),
                  ),
                  Expanded(child: Container()),
                ]),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push<Widget>(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                              StaggeredGridExample3(
                            spaceAbove: rndSpaceAbove,
                            spaceBelow: rndSpaceBelow,
                            colors: randomColors,
                            columnDiv: columnDiv,
                          ),
                        ),
                      );
                    },
                    child: const Text('Staggered grid sliver demo'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
