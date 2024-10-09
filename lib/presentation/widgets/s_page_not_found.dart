part of 'widgets.dart';

class PageNotFoundedScreen extends StatelessWidget {
  const PageNotFoundedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text('Page Not Found',
                style: Theme.of(context).textTheme.displaySmall)));
  }
}
