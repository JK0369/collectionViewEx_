//
//  ViewController.swift
//  ColelctionViewEx
//
//  Created by 김종권 on 2021/08/28.
//

import UIKit

class ViewController: UIViewController {

    // Views

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .systemGray

        view.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        return view
    }()

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 12.0
        view.backgroundColor = .systemGreen
        return view
    }()

    lazy var insertButton: UIButton = {
        let button = UIButton()
        button.setTitle("삽입", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapInsertButton(_:)), for: .touchUpInside)
        return button
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()

    lazy var moveButton: UIButton = {
        let button = UIButton()
        button.setTitle("이동", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapMoveButton(_:)), for: .touchUpInside)
        return button
    }()

    // Controls

    var dataSource = ["1", "2", "3", "4", "5", "6"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }

    func setupView() {
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        view.addSubview(stackView)
        [insertButton, deleteButton, moveButton].forEach{ stackView.addArrangedSubview($0) }
    }

    func setupLayout() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36)
        ])
    }

    @objc func didTapInsertButton(_ sender: Any) {
        collectionView.performBatchUpdates {
            dataSource.insert("123", at: 0)
            collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])

            dataSource.remove(at: 5)
            collectionView.deleteItems(at: [IndexPath(item: 5, section: 0)])
        } completion: { [weak self] _ in
            print(self?.collectionView.numberOfItems(inSection: 0))
        }
    }

    @objc func didTapDeleteButton(_ sender: Any) {

    }

    @objc func didTapMoveButton(_ sender: Any) {

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.text = dataSource[indexPath.item]
        return cell
    }
}
