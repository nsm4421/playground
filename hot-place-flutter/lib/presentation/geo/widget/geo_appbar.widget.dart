import 'package:flutter/material.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';

class GeoAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const GeoAppBarWidget(this.address, {super.key});

  final LoadAddressEntity? address;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 1,
      centerTitle: true,
      title: address?.addressName == null
          ? const SizedBox()
          : Text(
              address!.addressName!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
