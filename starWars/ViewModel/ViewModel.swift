//
//  ViewModel.swift
//  starWars
//
//  Created by Никита on 05/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa

final class SearchViewModel {
    let disposeBag = DisposeBag()
    let provider: MoyaProvider<Provider> = MoyaProvider<Provider>()
    var searching = Variable("")
    var data: Driver<[Person]>?

    func getResult(search: String) -> Observable<[Person]> {
        return  provider.rx.request(.result(searching: search))
            .filterSuccessfulStatusCodes()
            .map(Result.self)
            .map {
                $0.results
            }.asObservable()
    }

    init() {
        self.data = searching.asObservable()
        .throttle(0.1, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
            .flatMapLatest {
                self.getResult(search: $0)
        }.asDriver(onErrorJustReturn: [])
    }

}












