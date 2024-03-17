import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/usecase/map/search_address.usecase.dart';

import '../../../domain/entity/map/address/address.entity.dart';

class SearchAddressWidget extends StatefulWidget {
  const SearchAddressWidget({super.key});

  @override
  State<SearchAddressWidget> createState() => _SearchAddressWidgetState();
}

class _SearchAddressWidgetState extends State<SearchAddressWidget> {
  late TextEditingController _controller;
  bool _isLoading = false;
  String? _keyword;
  String? _errorText;
  List<AddressEntity> _addresses = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _pop() => context.pop();

  _hideKeyboard() => FocusScope.of(context).unfocus();

  _search() async {
    try {
      (await getIt<SearchAddressUseCase>()(_controller.text)).when(
          success: (data) {
        setState(() {
          _addresses = data.data;
          _keyword = _controller.text;
          _errorText = null;
        });
        _hideKeyboard();
        _controller.clear();
      }, failure: (_, __) {
        setState(() {
          _errorText = "검색에 실패하였습니다";
        });
      });
    } catch (err) {
      setState(() {
        _errorText = "알수 없는 에러가 발생했습니다";
      });
      debugPrint(err.toString());
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const Center(child: CircularProgressIndicator())
      : GestureDetector(
          onTap: _hideKeyboard,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: _pop, icon: const Icon(Icons.clear)),
                      const SizedBox(width: 10),
                      Text(
                        "장소 검색하기",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextField(
                      controller: _controller,
                      maxLines: 1,
                      maxLength: 30,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          decorationThickness: 0,
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                          helperText: _errorText,
                          hintText: '예) 상도동',
                          suffix: !_isLoading
                              ? IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: _search)
                              : null)),
                  const SizedBox(height: 30),
                  Text(
                    _keyword == null ? "검색어를 입력해주세요" : "검색어 : $_keyword",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  const SizedBox(height: 10),
                  if (_addresses.isNotEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.separated(
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(_addresses[index].addressName ?? ''),
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: _addresses.length),
                    )
                ],
              ),
            ),
          ),
        );
}
