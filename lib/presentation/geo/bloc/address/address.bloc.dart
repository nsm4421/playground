import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/domain/usecase/geo/geo.usecase.dart';
import 'package:hot_place/presentation/geo/bloc/address/address.event.dart';
import 'package:hot_place/presentation/geo/bloc/address/address.state.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/entity/geo/load_address/load_address.entity.dart';

@injectable
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GeoUseCase _useCase;

  AddressBloc({required GeoUseCase useCase})
      : _useCase = useCase,
        super(InitialAddressState()) {
    on<InitAddressEvent>(_onInit);
  }

  void _onInit(InitAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    // 위치 권한 허용 여부
    final isPermitted = await _useCase.getPermission();
    if (!isPermitted) {
      emit(const AddressFailureState('위치권한이 허용되지 않았습니다'));
      return;
    }

    // 현재 위치 가져오기
    final pos = (await _useCase.getPosition()).fold((l) => null, (r) => r);
    if (pos == null) {
      emit(const AddressFailureState('현재 위치를 가져올 수 없습니다'));
      return;
    }

    // 현재 주소 가져오기
    await _useCase.getAddress(pos).then((res) => res.fold(
        (l) => emit(LocationFetchedState(position: pos, address: null)),
        (r) => emit(AddressFetchedState(position: pos, address: r.first))));
  }
}
