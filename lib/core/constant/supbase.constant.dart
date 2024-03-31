enum Tables {
  user('accounts'),
  feed('feeds');

  final String name;

  const Tables(this.name);
}

enum Buckets {
  feed("feed");

  final String name;

  const Buckets(this.name);
}
