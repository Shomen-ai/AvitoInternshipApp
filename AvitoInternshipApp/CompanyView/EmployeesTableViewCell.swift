import UIKit

final class EmployeesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupCellItems()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupCellItems()
    }
    
    // место аватарки
    private lazy var avatarLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.cornerRadius = layer.frame.height / 2
        view.layer.masksToBounds = true
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 24)
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    // name
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // skills
    private lazy var skillsLabel: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = .systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // phone_number
    private lazy var phoneLabel: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = .systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupCellItems() {
        contentView.addSubview(avatarLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(skillsLabel)
        contentView.addSubview(phoneLabel)
        
        NSLayoutConstraint.activate([
            avatarLabel.heightAnchor.constraint(equalToConstant: 50),
            avatarLabel.widthAnchor.constraint(equalToConstant: 50),
            
            avatarLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 20),
            avatarLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor,
                                           constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor,
                                           constant: 15),
            
            skillsLabel.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor,
                                           constant: 10),
            skillsLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                           constant: -15),
            
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                           constant: -20),
            phoneLabel.topAnchor.constraint(equalTo: topAnchor,
                                           constant: 15),
        ])
    }
    
    func putDataToCell(name: String, skills: [String], phone: String, index: Int) {
        avatarLabel.text = name.first?.uppercased()
        avatarLabel.backgroundColor = hexStringToUIColor(hex: phone)
        avatarLabel.layer.borderColor = index % 2 == 0 ? #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1) : #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        nameLabel.text = name
        skillsLabel.text = skills.joined(separator: ", ")
        phoneLabel.text = phone
        contentView.backgroundColor = index % 2 == 0 ? #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) : #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
    }
}

extension UITableViewCell {
    public class var identifier: String {
        return "\(self.self)"
    }
}
