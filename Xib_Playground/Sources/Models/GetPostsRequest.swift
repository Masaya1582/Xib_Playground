//
//  GetPostsRequest.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import APIKit

struct GetPostsRequest: Request {
    typealias Response = [Post]

    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError("Invalid URL")
        }
        return url
    }

    var path: String {
        return "/posts"
    }

    var method: HTTPMethod {
        return .get
    }

    var headerFields: [String: String] {
        return ["Content-Type": "application/json"]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Post] {
        // Deserialize the response data into an array of Post objects
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let decoder = JSONDecoder()
        return try decoder.decode([Post].self, from: data)
    }
}
