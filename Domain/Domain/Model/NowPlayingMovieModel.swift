//
//  NowPlayingMovieModel.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation

public struct NowPlayingMovieModel: Codable {
    public let dates: UpcomingMoviesDate?
    public let page: Int?
    public let results: [TopRatedMovieResult]?
    public let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
