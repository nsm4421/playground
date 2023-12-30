import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/home/search/bloc/search.event.dart';
import 'package:my_app/screen/home/search/search_header.widget.dart';
import 'package:my_app/screen/home/search/search_list.widget.dart';

import '../../../configurations.dart';
import 'bloc/search.bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<SearchBloc>()..add(InitSearchEvent()),
        child: const Scaffold(
          body: Column(
            children: [SearchHeaderWidget(), Divider(), SearchListWidget()],
          ),
        ),
      );
}
