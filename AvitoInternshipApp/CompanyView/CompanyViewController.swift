import UIKit

final class CompanyViewController: UIViewController {
    
    let networkService = NetworkService()
    let cache = NSCache<NSString, CashedCompany>()
    var cachedCompany: CashedCompany? = nil {
        didSet {
            self.company = self.cachedCompany?.company
        }
    }
    var company: Company? = nil {
        didSet {
            self.company?.company.employees.sort { (lhs, rhs) in return lhs.name < rhs.name }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        view.addSubview(employeesTableView)
        view.addSubview(errorLabel)
        setupConstrintsEmployeesTableView()
        setupConstraintsErrorLabel()
        
        networkService.request { [weak self] (result) in
            switch result {
            case .failure(_):
                if let cachedVersion = self?.cache.object(forKey: "CachedCompany") {
                    self?.cachedCompany = cachedVersion
                } else {
                    self?.errorLabel.isHidden = false
                }
            case .success(let company):
//                self?.company = company
                if let cachedVersion = self?.cache.object(forKey: "CachedCompany") {
                    self?.cachedCompany = cachedVersion
                } else {
                    // create it from scratch then store in the cache
                    self?.cachedCompany = CashedCompany(company: company)
                    self?.cache.setObject((self?.cachedCompany!)!, forKey: "CachedObject")
                }
                self?.employeesTableView.reloadData()
            }
        }
    }
    // MARK: - Error Label
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, somthing went wrong.\nPlease check your internet connection or try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.font = .systemFont(ofSize: 26)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    func setupConstraintsErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Emplpoyees TableView
    private lazy var employeesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EmployeesTableViewCell.self,
                           forCellReuseIdentifier: EmployeesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        return tableView
    }()
    
    func setupConstrintsEmployeesTableView() {
        employeesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            employeesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            employeesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            employeesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - TableView Delegate, DataSource ext
extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return company?.company.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = employeesTableView.dequeueReusableCell(
            withIdentifier: EmployeesTableViewCell.identifier,
            for: indexPath
        ) as? EmployeesTableViewCell else {
            return .init()
        }
        
        cell.putDataToCell(name: company?.company.employees[indexPath.item].name ?? "",
                           skills: company?.company.employees[indexPath.item].skills ?? [],
                           phone: company?.company.employees[indexPath.item].phone_number ?? "",
                           index: indexPath.row)
        return cell
    }
    
}
