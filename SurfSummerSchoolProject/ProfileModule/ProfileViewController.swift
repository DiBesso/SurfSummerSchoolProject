//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 06.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Views
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var profileModel: ProfileModel = ProfileExample.shared.profileModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        logoutButton.titleLabel?.text = "Выйти"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    // MARK: - Actions
    @IBAction func logoutAction(_ sender: Any) {
    }
    
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationItem.title = "Профиль"
    }
    
    private func configureTableView() {
        tableView.register(
            UINib(
                nibName: "\(ProfileTableViewCell.self)",
                bundle: .main), forCellReuseIdentifier: "\(ProfileTableViewCell.self)")
        tableView.register(
            UINib(
                nibName: "\(ProfileInfoTableViewCell.self)",
                bundle: .main), forCellReuseIdentifier: "\(ProfileInfoTableViewCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileTableViewCell.self)")
                if let cell = cell as? ProfileTableViewCell {
                    cell.imageUrlInString = profileModel.profileImage
                    cell.statusLabel.text = profileModel.status
                    cell.firstNameLabel.text = profileModel.firstName
                    cell.lastNameLabel.text = profileModel.secondName
                }
                return cell ?? UITableViewCell()
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoTableViewCell.self)")
                if let cell = cell as? ProfileInfoTableViewCell {
                    cell.profileTitleLabel.text = "Город"
                    cell.profileDetailLabel.text = profileModel.city
                }
                return cell ?? UITableViewCell()
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoTableViewCell.self)")
                if let cell = cell as? ProfileInfoTableViewCell {
                    cell.profileTitleLabel.text = "Телефон"
                    cell.profileDetailLabel.text = profileModel.phone
                }
                return cell ?? UITableViewCell()
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoTableViewCell.self)")
                if let cell = cell as? ProfileInfoTableViewCell {
                    cell.profileTitleLabel.text = "Почта"
                    cell.profileDetailLabel.text = profileModel.email
                }
                return cell ?? UITableViewCell()
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0:
                return 170
            default:
                return 72
            }
        }
}
