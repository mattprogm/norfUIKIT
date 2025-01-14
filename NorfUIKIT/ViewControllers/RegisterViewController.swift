import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Variáveis
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    // MARK: - Subviews
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.borderStyle = .none
        textField.backgroundColor =  .systemGray6
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 1.5
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 62))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recuperar senha", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
               
    }()
    
    let forgotPasswordText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Digite seu endereço de e-mail para recuperar sua senha"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Registrar-se"
        
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.addSubview(emailTextField)
        view.addSubview(registerButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
           
            // Register Button
            registerButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Register Functions
    @objc func handleRegister() {
        email = emailTextField.text
        
        print("Email: \(email ?? "")")

        
    }
    
}
    
