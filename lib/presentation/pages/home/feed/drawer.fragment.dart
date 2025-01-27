part of '../../export.pages.dart';

class DisplayFeedDrawerFragment extends StatelessWidget {
  const DisplayFeedDrawerFragment(this._scaffoldKey, {super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Feeds",
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.tertiaryContainer),
                  onPressed: () {
                    _scaffoldKey.currentState?.closeEndDrawer();
                    context.push(Routes.createFeed.path);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_outlined,
                          color: context.colorScheme.onTertiaryContainer),
                      12.width,
                      Text(
                        "Create Feed",
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.colorScheme.onTertiaryContainer),
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
