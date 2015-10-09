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

class MessagesController: BaseListController<Message> {

    var btnMarkAllAsRead: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_MESSAGES".localized
        
        
        self.btnMarkAllAsRead = UIBarButtonItem(title: "ACTION_MARK_ALL_AS_READ".localized, style: .Plain, target: self, action: "markAllAsRead:")
        self.navigationItem.rightBarButtonItem = btnMarkAllAsRead

        self.tableView.registerClass(MessageCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0

        self.firstRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func loadData(page: Int) {
        let success = {
            (data: [Message]) -> Void in
            // 下拉刷新时清空数据源
            if (page == 0) {
                self.dataSource = []
            }
            self.dataSource += data
            // 停止刷新中...
            self.endRefreshing()
            self.tableView.reloadData()
        };
        let failure = {
            (code: Int, message: String) -> Void in
            self.endRefreshing()
        };
        // 获取话题详情
        ApiClient.messageList(success, failure: failure)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MessageCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MessageCell
        let data: Message = self.dataSource[indexPath.row]
        cell.bind(data)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false

//        let controller: TopicDetailController = TopicDetailController()
//        controller.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func markAllAsRead(sender: UIBarButtonItem) {
        ApiClient.markAllAsRead({
            (data) -> Void in
            HUD.show(self.view, message: "全部消息标记为已读！")
        }, failure: {
            (code, message) -> Void in
        })
    }
}
