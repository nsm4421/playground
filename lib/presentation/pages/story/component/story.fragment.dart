import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/pages/story/bloc/story.event.dart';
import 'package:my_app/presentation/pages/story/component/story.widget.dart';

import '../../../../domain/model/story/story.model.dart';
import '../bloc/story.bloc.dart';

class StoryFragment extends StatefulWidget {
  const StoryFragment(this.stories, {super.key});

  final List<StoryModel> stories;

  @override
  State<StoryFragment> createState() => _StoryFragmentState();
}

class _StoryFragmentState extends State<StoryFragment> {
  static const double _threshold = 1 / 3;

  _handleDragging(DraggableDetails drag) {
    if (drag.offset.dy.abs() >
        MediaQuery.of(context).size.height * _threshold) {
      context.read<StoryBloc>().add(SwipeStoryEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final storyWidget = StoryViewWidget(widget.stories[0]);
    return Draggable<StoryModel>(
      axis: Axis.vertical,
      data: widget.stories[0],
      feedback: storyWidget,
      childWhenDragging: widget.stories.length > 1
          ? StoryViewWidget(widget.stories[1])
          : Container(),
      onDragEnd: _handleDragging,
      child: storyWidget,
    );
  }
}
