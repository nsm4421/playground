abstract interface class BaseDataSource<T> {
  String get tableName;

  T audit(T model);
}
