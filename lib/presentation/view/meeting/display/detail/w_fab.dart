part of 'page.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          RoundIconButtonWidget(
              iconData: Icons.group_add,
              iconSize: 30,
              tooltip: 'JOIN',
              voidCallback: () async {
                // TODO : JOIN 기능
              })
        ]));
  }
}
