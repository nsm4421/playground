part of "travel.page.dart";

class TravelScreen extends StatelessWidget {
  const TravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel"),
        actions: [IconButton(onPressed: (){
          context.push(RoutePaths.recommendItinerary.path);
        }, icon: Icon(Icons.arrow_right))],
      ),
    );
  }
}
