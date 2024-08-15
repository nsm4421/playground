part of "recommend_travel.cubit.dart";

class RecommendItineraryState extends TravelState {
  final String country;
  final AccompanyType accompany;
  final TendencyType tendency;
  final List<ItineraryEntity> searched;

  RecommendItineraryState(
      {super.status,
      super.message,
      required this.country,
      required this.accompany,
      required this.tendency,
      required this.searched});

  @override
  RecommendItineraryState copyWith({
    Status? status,
    String? message,
    String? country,
    AccompanyType? accompany,
    TendencyType? tendency,
    List<ItineraryEntity>? searched,
  }) {
    return RecommendItineraryState(
      status: status ?? this.status,
      message: message ?? this.message,
      country: country ?? this.country,
      accompany: accompany ?? this.accompany,
      tendency: tendency ?? this.tendency,
      searched: searched ?? this.searched,
    );
  }
}
