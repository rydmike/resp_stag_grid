/// App static functions and constants used in the example applications.
///
/// In a real app you probably prefer putting these into different static
/// classes that serves your application's usage. For these examples I
/// put them all in the same class, except the colors that are in their
/// own class.
class AppData {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppData._();

  // Info about the app.
  // When I build new public web versions of the demos, I just make sure to
  // update this info before I trigger GitHub actions CI/CD that builds them.
  static const String appName = 'Responsive\u{00AD}GridDemo';
  static const String version = '2.1.0';
  static const String packageVersion = 'StaggeredGridView package 0.5.0-dev-1';
  static const String packageUrl =
      'https://pub.dev/packages/flutter_staggered_grid_view';
  static const String flutterVersion = 'stable v2.8.0';
  static const String copyright = '© 2019 2020, 2021';
  static const String author = 'Mike Rydstrom';
  static const String license = 'BSD 3-Clause License';
  static const String icon = 'assets/images/app_icon.png';
}
