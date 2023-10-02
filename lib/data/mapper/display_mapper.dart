import '../../domain/model/menu_model.dart';
import '../dto/display/menu_dto.dart';

/// Menu DTO → Menu Entity
extension MenuX on MenuDto {
  MenuModel toModel() => MenuModel(title: title ?? '', tabId: tabId ?? -1);
}
