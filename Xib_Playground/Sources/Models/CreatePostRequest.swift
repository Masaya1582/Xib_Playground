//
//  CreatePostRequest.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import APIKit

struct CreatePostRequest: Request {
    typealias Response = Post

    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError("URL isn't valid")
        }
        return url
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/posts"
    }

    var parameters: Any? {
        return ["title": "New Post", "body": "This is the body of the new post", "userId": 1]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Post {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Post.self, from: data)
        } catch {
            throw error
        }
    }

}
