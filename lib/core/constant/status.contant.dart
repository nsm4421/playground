part of 'constant.dart';

enum Status {
  initial(true),
  success(true),
  loading(false),
  error(false);

  final bool ok;

  const Status(this.ok);
}
