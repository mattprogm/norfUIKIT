import UIKit

class LoginView: UIView {
    
    // MARK: - Subviews
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "norfLogoPreto")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Adicionando sombra à imagem
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.layer.shadowRadius = 3.5
        imageView.layer.shadowOpacity = 0.8
        return imageView
    }()
    
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
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Senha",
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
        
        
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(red: 0/255, green: 191/255, blue: 73/255, alpha: 1)

        config.baseForegroundColor = .white // Cor do texto
        config.cornerStyle = .capsule // Bordas arredondadas automáticas
        config.attributedTitle = AttributedString("Entrar", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 18)]))

        
        
        let button = UIButton(configuration: config)
      
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
  
    }()
    
    let loginButtonTest: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Testar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registerHereLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.text = "Não tem conta? Cadastre-se aqui!"
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        applyGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(loginButtonTest)
        addSubview(registerHereLabel)

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Logo ImageView
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 45),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 210),
            logoImageView.heightAnchor.constraint(equalToConstant: 210),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 70),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButtonTest.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            loginButtonTest.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginButtonTest.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            loginButtonTest.heightAnchor.constraint(equalToConstant: 50),
            
            registerHereLabel.topAnchor.constraint(equalTo: loginButtonTest.bottomAnchor, constant: 10),
            registerHereLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            registerHereLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            registerHereLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Gradient Background
    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 53/255, green: 53/255, blue: 96/255, alpha: 1).cgColor, // Cor roxa #353560
            UIColor(red: 0/255, green: 191/255, blue: 168/255, alpha: 1).cgColor ,  // Cor verde #00bfa8

            
        ]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
}
