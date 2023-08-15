import 'package:flutter/foundation.dart';

enum Typing { start, stop }

extension TypingParser on Typing {
  String value() {
    return toString().split(".").last;
  }

  static Typing fromString(String event) {
    return Typing.values.firstWhere((element) => element.value() == event);
  }
}

class TypingEvent {
  String get id => _id;
  String _id;
  final String from;
  final String to;
  final Typing event;

  TypingEvent({@required this.from, @required this.to, @required this.event});

  // class → json
  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'event': event,
      };

  // json → class
  factory TypingEvent.fromJson(Map<String, dynamic> json) {
    final event = TypingEvent(
      from: json['from'],
      to: json['to'],
      event: json['event'],
    );
    event._id = json['id'];
    return event;
  }
}
