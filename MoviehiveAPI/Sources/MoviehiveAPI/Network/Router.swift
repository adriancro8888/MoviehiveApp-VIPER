//
//  File.swift
//  
//
//  Created by Zeynep Gizem Gürsoy on 24.04.2022.
//

import Foundation
import Alamofire

public enum Router: URLRequestConvertible {
    
    static let apiKey = "19c127a8e1f607dbb2aae38e047a7300"
    
    case fetchNowPlaying(page: Int?)
    case fetchUpcoming(page: Int?)
    case searchMovie(query: String?, page: Int?)
    case fetchMovieDetail(movieId: Int)
    case fetchSimilarMovie(movieId: Int)
    
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchNowPlaying, .fetchUpcoming, .searchMovie, .fetchMovieDetail, .fetchSimilarMovie:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: Parameters = [:]
        
        switch self {
        case .fetchNowPlaying(page: let page):
            if let page = page {
                params["page"] = page
            }
        case .fetchUpcoming(page: let page):
            if let page = page {
                params["page"] = page
            }
        case .searchMovie(query: let query, page: let page):
            if let query = query {
                params["query"] = query
            }
            if let page = page {
                params["page"] = page
            }
        case .fetchMovieDetail:
            return nil
        case .fetchSimilarMovie:
            return nil
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .fetchNowPlaying:
            return "/movie/now_playing"
        case .fetchUpcoming:
            return "/movie/upcoming"
        case .searchMovie:
            return "/search/movie"
        case .fetchMovieDetail(movieId: let id):
            return "movie/\(id)"
        case .fetchSimilarMovie(movieId: let id):
            return "movie/\(id)/similar"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("************> MY URL: ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}
