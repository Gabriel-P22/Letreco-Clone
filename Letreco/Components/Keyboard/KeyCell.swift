//
//  KeyCell.swift
//  Letreco
//
//  Created by Gabriel Paschoal on 10/03/22.
//

import UIKit

class KeyCell: UICollectionViewCell {
    static let identifier = "KeyCell"
    
    let label: UILabel = {
       
        let label  = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        contentView.addSubview(label)
        
        setContraintsKeyCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        
    }
    
    func configure(with letter: Character) {
        label.text = String(letter).uppercased()
    }
    
    func setContraintsKeyCell() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
