import '../dto/display/menu_dto.dart';
import '../../domain/entity/menu_entity.dart';

/// Menu DTO → Menu Entity
extension MenuX on MenuDto {
  MenuEntity toEntity() => MenuEntity(title: title ?? '', tabId: tabId ?? -1);
}
