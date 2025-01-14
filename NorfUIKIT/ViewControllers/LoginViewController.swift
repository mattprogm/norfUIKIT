import UIKit


class LoginViewController: UIViewController {
    
    private var loginView: LoginView!
    private var userModel: UserLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView()
        loginView.frame = view.bounds
        loginView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view = loginView
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.loginButtonTest.addTarget(self, action: #selector(testUserModel), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerLabelTapped))
        loginView.registerHereLabel.addGestureRecognizer(tapGesture)
    }
    
    // Ação para quando a registerLabel for tocada
    @objc private func registerLabelTapped() {
        print("Register label clicked!")
        let registerViewController = RegisterViewController() // Sua nova tela
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        print("Botão de login pressionado")
        
        // Pegando os valores do LoginView
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text,
              !email.isEmpty, !password.isEmpty else {
            showAlert(message: "Por favor, preencha todos os campos.")
            return
        }
        
        // Chamando a função de login com os valores dos campos
        loginRequest(email: email, password: password)
    }
    
    @objc private func testUserModel() {
        if let user = userModel {
            print("Usuário logado:")
            print("Nome: \(user.username)")
            print("Token: \(user.token)")
            print("ID: \(user.userID)")
            print("Sucesso: \(user.sucesso)")
        } else {
            print("Nenhum usuário logado ainda.")
        }
    }
    
    // MARK: - Solicitação de Login
    private func loginRequest(email: String, password: String) {
        let url = URL(string: "https://app.norf.com.br/api/login.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Adicionando os parâmetros diretamente no corpo da requisição
        let bodyString = "user=\(email)&password=\(password)"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(message: "Erro na requisição: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.showAlert(message: "Resposta inválida do servidor.")
                }
                return
            }
            
            print("Status Code: \(response.statusCode)")
            
            let cleanedData = self.removeBOM(from: data)
            
            do {
                let user = try JSONDecoder().decode(UserLogin.self, from: cleanedData)
                self.userModel = user
                
                DispatchQueue.main.async {
                    print("Login bem-sucedido!")
                    print("User ID: \(user.userID)")
                    print("Nome: \(user.username)")
                    print("Token: \(user.token)")
                    // Aqui você pode navegar para outra tela
                }
            } catch {
                DispatchQueue.main.async {
                    self.showAlert(message: "Erro ao processar os dados do servidor.")
                    if let rawResponse = String(data: cleanedData, encoding: .utf8) {
                        print("Resposta bruta: \(rawResponse)")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    private func removeBOM(from data: Data) -> Data {
        var cleanedData = data
        if cleanedData.count > 3 && cleanedData[0] == 0xEF && cleanedData[1] == 0xBB && cleanedData[2] == 0xBF {
            cleanedData.removeSubrange(0..<3)
        }
        return cleanedData
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}




struct UserLogin: Codable {
    let sucesso: String
    let username: String
    let token: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case sucesso
        case username = "Nome"
        case token = "Token"
        case userID = "UserID"
    }
}
