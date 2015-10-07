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

class HomeController: BaseTabBarController {
    
    var topicController    : TopicController?       // 主题
    var messagesController : MessagesController?    // 消息
    var myController       : MyController?          // 我的

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topicController     = TopicController()
        self.messagesController  = MessagesController()
        self.myController        = MyController()
        
        // 增加Tab
        self.addTab("TAB_TOPIC".localized    , icon: "ic_tab_topic"    , controller: self.topicController)
        self.addTab("TAB_MESSAGES".localized  , icon: "ic_tab_messages" , controller: self.messagesController)
        self.addTab("TAB_MY".localized       , icon: "ic_tab_my"       , controller: self.myController)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        if (User.isLogged()) {
//            // 显示未读消息数
//            let noticeCount: Int = Notice.current()!.count()
//            self.myController!.tabBarItem.badgeValue = noticeCount > 0 ? "\(noticeCount)" : nil
//        } else {
//            self.myController!.tabBarItem.badgeValue = nil
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
