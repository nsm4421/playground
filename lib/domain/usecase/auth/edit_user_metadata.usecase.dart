import '../../../core/enums/response_status.enum.dart';
import '../../../core/response/error_response.dart';
import '../../../core/response/result.dart';
import '../../model/auth/user_metadata.model.dart';
import '../../repository/auth/auth.repository.dart';
import '../base/remote.usecase.dart';

class EditUserMetaDataUseCase extends RemoteUseCase<AuthRepository> {
  final UserMetaDataModel metaData;

  EditUserMetaDataUseCase(this.metaData);

  @override
  Future call(AuthRepository repository) async {
    final res = await repository.updateMetaData(metaData.modelToDto());
    switch (res.status) {
      case ResponseStatus.success:
        return const Result<void>.success(null);
      default:
        return Result<void>.failure(ErrorResponse.fromResponseWrapper(res));
    }
  }
}
