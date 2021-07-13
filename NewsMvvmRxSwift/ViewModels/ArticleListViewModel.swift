//
//  ArticleListViewModel.swift
//  NewsMvvmRxSwift
//
//  Created by Len van Zyl on 2021/07/13.
//

import Foundation
import RxCocoa
import RxSwift

struct ArticleListViewModel {
    let articleViewModel: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]) {
        self.articleViewModel = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articleViewModel[index]
    }
    func articleCount() -> Int {
        return self.articleViewModel.count
    }
}

