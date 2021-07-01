//
//  SearchSeriesResponse.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 7/1/21.
//

import Foundation

// VO - Value Object

struct SearchSeriesVO : Codable {
    let page : Int?
    let results : [SeriesItemVo]?
    let totalPages : Int?
    let totalResults : Int?
    
    enum CodingKeys : String, CodingKey {
        case page = "page"
        case results  = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct SeriesItemVo : Codable {
    let adult : Bool?
    let backdropPath : String?
    let genreIds : [Int]?
    let id : Int?
    let originalLangugae : String?
    let originalTitle : String?
    let overview : String?
    let popularity : Double?
    let posterPath : String?
    let releaseDate : String?
    let title : String?
    let video : Bool?
    let voteAverage : Double?
    let voteCount : Int
    
    enum CodingKeys : String , CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLangugae = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}






