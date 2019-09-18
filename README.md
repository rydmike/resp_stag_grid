# resp_stag_grid

Short example of how to use brekpoints to layout a grid in Flutter WEB and Desktop using Flutter's standard GridView and Romain Rastel's StaggeredGridView.

## Preview
![](resp_grid_demo2.gif)

## Demonstrated features

Demo of responsive grid layout based on breakpoints and changing column sizes.

This example is designed for Flutter Desktop or WEB where you have larger surface and can resize the window. It will run OK on phones and tablets as well, but the demo is less interesting on them.

To test different sized columns, choose a value below to divide the total columns with. The total columns refer to amount of columns that are available for the breakpoint at current layout width.

- The Flutter Standard Grid works as expected. As known the standard grid is a square and cannot size height to fit content. You can see the challange with this in this example, if you make the columns too small by selecting 1 or 2 to divide the available columns with in the breakpoint columns for the avtive window width.


- The staggered grid can fit the height and make a masonary style layout automatically. There does however seem to be an **issue** that makes the StaggeredGridView **sometimes drop items** in the grid when you resize the window and sometimes it **does not rebuild corectly** when resizing the window size, especially if changing only the width.
