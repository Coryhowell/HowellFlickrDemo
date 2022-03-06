//
//  PuppyCell.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/4/22.
//

import UIKit
 
class PuppyCell: UICollectionViewCell {
    
    static let identifier = "PuppyCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let puppyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let datePublishedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    var puppy: Puppy? {
        didSet {
            titleLabel.text = puppy?.title
            datePublishedLabel.text = puppy?.formattedPublishedDate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Cell "card" style and shadow 
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.25
        
        addSubview(containerView)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(puppyImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(datePublishedLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            mainStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPuppy(_ puppy: Puppy) {
        self.puppy = puppy
    }
    
    func setPuppyImage(image: UIImage?) {
        puppyImageView.image = image
    }
}

