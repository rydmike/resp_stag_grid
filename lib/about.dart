import 'package:flutter/material.dart';

import 'app_data.dart';
import 'link_text_span.dart';

// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      onPressed: () {
        showAppAboutDialog(context);
      },
    );
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.bodyText1!;
  final TextStyle footerStyle = themeData.textTheme.caption!;
  final TextStyle linkStyle =
      themeData.textTheme.bodyText1!.copyWith(color: themeData.primaryColor);

  showAboutDialog(
    context: context,
    applicationName: AppData.appName,
    applicationVersion: AppData.version,
    applicationIcon: const Image(image: AssetImage(AppData.icon)),
    applicationLegalese:
        '${AppData.copyright}\n${AppData.author}\n${AppData.license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'This example shows some features of the '
                    'StaggeredGridView package. To learn '
                    'more, check out the package on ',
              ),
              LinkTextSpan(
                style: linkStyle,
                url: AppData.packageUrl,
                text: 'pub.dev',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.\n',
              ),
              TextSpan(
                style: footerStyle,
                text: 'Built with Flutter ${AppData.flutterVersion}, '
                    'using ${AppData.packageVersion}\n\n',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
