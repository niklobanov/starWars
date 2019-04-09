//
//  DetailViewController.swift
//  starWars
//
//  Created by Никита on 08/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController {
    private var person: Person
    @IBOutlet weak var textView: UITextView!
    private var filmPresent = ""
    private  var speciesPresent = ""
    private var vehiclesPresent = ""
    private var starshipsPresent = ""

    private func arrayPresentation(_ array: [String]) -> String {
        var string = ""
        array.forEach { element in
            string += "\n      \(element)"
        }
        guard !string.isEmpty else {
            return "nil"
        }
        return string
    }

    private func configureTextView() {
        textView.text = """
        Name:   \(person.name)
        Height:   \( person.height)
        Mass:   \(person.mass)
        Gender:   \(person.gender)
        HairColor:   \(person.hairColor)
        BirthYear:   \( person.birtYear)
        EyeColor:   \(person.eyeColor)
        SkinColor:   \(person.skinColor)
        HomeWorld:   \( person.homeworld)
        Films:   \(filmPresent)
        Species:   \(speciesPresent)
        Vehicles:   \(vehiclesPresent)
        Starships:   \(starshipsPresent)
        Created:   \( person.created)
        Edited:   \(person.edited)
        URL:   \(person.url)
        """
    }

    init(person: Person) {
        self.person = person
        super.init(nibName: "DetailViewController", bundle: .main)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        configurePresent()
        configureTextView()
    }

    private func configurePresent() {
        filmPresent = arrayPresentation(Array(person.films))
        starshipsPresent = arrayPresentation(Array(person.starships))
        vehiclesPresent = arrayPresentation(Array(person.vehicles))
        speciesPresent = arrayPresentation(Array(person.species))
    }

    private func setNavigationBar() {
        navigationItem.title = "\(person.name)"
        let cancelItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(onCancelButtonTap)
        )
        navigationItem.leftBarButtonItem = cancelItem
    }

    @objc
    private func onCancelButtonTap() {
        navigationController?.dismiss(animated: true)
    }

}
