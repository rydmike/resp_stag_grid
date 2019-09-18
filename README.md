# resp_stag_grid

Short example of how to use breakpoints to layout a grid in Flutter WEB and Desktop using Flutter's standard GridView and Romain Rastel's StaggeredGridView.

## Demonstrated features

Demo of responsive grid layout based on breakpoints and dynamic column numbers and widths

This example is designed for Flutter Desktop or WEB where you have larger surface and can resize the window. It will run OK on phones and tablets as well, but the demo is less interesting on them.

To test different sized columns, choose a value below to divide the total columns with. The total columns refer to amount of columns that are available for the breakpoint at current layout width.

- The Flutter Standard Grid works as expected. As known the standard grid is a square and cannot size its height to fit the content. You can see the challenge with this in this example if you make the columns too small by selecting 1 or 2 in the select control. The selected value will divide the totally available columns in the breakpoint, for the avtive window width.

- The staggered grid can adjust its height and make a masonry style layout automatically. There does however seem to be a potential **issue** that makes the StaggeredGridView **sometimes drop items** in the grid when you resize the window and sometimes it **does not rebuild correctly** when resizing the window size, especially if changing only the width. The issue has been observed in both the WEB and Desktop build (Win10), using Flutter Channel master, v1.10.3-pre.67. I might also not be using the StaggeredGridView correctly, let me know if you have any thoughts on how to fix it.

- As a "side effect" this demo also show how to setup Flutter WEB and Desktop in the same project when/if you need 'dart.io' in Flutter Desktop, but it does not compile in Flutter WEB. This is the case at least in Flutter master, v1.10.3-pre.67. This example uses a conditional Dart lib import to accomplish this.

- Usage of the in Dart 1.9 new ToggleButtons widget is also demonstrated as a control for selecting the divisor of the total amount columns for the given breakpoint width. This is used to demonstrate how to make wider columns for the grid views in a standard 12 column grid layout.


## Preview

Start screen, select column divisor and try the responsive grid layout with a standard grid or the masonry style StaggeredGridView layout.
![](RespGridDemo1.png) 

Example of dynamic staggered grid layout
![](RespGridDemo2.png)

Animated GIF that also shows the potential issue with the staggered grid layout.
![](resp_grid_demo2.gif)

