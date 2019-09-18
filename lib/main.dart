import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'breakpoint.dart';
import 'conditionals/conditional_import.dart';

/// Demo of how to use breakpoints and varying column size with Flutter standard
/// Grid and by using Romain Rastel's Staggered Gridview package
/// https://pub.dev/packages/flutter_staggered_grid_view
///
/// There is potentially an issue when
///
/// This simple example is designed for Flutter Web and Desktop.
/// Accompanying GIF demo was made with Flutter master v1.10.3-pre.67 on a
/// Windows 10 desktop.
///
/// As a "side effect" this demo also show how to setup Flutter WEB and Desktop
/// in the same project when/if you need 'dart.io' in Flutter Desktop but
/// it does not compile in Flutter WEB. It uses a conditional Dart lib import.
///
///
/// Mike Rydstrom 18.9.2019 MIT License
///

const int kItemCount = 200;

void main() {
  // Set target platform for Desktop, while avoiding importing dart.io for WEB
  setTargetPlatformForDesktop();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Grid Demos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(), // MyHomePage(gridFontSize: gridFontSize),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final List<double> _fontSize = [];
  final random = Random();
  var isSelected = [false, true, false, false];
  int breakpointDivisor = 2;

  @override
  Widget build(BuildContext context) {
    // Make some random double numbers that we can use to size the
    // grid number fonts with
    for (int i = 0; i < kItemCount; i++) {
      _fontSize.add(12.0 + random.nextDouble() * 100);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Responsive Grid Demos')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Demo of responsive grid '
                  'layout based on breakpoints and changing column sizes',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Text(
                    'This example is designed for Flutter Desktop or WEB, where '
                    'you have larger surface and can resize the window. It will '
                    'run OK on phones and tablets as well, but the demo is less '
                    'interesting on them.',
                    style: TextStyle(fontSize: 12)),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Text(
                    'To test different sized columns, choose a value below to '
                    'divide the total columns with. The total columns refer to '
                    'the number of columns that are available for the '
                    'current layout width'
                    's breakpoint.',
                    style: TextStyle(fontSize: 12)),
              ),
              SizedBox(height: 8),
              ToggleButtons(
                children: [
                  for (int i = 1; i <= 4; i++)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(27, 10, 27, 10),
                        child: Text("$i")),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      if (i == index) {
                        isSelected[i] = true;
                        breakpointDivisor = index + 1;
                      } else {
                        isSelected[i] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Text(
                    'As known the standard grid is a square and cannot size its '
                    'height to fit the content. You can see the challange with this '
                    'in this example if you make the columns too small by '
                    'selecting 1 or 2 above.',
                    style: TextStyle(fontSize: 12)),
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NormalGridExample(
                          itemFontSize: _fontSize,
                          columnDivisor: breakpointDivisor,
                        ),
                      ),
                    );
                  },
                  child: Text('Normal grid demo'),
                  color: Colors.blue[100],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Text(
                    'The staggered grid can fit the height and make a masonary '
                    'style layout automatically. There does however seem to be '
                    'an issue that makes it sometimes drop '
                    'items from the grid when you resize the window. '
                    'Sometimes it also does not rebuild correctly when resizing '
                    'the window size, especially if changing only the width.',
                    style: TextStyle(fontSize: 12)),
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaggeredGridExample(
                          itemFontSize: _fontSize,
                          columnDivisor: breakpointDivisor,
                        ),
                      ),
                    );
                  },
                  child: Text('Staggered grid demo'),
                  color: Colors.blue[100],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

int usedColumns(int availableColumns, int divisor) =>
    (availableColumns / divisor).floor() < 1
        ? 1
        : (availableColumns / divisor).floor();

class NormalGridExample extends StatelessWidget {
  final List<double> itemFontSize;
  final int columnDivisor;
  const NormalGridExample({Key key, this.itemFontSize, this.columnDivisor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final _breakpoint = Breakpoint.fromConstraints(constraints);
        final double _width = constraints.maxWidth.roundToDouble();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'C:${usedColumns(_breakpoint.columns, columnDivisor)} W:$_width   '
              'Breakpoint is:\nC:${_breakpoint.toString()}',
              style: TextStyle(fontSize: 12),
            ),
          ),
          body: GridView.builder(
            padding: EdgeInsets.all(_breakpoint.gutters),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: usedColumns(_breakpoint.columns, columnDivisor),
              crossAxisSpacing: _breakpoint.gutters,
              mainAxisSpacing: _breakpoint.gutters,
            ),
            shrinkWrap: true,
            itemCount: kItemCount,
            itemBuilder: (_, index) {
              return Card(
                color: Colors.blue[50],
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Widget",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: itemFontSize[index]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "We cannot resize height to fit content in a "
                          "standard grid.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class StaggeredGridExample extends StatelessWidget {
  final List<double> itemFontSize;
  final int columnDivisor;
  const StaggeredGridExample({Key key, this.itemFontSize, this.columnDivisor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final _breakpoint = Breakpoint.fromConstraints(constraints);
        final double _width = constraints.maxWidth.roundToDouble();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'C:${usedColumns(_breakpoint.columns, columnDivisor)} W:$_width   '
              'Breakpoint is:\nC:${_breakpoint.toString()}',
              style: TextStyle(fontSize: 12),
            ),
          ),
          body: StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(_breakpoint.gutters),
            crossAxisCount: usedColumns(_breakpoint.columns, columnDivisor),
            crossAxisSpacing: _breakpoint.gutters,
            mainAxisSpacing: _breakpoint.gutters,
            itemCount: kItemCount,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            //shrinkWrap: true,
            itemBuilder: (_, index) {
              return Card(
                color: Colors.blue[50],
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Widget",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: itemFontSize[index]),
                        ),
                      ),
                      SizedBox(height: itemFontSize[index] / 2),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "This staggered grid item has random dynamic "
                            "height and sizes itself "
                            "in a horizontal dynamic grid as well, creating "
                            "a masonary style layout automatically."),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
