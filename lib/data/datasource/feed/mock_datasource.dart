part of 'datsource.dart';

class MockFeedDataSource implements FeedDataSource {
  @override
  Future<void> deleteById(String id) async {
    return;
  }

  @override
  Future<void> edit(EditFeedModel model, {bool update = false}) async {
    return;
  }

  @override
  Future<Iterable<FetchFeedModel>> fetch(String beforeAt,
      {int take = 20}) async {
    return List.generate(take, (index) {
      return FetchFeedModel(
        id: 'mock_diary_$index',
        images: [
          'https://picsum.photos/200/300',
          'https://picsum.photos/200/300',
          'https://picsum.photos/200/300'
        ],
        created_by: 'mock_user_uid',
        username: 'mock_user_usernmae',
        avatar_url: 'https://picsum.photos/200/300',
        captions: ['test1', 'test2', 'test3'],
        created_at: DateTime.now().toUtc().toIso8601String(),
      );
    });
  }
}
