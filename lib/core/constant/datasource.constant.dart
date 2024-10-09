part of 'constant.dart';

enum Tables {
  accounts,
  diaries;
}

enum Buckets {
  avatar,
  diary;
}

enum Boxes {
  credential;
}

enum RpcFns {
  fetchDiaries('fetch_diaries');

  final String name;

  const RpcFns(this.name);
}
