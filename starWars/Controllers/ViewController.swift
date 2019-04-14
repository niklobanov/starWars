//
//  ViewController.swift
//  starWars
//
//  Created by Никита on 03/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

final class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar {
        return searchController.searchBar
    }
    private var searchViewModel: SearchViewModel?
    let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: index, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addReachabilityObserver()
        configureSearchController()
        searchViewModel = SearchViewModel()
        if let viewModel = searchViewModel {
            viewModel.data?.drive(tableView.rx.items(cellIdentifier: "Cell")) { _, person, cell in
                cell.textLabel?.text = person.name
                }.disposed(by: disposeBag)
            searchBar.rx.text.orEmpty.bind(to: viewModel.searching).disposed(by: disposeBag)
            searchBar.rx.cancelButtonClicked.map{""}.bind(to: viewModel.searching).disposed(by: disposeBag)
            tableView.rx.modelSelected(Person.self).subscribe { event in
                if let person = event.element {
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(person, update: true)
                    }
                    let vc = DetailViewController(person: person)
                    let navigationController = UINavigationController(rootViewController: vc)
                    self.present(navigationController, animated: true, completion: nil)
                }
                }.disposed(by: disposeBag)
        }
    }

    
    deinit {
        removeReachabilityObserver()
    }

    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter request"
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
        definesPresentationContext = true
    }
}



extension ViewController: ReachabilityObserverDelegate {
    func reachabilityChanged(_ isReachable: Bool) {
        if !isReachable {
            let alert = UIAlertController(title: "Error", message: "No connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
