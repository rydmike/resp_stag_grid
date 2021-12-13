import 'package:flutter/material.dart';

import 'breakpoint.dart';

class StandardGridExample extends StatelessWidget {
  const StandardGridExample({
    Key? key,
    required this.spaceAbove,
    required this.spaceBelow,
    required this.columnDiv,
    required this.colors,
  }) : super(key: key);
  final List<double> spaceAbove;
  final List<double> spaceBelow;
  final List<MaterialColor> colors;
  final int columnDiv;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Breakpoint breakpoint = Breakpoint.fromConstraints(
          constraints,
          type: BreakType.large,
        );
        final double width = constraints.maxWidth.roundToDouble();

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'C:${Breakpoint.useColumns(breakpoint.columns, columnDiv)} '
              'W:$width  Breakpoint is:\nC:${breakpoint.toString()}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          body: GridView.builder(
            padding: EdgeInsets.all(breakpoint.gutters),
            itemCount: spaceAbove.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  Breakpoint.useColumns(breakpoint.columns, columnDiv),
              crossAxisSpacing: breakpoint.gutters,
              mainAxisSpacing: breakpoint.gutters,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: colors[index].shade100,
                elevation: 2,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Panel',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      SizedBox(height: spaceAbove[index]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(
                          'There are ${spaceAbove[index].toStringAsFixed(0)} '
                          'random pixels of space above this text.\n'
                          'We cannot resize the height to fit the content '
                          'in a standard grid.\n'
                          'There are ${spaceBelow[index].toStringAsFixed(0)} '
                          'random pixels of space '
                          'below this text.',
                        ),
                      ),
                      SizedBox(height: spaceBelow[index]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                        child: Text(
                          'This text is at the last widget in this grid item.\n'
                          'Would look be nice if the grid tile could size '
                          'its height to fit.',
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
