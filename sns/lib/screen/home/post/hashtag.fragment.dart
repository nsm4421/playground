import 'package:flutter/material.dart';

class HashtagFragment extends StatefulWidget {
  const HashtagFragment(
      {super.key,
      required this.hashtagTecList,
      required this.setHashtagTecList});

  final List<TextEditingController> hashtagTecList;
  final void Function(List<TextEditingController>) setHashtagTecList;

  @override
  State<HashtagFragment> createState() => _HashtagFragmentState();
}

class _HashtagFragmentState extends State<HashtagFragment> {
  static const int _maxHashtag = 3;

  _handleAddHashtag() => widget
      .setHashtagTecList([...widget.hashtagTecList, TextEditingController()]);

  _handleDeleteHashtag(int index) => () {
        List<TextEditingController> hashtagTecList = [...widget.hashtagTecList];
        hashtagTecList.removeAt(index);
        widget.setHashtagTecList(hashtagTecList);
      };

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Text("Hashtags",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary)),
                const Spacer(),
                if (widget.hashtagTecList.length < _maxHashtag)
                  IconButton(
                      tooltip: 'Add',
                      onPressed: _handleAddHashtag,
                      icon: const Icon(Icons.add))
              ],
            ),
            const SizedBox(height: 20),
            ...List.generate(
                widget.hashtagTecList.length,
                (index) => Column(
                      children: [
                        TextFormField(
                          controller: widget.hashtagTecList[index],
                          minLines: 1,
                          maxLines: 20,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.tag),
                              suffixIcon: IconButton(
                                  onPressed: _handleDeleteHashtag(index),
                                  icon: const Icon(Icons.delete)),
                              border: const OutlineInputBorder()),
                          maxLength: 15,
                        ),
                        const SizedBox(height: 20)
                      ],
                    ))
          ],
        ),
      );
}
