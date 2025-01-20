//
//  API.swift
//  MIAapp
//
//  Created by Sören Kirchner on 30.01.22.
//

import Foundation

public struct API {
    
//    static let buildings = URL(string: "https://modernism-in-architecture.org/api/v1/buildings/")!
//    static let architects = URL(string: "https://modernism-in-architecture.org/api/v1/architects/")!
    
    static let timeoout = 10.0
    
//    static func building(for id: Int) -> URL {
//        return URL(string: "https://modernism-in-architecture.org/api/v1/buildings/\(id)/")!
//    }
//    
//    static func architect(for id: Int) -> URL {
//        return URL(string: "https://modernism-in-architecture.org/api/v1/architects/\(id)/")!
//    }
//    
//    public static func request(for url: URL) -> URLRequest {
//        
//        var request = URLRequest(url: url, timeoutInterval: API.timeoout)
//        request.addValue("Token \(Secrets.api_token)", forHTTPHeaderField: "Authorization")
//        return request
//    }
}

public enum MIARequest {
    
    case architect(id: Int)
    case architects
    case building(id: Int)
    case buildings
    case buildingsCount(since: Date)
    
    private static let baseUrl = "https://modernism-in-architecture.org/api/v1"
    
    private var urlString: String {
        
        switch self {
            
        case let .architect(id):
            "\(Self.baseUrl)/architects/\(id)/"
            
        case .architects:
            "\(Self.baseUrl)/architects/"
            
        case let .building(id):
            "\(Self.baseUrl)/buildings/\(id)/"
            
        case .buildings:
            "\(Self.baseUrl)/buildings/"
        
        case let .buildingsCount(date):
            "\(Self.baseUrl)/buildings/count/?since=\(date.toISO8601String())"
        }
    }
    
    public var request: URLRequest? {

        guard let url = URL(string: self.urlString) else {
            return nil
        }
        
        print("Token")
        print(Secrets.api_token)
        var request = URLRequest(url: url, timeoutInterval: API.timeoout)
        request.addValue("Token \(Secrets.api_token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
