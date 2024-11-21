import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';

part 's_search.dart';

part 'f_searched.dart';

part 'w_option.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchScreen();
  }
}
