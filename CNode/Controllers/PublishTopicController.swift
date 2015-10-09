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
    
    var content: UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_PUBLISH_TOPIC".localized
        
        
        let btnDone: UIBarButtonItem = UIBarButtonItem(title: "ACTION_DONE".localized, style: .Plain, target: self, action: "done:")
        self.navigationItem.rightBarButtonItem = btnDone
        
        self.view.addSubview(self.content)
        self.content.placeholder = "输入内容"
        self.content.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.height.equalTo(300)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func done(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
