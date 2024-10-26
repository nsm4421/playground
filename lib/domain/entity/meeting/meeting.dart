import 'dart:developer';

import 'package:travel/data/model/meeting/fetch_meetings.dart';
import 'package:travel/domain/entity/auth/presence.dart';

import '../../../core/constant/constant.dart';

class MeetingEntity extends BaseEntity {
  // 여행 장소
  final String? country;
  final String? city;

  // 여행 일정
  final DateTime? startDate;
  final DateTime? endDate;

  // 같이 여행할 사람
  final int? headCount;
  final AccompanySexType? sex;
  final TravelThemeType? theme;

  // 여행 경비
  final int? minCost;
  final int? maxCost;

  // 게시글
  final String? title;
  final String? content;
  late final List<String> hashtags;
  final String? thumbnail;

  // 글쓴이
  final PresenceEntity? author;

  MeetingEntity(
      {this.country,
      this.city,
      this.startDate,
      this.endDate,
      this.headCount,
      this.sex,
      this.theme,
      this.minCost,
      this.maxCost,
      this.title,
      this.content,
      List<String>? hashtags,
      this.thumbnail,
      this.author,
      // meta data
      super.id,
      super.createdAt,
      super.updatedAt,
      super.createdBy}) {
    this.hashtags = hashtags ?? [];
  }

  factory MeetingEntity.from(FetchMeetingsModel model) => MeetingEntity(
      country: model.country.isNotEmpty ? model.country : null,
      city: model.city,
      startDate: DateTime.tryParse(model.start_date),
      endDate: DateTime.tryParse(model.end_date),
      headCount: model.head_count,
      sex: model.sex,
      theme: model.theme,
      minCost: model.min_cost,
      maxCost: model.max_cost,
      title: model.title.isNotEmpty ? model.title : null,
      content: model.content.isNotEmpty ? model.content : null,
      hashtags: model.hashtags,
      thumbnail: model.thumbnail,
      // meta data
      id: model.id.isNotEmpty ? model.id : null,
      createdAt: DateTime.tryParse(model.created_at),
      updatedAt: DateTime.tryParse(model.updated_at),
      author: model.author_uid.isNotEmpty
          ? PresenceEntity(
              uid: model.author_uid,
              username: model.author_username,
              avatarUrl: model.author_avatar_url)
          : null,
      createdBy: model.author_uid.isNotEmpty ? model.author_uid : null);

  String? get dateRangeRepr {
    try {
      return '${startDate!.month}.${startDate!.day}~${endDate!.month}.${endDate!.day}';
    } catch (error) {
      log('formatting date fails:${error.toString()}');
      return null;
    }
  }

  int? get durationInDay {
    try {
      return endDate!.difference(startDate!).inDays;
    } catch (error) {
      log('getting duration date fails:${error.toString()}');
      return null;
    }
  }
}
