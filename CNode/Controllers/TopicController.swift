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

import UIKit
import XLPagerTabStrip

class TopicController: BaseButtonBarPagerTabStripViewController {
    
    var btnPublishTopic: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_TOPIC".localized
        
        self.btnPublishTopic = UIBarButtonItem(title: "ACTION_PUBLISH_TOPIC".localized, style: .Plain, target: self, action: "publishTopic:")
        self.navigationItem.rightBarButtonItem = btnPublishTopic
    }
    
    override func childViewControllersForPagerTabStripViewController(pagerTabStripViewController: XLPagerTabStripViewController!) -> [AnyObject]! {
        
        let controller1 = TopicListController(flag: TopicListFlag.All)
        let controller2 = TopicListController(flag: TopicListFlag.Good)
        let controller3 = TopicListController(flag: TopicListFlag.Share)
        let controller4 = TopicListController(flag: TopicListFlag.Ask)
        let controller5 = TopicListController(flag: TopicListFlag.Job)
        controller1.tableView.contentInset = self.contentInset()
        controller2.tableView.contentInset = self.contentInset()
        controller3.tableView.contentInset = self.contentInset()
        controller4.tableView.contentInset = self.contentInset()
        controller5.tableView.contentInset = self.contentInset()
        controller1.tableView.scrollIndicatorInsets = self.scrollIndicatorInsets()
        controller2.tableView.scrollIndicatorInsets = self.scrollIndicatorInsets()
        controller3.tableView.scrollIndicatorInsets = self.scrollIndicatorInsets()
        controller4.tableView.scrollIndicatorInsets = self.scrollIndicatorInsets()
        controller5.tableView.scrollIndicatorInsets = self.scrollIndicatorInsets()
        return [controller1, controller2, controller3, controller4, controller5]
    }
    
    func publishTopic(sender: UIBarButtonItem) {
        let controller: PublishTopicController = PublishTopicController()
        self.presentViewController(controller, animated: true, leftButtonType: .Cancel)
    }
}
