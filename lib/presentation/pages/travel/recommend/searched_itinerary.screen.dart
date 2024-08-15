part of "recommend_itinerary.page.dart";

class SearchedItineraryScreen extends StatelessWidget {
  const SearchedItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searched = context.read<RecommendItineraryCubit>().state.searched;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<RecommendItineraryCubit>().state.country),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: context
                    .read<RecommendItineraryCubit>()
                    .state
                    .searched
                    .length,
                itemBuilder: (context, index) {
                  final item = context
                      .read<RecommendItineraryCubit>()
                      .state
                      .searched[index];
                  return ListTile(
                    leading: item.imageUrl != null
                        ? CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: item.imageUrl!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Text((searched[index].placeName ?? "?")[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : null,
                    title: Text(
                      searched[index].placeName ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      searched[index].detail ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
