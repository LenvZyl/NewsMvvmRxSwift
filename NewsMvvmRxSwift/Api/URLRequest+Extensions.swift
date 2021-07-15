//
//  URLRequest+Extensions.swift
//  NewsMvvmRxSwift
//
//  Created by Len van Zyl on 2021/07/13.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> T in
            let response = try JSONDecoder().decode(T.self,from: data)
            return response
        }
    }
}

extension ArticleResponse {
    static var all: Resource<ArticleResponse> = {
        let url = URL(string: Commons.baseNewsApiUrl + "/top-headlines?country=us&apiKey=" + Commons.apiKey)!
        return Resource(url: url)
    }()
}
