import '../../domain/model/menu_model.dart';
import '../../domain/model/view_module_model.dart';
import '../dto/display/menu_dto.dart';
import '../dto/display/view_module.dart';

/// DTO → Entity

extension MenuX on MenuDto {
  MenuModel toModel() => MenuModel(title: title ?? '', tabId: tabId ?? -1);
}

extension ViewModuleX on ViewModuleDto {
  ViewModuleModel toModel() => ViewModuleModel(
        type: type ?? '',
        title: title ?? '',
        subtitle: subtitle ?? '',
        imageUrl: imageUrl ?? '',
      );
}
