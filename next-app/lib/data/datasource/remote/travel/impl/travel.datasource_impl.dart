import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/travel_constant.dart';
import '../../../../model/travel/itinerary.model.dart';
import '../../../../model/travel/recommendation_response.model.dart';

part "../abstract/travel.datasource.dart";

class TravelDataSourceImpl implements TravelDataSource {
  late ChatSession _chat;
  final GenerativeModel _aiModel;
  final SupabaseClient _client;
  final Logger _logger;

  TravelDataSourceImpl(
      {required GenerativeModel aiModel,
      required SupabaseClient client,
      required Logger logger})
      : _aiModel = aiModel,
        _client = client,
        _logger = logger {
    _chat = _aiModel.startChat(
        history: [],
        generationConfig: GenerationConfig(
          temperature: 1,
          topP: 0.95,
          topK: 64,
          maxOutputTokens: 8192,
          responseMimeType: "application/json",
        ));
  }

  @override
  Future<Iterable<ItineraryModel>> recommendTrip({
    required String country,
    required AccompanyType accompanyType,
    required TendencyType tendencyType,
  }) async {
    final message = "generate 10 recommendations for visiting $country. "
        "looking for ${tendencyType.prompt} and travel ${accompanyType.prompt}. "
        "each destination contain longitude, latitude, place_name, image_url, detail. "
        "answer me with json format. "
        "each fields type is string. ";
    _logger.d(message);
    return await _chat
        .sendMessage(Content.text(message))
        .then((res) => res.text!)
        .then((text) => json.decode(text) as List<dynamic>)
        .then((iterable) => iterable.map(
            (item) => ItineraryModel.fromJson(item as Map<String, dynamic>)));
  }
}
