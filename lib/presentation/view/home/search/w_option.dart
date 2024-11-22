part of 'index.dart';

class NavigateToOptionWidget extends StatelessWidget {
  const NavigateToOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFeedBloc,
        CustomSearchState<FeedEntity, SearchFeedOption>>(
      builder: (context, state) {
        return TextField(
          readOnly: true,
          // 버튼을 누르는 경우 검색옵션을 선택할 수 있는 페이지로 이동
          onTap: () async {
            context.read<HomeBottomNavCubit>().switchVisible(false);
            await showModalBottomSheet<SearchFeedOption?>(
                context: context,
                builder: (context) {
                  return SearchOptionWidget(state.option);
                }).then((res) {
              if (res == null ||
                  res == context.read<SearchFeedBloc>().state.option) {
                return;
              } else {
                // 검색 옵션이 변경된 경우, refetch
                context.read<SearchFeedBloc>()
                  ..add(SearchOptionEditedEvent(res))
                  ..add(FetchEvent(refresh: true));
              }
            }).whenComplete(
              () {
                context.read<HomeBottomNavCubit>().switchVisible(true);
              },
            );
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            helper: state.option == null
                ? null
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.subdirectory_arrow_right, size: 25),
                      Text('${state.option!.searchField.label} : ',
                          style: context.textTheme.labelLarge),
                      (12.0).w,
                      Text(
                        state.option!.searchText,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(color: context.colorScheme.primary),
                      ),
                    ],
                  ),
            prefixIcon: Icon(
              Icons.search,
              color: context.colorScheme.primary,
            ),
            suffixIcon: state.option?.searchField == null
                ? null
                : switch (state.status) {
                    Status.loading => Transform.scale(
                        scale: 0.5, child: const CircularProgressIndicator()),
                    Status.error => const Icon(Icons.error_outline),
                    (_) => IconButton(
                        onPressed: () {
                          context.read<SearchFeedBloc>()
                            // 검색옵션 초기화
                            ..add(ClearSearchOptionEvent<FeedEntity,
                                SearchFeedOption>())
                            // 게시글 검색
                            ..add(FetchEvent(refresh: true));
                        },
                        icon: Icon(
                          Icons.clear,
                          color: context.colorScheme.primary,
                        ),
                      ),
                  },
            hintText: 'Search',
          ),
        );
      },
    );
  }
}

class SearchOptionWidget extends StatefulWidget {
  const SearchOptionWidget(this.option, {super.key});

  final SearchFeedOption? option;

  @override
  State<SearchOptionWidget> createState() => _SearchOptionWidgetState();
}

class _SearchOptionWidgetState extends State<SearchOptionWidget> {
  late TextEditingController _controller;
  late SearchFeedOption _option;
  late GlobalKey<FormState> _formKey;
  static const int _maxLength = 20;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _option = SearchFeedOption(
        searchField:
            widget.option?.searchField ?? FeedSearchFields.values.first,
        searchText: widget.option?.searchText ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleSearchText(String text) {
    setState(() {
      _option = _option.copyWith(searchText: text);
    });
  }

  _handleSearchType(FeedSearchFields tapped) => () {
        setState(() {
          _option = _option.copyWith(searchField: tapped);
        });
      };

  String? _handleValidate(String? text) {
    if (text == null || text.isEmpty) {
      return 'search text is not given';
    }
    return null;
  }

  _handleSubmit() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) return;
    context.pop<SearchFeedOption?>(_option);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              'Search',
              style: context.textTheme.titleSmall,
            ),
          ),
          Wrap(
            children: FeedSearchFields.values
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: _handleSearchType(item),
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: item == _option.searchField
                            ? context.colorScheme.primaryContainer
                            : null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        item.name,
                        style: context.textTheme.labelLarge?.copyWith(
                            color: item == _option.searchField
                                ? context.colorScheme.onPrimary
                                : null),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: _handleValidate,
                maxLength: _maxLength,
                controller: _controller,
                onChanged: _handleSearchText,
                decoration: InputDecoration(
                  label: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Keyword  ',
                          style: context.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: '(${_option.searchText.length}/$_maxLength)',
                          style: context.textTheme.labelLarge,
                        )
                      ],
                    ),
                  ),
                  counterText: '',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: context.colorScheme.primary,
                    ),
                    onPressed: _handleSubmit,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
