//
//  HsitoryViewController.swift
//  starWars
//
//  Created by Никита on 08/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRealm
import RealmSwift

class HsitoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()

        let realm = try! Realm()
        let  people = realm.objects(Person.self)
        Observable.collection(from: people)
            .bind(to: tableView.rx.items) {_, ip, element in
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = element.name
                return cell
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Person.self).subscribe { event in
            if let person = event.element {
                let vc = DetailViewController(person: person)
                let navigationController = UINavigationController(rootViewController: vc)
                self.present(navigationController, animated: true, completion: nil)
            }
            }.disposed(by: disposeBag)
    }


    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: index, animated: true)
        }
    }

}
