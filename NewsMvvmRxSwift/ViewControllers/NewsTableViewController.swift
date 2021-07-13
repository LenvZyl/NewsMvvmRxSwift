//
//  NewsTableViewController.swift
//  NewsMvvmRxSwift
//
//  Created by Len van Zyl on 2021/07/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    
    private var articleListViewModel: ArticleListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .red
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }else{
            self.navigationController?.navigationBar.backgroundColor = .red
        }
        fetchNews()
    }
    
    private func fetchNews(){
        URLRequest.load(resource: ArticleResponse.all).subscribe(onNext: { articleResponse in
            let articles = articleResponse.articles
            self.articleListViewModel = ArticleListViewModel(articles)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.articleCount()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell not found")
        }
        cell.descriptionLabel.textColor = .gray
        let articleViewModel: ArticleViewModel = self.articleListViewModel.articleAt(indexPath.row)
        articleViewModel.title
            .asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        articleViewModel.description
            .asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        return cell
    }
}
