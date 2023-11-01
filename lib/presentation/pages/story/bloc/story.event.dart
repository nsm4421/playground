abstract class StoryEvent {
  const StoryEvent();
}

class StoryInitializedEvent extends StoryEvent {}

class SwipeStoryEvent extends StoryEvent {}
