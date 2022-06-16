//
//  PopulerMovieModel.swift
//  Core
//
//  Created by Phincon on 14/06/22.
//

import Foundation

public struct PopulerMovieModel: Codable {
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
