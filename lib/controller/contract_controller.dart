import 'package:chat_app/repository/contract_repoistory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contractControllerProvider = FutureProvider((ref) {
  final contractRepository = ref.watch(contractRepositoryProvider);
  return contractRepository.getAllContracts();
});
