//
//  Models.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 6/27/21.
//

import Foundation


struct LoginSuccess : Codable {
    let success : Bool?
    let statusCode : Int?
    let statusMessage : String?
    
    enum  CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

struct LoginFailed : Codable {
    let success : Bool?
    let statusCode : Int?
    let statusMessage : String?
    
    enum  CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
}

struct LoginReqeust : Codable {
    let username : String
    let password : String
    let reqeustToken : String

    enum  CodingKeys: String, CodingKey {
        case username
        case password
        case reqeustToken = "reqeust_message"
    }
}

struct RequestTokenResponse : Codable {
    let success : Bool
    let expiresAt : String
    let reqeustToken : String

    enum  CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case reqeustToken = "request_token"
    }
}


struct MovieGenreList : Codable {
    let genres : [MoiveGenre]
}


struct MoiveGenre : Codable{
    let id : Int
    let name : String
//    let anotherProperty : String?   // data မပါရင်သုံးဖို
}

var movieGenres = [MoiveGenre]()
