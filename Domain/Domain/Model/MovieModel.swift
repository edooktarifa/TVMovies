//
//  MovieModel.swift
//  Domain
//
//  Created by Phincon on 10/06/22.
//

import Foundation

public struct TopRatedMovieModel: Codable {
    public let page: Int?
    public let results: [TopRatedMovieResult]?
    public let totalPages: Int?
    public let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
public struct TopRatedMovieResult: Codable {
    public let adult: Bool?
    public let id: Int?
    public let genreIDS: [Int] = []
    public let backdropPath : String?
    public let originalLanguage, originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


