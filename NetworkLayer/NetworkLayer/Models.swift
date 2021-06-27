//
//  Models.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 6/27/21.
//

import Foundation


struct LoginSuccess : Decodable {
    let success : Bool?
    let statusCode : Int?
    let statusMessage : String?
}

struct LoginFailed : Decodable {
    let success : Bool?
    let statusCode : Int?
    let statusMessage : String?
    
    enum  CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
}

struct LoginReqeust : Decodable {
    let username : String
    let passwrod : String
    let reqeustToken : String

    enum  CodingKeys: String, CodingKey {
        case username
        case password
        case reqeustToken = "reqeust_message"
    }
}

struct MovieGenreList : Decodable {
    let genres : [MoiveGenre]
}

struct MoiveGenre : Decodable{
    let id : Int
    let name : String
//    let anotherProperty : String?   // data မပါရင်သုံးဖို
}
