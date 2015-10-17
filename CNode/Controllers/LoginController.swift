/**
 * Copyright (C) 2015 JianyingLi
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import OnePasswordExtension

class LoginController: BaseGroupedListController {

    var tbcTitle: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell_Title")
    var tbcUsername: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Username")
    var tbcPassword: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Password")
    var tbcLogin: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Login")
    var tbcForgotPassword: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Login")
    
    var btnOnepassword: UIButton = UIButton()
    var tfUsername: UITextField = UITextField()
    var tfPassword: UITextField = UITextField()
    var btnLogin: UIButton = UIButton(frame: CGRectMake(0, 0, 0, 0), style: .Primary)
    var btnForgotPassword: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_LOGIN".localized
        
        self.tableView.separatorStyle = .None
//        self.tableView.scrollEnabled = false
        
        // 标题
        self.tbcTitle.backgroundColor = UIColor.clearColor()
        self.tbcTitle.selectionStyle = .None
        self.tbcTitle.textLabel?.text = "欢迎回来"
        self.tbcTitle.textLabel?.font = Theme.font.title()
        self.tbcTitle.textLabel?.textColor = Theme.color.title()
        self.tbcTitle.detailTextLabel?.text = "用邮箱登录，看看之前都错过了什么好文章吧。"
        self.tbcTitle.detailTextLabel?.font = Theme.font.content()
        self.tbcTitle.detailTextLabel?.textColor = Theme.color.content()
        self.tbcTitle.textLabel?.snp_makeConstraints{ (make) -> Void in
            make.centerX.equalTo(self.tbcTitle.contentView)
            make.top.equalTo(16)
        }
        self.tbcTitle.detailTextLabel?.snp_makeConstraints{ (make) -> Void in
            make.top.equalTo((self.tbcTitle.textLabel?.snp_bottom)!).inset(-5)
            make.centerX.equalTo(self.tbcTitle.contentView)
        }
        // 用户名
        self.tfUsername.placeholder = "电子邮箱"
        self.tfUsername.font = Theme.font.input()
        self.tfUsername.textColor = Theme.color.title()
        self.tfUsername.frame = self.tbcUsername.frame
        self.tfUsername.clearButtonMode = .WhileEditing
        self.tfUsername.returnKeyType = .Next
        self.tbcUsername.textLabel!.text = " "
        self.tbcUsername.backgroundColor = UIColor.clearColor()
        self.tbcUsername.selectionStyle = .None
        self.tbcUsername.contentView.addSubview(self.tfUsername)
        self.tfUsername.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tbcUsername.textLabel!)
            make.height.equalTo(self.tbcUsername.textLabel!)
            make.left.equalTo(self.tbcUsername.textLabel!)
            make.right.equalTo(self.tbcUsername.textLabel!)
        }
        let separator1: UIView = UIView()
        self.tbcUsername.contentView.addSubview(separator1)
        separator1.backgroundColor = Theme.color.separatorColor()
        separator1.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tfUsername.snp_width)
            make.top.equalTo(0)
            make.height.equalTo(1)
            make.centerX.equalTo(self.tfUsername)
        }
        // 添加onepassword按钮
        if (OnePasswordExtension.sharedExtension().isAppExtensionAvailable()) {
            self.btnOnepassword.setBackgroundImage(UIImage(named: "onepassword-button"), forState: UIControlState.Normal)
            self.btnOnepassword.addTarget(self, action: Selector("onepassword:"), forControlEvents: .TouchUpInside)
            self.tbcUsername.contentView.addSubview(self.btnOnepassword)
            self.btnOnepassword.snp_makeConstraints { (make) -> Void in
                make.height.equalTo(22)
                make.width.equalTo(22)
                make.right.equalTo(self.tfUsername)
                make.centerY.equalTo(self.tfUsername)
            }
        }
        // 密码
        self.tfPassword.placeholder = "密码"
        self.tfPassword.font = Theme.font.input()
        self.tfPassword.textColor = Theme.color.title()
        self.tfPassword.frame = self.tbcPassword.frame
        self.tfPassword.clearButtonMode = .WhileEditing
        self.tfPassword.secureTextEntry = true
        self.tfPassword.returnKeyType = .Go
        self.tbcPassword.textLabel!.text = " "
        self.tbcPassword.backgroundColor = UIColor.clearColor()
        self.tbcPassword.selectionStyle = .None
        self.tbcPassword.contentView.addSubview(self.tfPassword)
        self.tfPassword.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tbcPassword.textLabel!)
            make.height.equalTo(self.tbcPassword.textLabel!)
            make.left.equalTo(self.tbcPassword.textLabel!)
            make.right.equalTo(self.tbcPassword.textLabel!)
        }
        let separator2: UIView = UIView()
        self.tbcPassword.contentView.addSubview(separator2)
        separator2.backgroundColor = Theme.color.separatorColor()
        separator2.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tfPassword.snp_width)
            make.top.equalTo(0)
            make.height.equalTo(1)
            make.centerX.equalTo(self.tfPassword)
        }
        // 登录
        self.btnLogin.setTitle("登录", forState: UIControlState.Normal)
        self.btnLogin.frame = self.tbcLogin.frame
        self.tbcLogin.textLabel!.text = " "
        self.tbcLogin.backgroundColor = UIColor.clearColor()
        self.tbcLogin.selectionStyle = .None
        self.tbcLogin.contentView.addSubview(self.btnLogin)
        self.btnLogin.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tbcLogin.textLabel!)
            make.height.equalTo(38)
            make.left.equalTo(self.tbcLogin.textLabel!)
            make.right.equalTo(self.tbcLogin.textLabel!)
            make.center.equalTo(self.tbcLogin.textLabel!)
        }
        let separator3: UIView = UIView()
        self.tbcLogin.contentView.addSubview(separator3)
        separator3.backgroundColor = Theme.color.separatorColor()
        separator3.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.btnLogin.snp_width)
            make.top.equalTo(0)
            make.height.equalTo(1)
            make.centerX.equalTo(self.btnLogin)
        }
        // 忘记密码
        self.btnForgotPassword.setTitleColor(Theme.color.content(), forState: UIControlState.Normal)
        self.btnForgotPassword.setTitle("忘记密码？", forState: UIControlState.Normal)
        self.btnForgotPassword.titleLabel?.font = Theme.font.content()
        self.tbcForgotPassword.textLabel!.text = " "
        self.tbcForgotPassword.backgroundColor = UIColor.clearColor()
        self.tbcForgotPassword.selectionStyle = .None
        self.tbcForgotPassword.contentView.addSubview(self.btnForgotPassword)
        self.btnForgotPassword.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.center.equalTo(self.tbcForgotPassword.textLabel!)
        }
     
        // 添加View事件处理
        self.tfUsername.addTarget(self, action: "usernameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.btnLogin.addTarget(self, action: "login:", forControlEvents: .TouchUpInside)
        self.btnForgotPassword.addTarget(self, action: "forgotPassword:", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0:
            return self.tbcTitle
        case 1:
            return self.tbcUsername
        case 2:
            return self.tbcPassword
        case 3:
            return self.tbcLogin
        case 4:
            return self.tbcForgotPassword
        default:
            return UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        }
        // 登录按钮
        if indexPath.row == 3 {
            return 62
        }
        // 忘记密码按钮
        if (indexPath.row == 4) {
            return 18
        }
        return 44
    }
    
    func login(sender: UIButton) {
        let username: String = tfUsername.text!
        let password: String = tfPassword.text!
        
        if (username.characters.count == 0) {
            HUD.showError("请输入电子邮箱")
            return
        }
        if (password.characters.count == 0) {
            HUD.showError("请输入密码")
            return
        }
        HUD.showProcessing("登录中...")
        print("\(username) \(password)")
        ApiClient.login(username, password: password,
            success: {
                (data: User) -> Void in
                print(data)
                HUD.showSuccess("欢迎" + data.loginname!)
                self.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.popToRootViewControllerAnimated(true)
            },
            failure: {
                (code: Int, message: String) -> Void in
                HUD.showError(message)
            }
        )
    }
    
    func forgotPassword(sender: UIButton) {
        let controller = WebViewController(pageTitle: "忘记密码", pageURL: URLs.FORGOT_PASSWORD)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onepassword(sender: UIButton!) {
        OnePasswordExtension.sharedExtension().findLoginForURLString(URLs.baseURL, forViewController: self, sender: sender, completion: { (loginDictionary, error) -> Void in
            if loginDictionary == nil {
                if error!.code != Int(AppExtensionErrorCodeCancelledByUser) {
                    print("Error invoking 1Password App Extension for find login: \(error)")
                }
                return
            }
            
            self.tfUsername.text = loginDictionary?[AppExtensionUsernameKey] as? String
            self.tfPassword.text = loginDictionary?[AppExtensionPasswordKey] as? String
            // 判断是否隐藏1password按钮
            self.usernameFieldDidChange(self.tfUsername)
        })
    }
    
    func usernameFieldDidChange(textField: UITextField) {
        btnOnepassword.hidden = textField.text?.characters.count != 0
    }
}
