//
//  Constant.swift
//  NetworkServices
//
//  Created by Phincon on 09/06/22.
//

import Foundation


public struct Constant {
    static let baseUrl = "https://api.themoviedb.org/3"
    public static let apiKey = ApiKey.share.getApiKey()
}

public enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict(error: Any)               //Status code 409
    case internalServerError    //Status code 500
}

public enum ErrorMessage: String{
    case forbidden = "Forbidden Error"
    case notFound = "Not Found"
    case conflict = "Conflict Error"
    case internalServerError = "Internal Server Error"
    case unknownError = "No Internet Connection"
}
