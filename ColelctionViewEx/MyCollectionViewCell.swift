//
//  MyCollectionViewCell.swift
//  ColelctionViewEx
//
//  Created by 김종권 on 2021/08/28.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    var text: String? {
        didSet { bind() }
    }

    lazy var label: UILabel = {
        let l = UILabel()
        l.textColor = .blue

        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.bounds = bounds

        backgroundColor = .yellow.withAlphaComponent(0.5)
        label.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        contentView.addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("coder not has been implemented")
    }

    private func bind() {
        label.text = text

        updateLayout()
    }

    private func updateLayout() {
        label.sizeToFit()

        label.frame = CGRect(x: 0, y: 0, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
        label.center = contentView.center
    }

}
