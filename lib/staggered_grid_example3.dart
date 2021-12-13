import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'breakpoint.dart';

class StaggeredGridExample3 extends StatelessWidget {
  const StaggeredGridExample3({
    Key? key,
    required this.spaceAbove,
    required this.spaceBelow,
    required this.colors,
    required this.columnDiv,
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
          body: Padding(
            padding: EdgeInsets.only(
                left: breakpoint.gutters, right: breakpoint.gutters),
            child: CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Sliver Staggered Grid',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Text(
                      'Texts and header in own SliverList so that we can '
                      'display them here too above the scrolling grid.'),
                  Text(
                    'Used columns: '
                    '${Breakpoint.useColumns(breakpoint.columns, columnDiv)}',
                  ),
                  Text('Layout width:$width '),
                  Text('Breakpoint columns: ${breakpoint.toString()}'),
                  const SizedBox(height: 20),
                ]),
              ),
              SliverMasonryGrid.count(
                crossAxisCount:
                    Breakpoint.useColumns(breakpoint.columns, columnDiv),
                crossAxisSpacing: breakpoint.gutters,
                mainAxisSpacing: breakpoint.gutters,
                childCount: spaceAbove.length,
                itemBuilder: (_, int index) {
                  return Card(
                    color: colors[index].shade100,
                    elevation: 5,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Panel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center),
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
                              'There are '
                              '${spaceAbove[index].toStringAsFixed(0)} '
                              'random pixels of space above this text.\n'
                              'We cannot resize the height to fit the content '
                              'in a standard grid.\n'
                              'There are '
                              '${spaceBelow[index].toStringAsFixed(0)} '
                              'random pixels of space '
                              'below this text.',
                            ),
                          ),
                          SizedBox(height: spaceBelow[index]),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Text(
                              'This Staggered Grid is used in a Sliver!',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}
