import 'dart:convert';

class MovieSuggestionModel {
    int page;
    List<dynamic> results;
    int totalPages;
    int totalResults;

    MovieSuggestionModel({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    MovieSuggestionModel copyWith({
        int? page,
        List<dynamic>? results,
        int? totalPages,
        int? totalResults,
    }) => 
        MovieSuggestionModel(
            page: page ?? this.page,
            results: results ?? this.results,
            totalPages: totalPages ?? this.totalPages,
            totalResults: totalResults ?? this.totalResults,
        );

    factory MovieSuggestionModel.fromRawJson(String str) => MovieSuggestionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieSuggestionModel.fromJson(Map<String, dynamic> json) => MovieSuggestionModel(
        page: json["page"],
        results: List<dynamic>.from(json["results"].map((x) => x)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x)),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
