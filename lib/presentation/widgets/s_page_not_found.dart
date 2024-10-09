part of 'widgets.dart';

class PageNotFounded extends StatelessWidget {
  const PageNotFounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text('Page Not Found',
                style: Theme.of(context).textTheme.displaySmall)));
  }
}
