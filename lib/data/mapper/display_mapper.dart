import '../../domain/model/menu_model.dart';
import '../../domain/model/product_info_model.dart';
import '../../domain/model/view_module_model.dart';
import '../dto/display/menu_dto.dart';
import '../dto/display/product_info_dto.dart';
import '../dto/display/view_module_dto.dart';

/// DTO → Entity

extension MenuDtoX on MenuDto {
  MenuModel toModel() => MenuModel(title: title ?? '', tabId: tabId ?? -1);
}

extension ViewModuleDtoX on ViewModuleDto {
  ViewModuleModel toModel() => ViewModuleModel(
        type: type ?? '',
        title: title ?? '',
        subtitle: subtitle ?? '',
        imageUrl: imageUrl ?? '',
        products: products.map((e) => e.toModel()).toList() ?? [],
        tabs: tabs ?? [],
      );
}

extension ProductInfoX on ProductInfoDto {
  ProductInfoModel toModel() => ProductInfoModel(
        productId: productId ?? '',
        name: name ?? '',
        imageUrl: imageUrl ?? '',
        description: description ?? '',
        price: price ?? -1,
        originalPrice: originalPrice ?? -1,
        discountRate: discountRate ?? 0.0,
        reviewCount: reviewCount ?? -1,
      );
}
