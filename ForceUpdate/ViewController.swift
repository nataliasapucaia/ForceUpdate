//
//  ViewController.swift
//  ForceUpdate
//
//  Created by Natalia da Rosa Sapucaia on 10/08/22.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }

    private func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WELCOME"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        ])
    }
}
