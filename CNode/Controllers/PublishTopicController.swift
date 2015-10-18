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

class PublishTopicController: BaseGroupedListController {
    
    var tbcTab: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Tab")
    var tbcTitle: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Title")
    var tbcContent: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Content")
    var tbcPublish: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell_Publish")
    
    var tfTitle: UITextField = UITextField()
    var tfContent: UITextView = UITextView()
    var btnPublish: UIButton = UIButton(frame: CGRectMake(0, 0, 0, 0), style: .Success)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_PUBLISH_TOPIC".localized
        
        self.tableView.separatorColor = Theme.color.separatorColor()
        self.tableView.tableFooterView = UIView()
        // 分类
        self.tbcTab.textLabel!.text = "分类"
        self.tbcTab.textLabel!.textColor = Theme.color.title()
//        self.tbcTab.backgroundColor = UIColor.whiteColor()
        self.tbcTab.selectionStyle = .None
        self.tbcTab.accessoryType = .DisclosureIndicator
        self.tbcTab.textLabel!.font = Theme.font.input()
        // 标题
        self.tfTitle.placeholder = "标题"
        self.tfTitle.font = Theme.font.input()
        self.tfTitle.textColor = Theme.color.title()
        self.tfTitle.frame = self.tbcTitle.frame
        self.tfTitle.clearButtonMode = .WhileEditing
        self.tfTitle.returnKeyType = .Next
        self.tbcTitle.textLabel!.text = " "
//        self.tbcTitle.backgroundColor = UIColor.clearColor()
        self.tbcTitle.selectionStyle = .None
        self.tbcTitle.contentView.addSubview(self.tfTitle)
        self.tfTitle.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tbcTitle.textLabel!)
            make.height.equalTo(self.tbcTitle.textLabel!)
            make.left.equalTo(self.tbcTitle.textLabel!)
            make.right.equalTo(self.tbcTitle.textLabel!)
        }
        // 正文
//        self.tfContent.placeholder = "正文"
//        self.tfContent.backgroundColor = UIColor.blueColor()
//        self.tbcContent.backgroundColor = UIColor.redColor()
        self.tfContent.font = Theme.font.input()
        self.tfContent.textColor = Theme.color.title()
        self.tfContent.frame = self.tfContent.frame
        self.tfContent.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.tbcContent.textLabel!.text = " "
//        self.tbcContent.backgroundColor = UIColor.clearColor()
        self.tbcContent.selectionStyle = .None
        self.tbcContent.contentView.addSubview(self.tfContent)
        self.tfContent.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tbcContent.textLabel!)
            make.height.equalTo(self.tbcContent.contentView)
            make.left.equalTo(self.tbcContent.textLabel!)
            make.right.equalTo(self.tbcContent.textLabel!)
        }
        // 登录
        self.btnPublish.setTitle("发布", forState: UIControlState.Normal)
        self.btnPublish.frame = self.tbcPublish.frame
        self.tbcPublish.textLabel!.text = " "
//        self.tbcPublish.backgroundColor = UIColor.clearColor()
        self.tbcPublish.selectionStyle = .None
        self.tbcPublish.contentView.addSubview(self.btnPublish)
        self.btnPublish.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.tbcPublish.textLabel!)
            make.height.equalTo(38)
            make.left.equalTo(self.tbcPublish.textLabel!)
            make.right.equalTo(self.tbcPublish.textLabel!)
            make.center.equalTo(self.tbcPublish.textLabel!)
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0:
            return self.tbcTab
        case 1:
            return self.tbcTitle
        case 2:
            return self.tbcContent
        case 3:
            return self.tbcPublish
        default:
            return UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 300
        }
        if indexPath.row == 3 {
            return 56
        }
        return 44
    }
    
    
    func publish(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
