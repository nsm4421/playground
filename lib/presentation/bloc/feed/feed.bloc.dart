import 'package:injectable/injectable.dart';
import 'package:my_app/domain/usecase/module/feed/feed.usecase.dart';
import 'package:my_app/presentation/bloc/feed/upload/upload_feed.cubit.dart';

import 'display/display_feed.bloc.dart';

@lazySingleton
class FeedBloc {
  final FeedUseCase _useCase;

  FeedBloc(this._useCase);

  @lazySingleton
  UploadFeedCubit get upload => UploadFeedCubit(_useCase);

  @lazySingleton
  DisplayFeedBloc get display => DisplayFeedBloc(_useCase);
}
