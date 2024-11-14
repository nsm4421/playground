part of 'index.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReelsListFragment([
      ReelsEntity(
          author: PresenceEntity(
              id: 'test1',
              username: 'test1',
              avatarUrl:
                  'http://172.30.1.61:54321/storage/v1/object/public/avatars/d5c51be0-c00e-4819-85f2-6eedb00dfab3.jpg'),
          video: 'test1',
          caption:
              'ufferpool2 0x7a2f1cc220 : 4(6266880 size) total buffers - 4(6266880 size) used buffers - 0/4 (recycle/alloc) - 4/339 (fe'),
      ReelsEntity(
        author: PresenceEntity(
            id: 'test2',
            username: 'test2',
            avatarUrl:
                'http://172.30.1.61:54321/storage/v1/object/public/avatars/d5c51be0-c00e-4819-85f2-6eedb00dfab3.jpg'),
        video: 'test2',
      ),
      ReelsEntity(
        author: PresenceEntity(
            id: 'test3',
            username: 'test3',
            avatarUrl:
                'http://127.0.0.1:54321/storage/v1/object/public/avatars/d5c51be0-c00e-4819-85f2-6eedb00dfab3.jpg'),
        video: 'test3',
      )
    ]);
  }
}
