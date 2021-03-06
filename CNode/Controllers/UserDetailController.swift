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

class UserDetailController: BaseListController<Topic> {

    init(data: User) {
        self.user = data
        super.init()
    }
    
    var user: User?
    var btnSettings: UIBarButtonItem?

    var userProfileHeader: UserProfileHeader = UserProfileHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.tableHeaderView = self.userProfileHeader
        self.tableView.header.backgroundColor = Theme.color.navigationBarBackground()
        self.tableView.backgroundColor = UIColor(rgba: "#e1e1e1")
        self.firstRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.userProfileHeader.bind(user!)
    }
    
    override func loadData(page: Int) {
        let success = {
            (data: User) -> Void in
            // 下拉刷新时清空数据源
            if (page == ApiClient.PAGE_FIRST) {
                self.dataSource = []
            }
            self.dataSource += data.recent_replies
            // 停止刷新中...
            self.endRefreshing()
            self.tableView.reloadData()
        };
        let failure = {
            (code: Int, message: String) -> Void in
            self.endRefreshing()
        };
        ApiClient.profileByUsername(user!.loginname!, success: success, failure: failure)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var title: String = "";
        var identifier: String = "";
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = title
        cell.restorationIdentifier = identifier
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.selected = false
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return CGFloat.min
        }
        return super.tableView(tableView, heightForHeaderInSection: section)
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            return nil
        }
        return super.tableView(tableView, viewForHeaderInSection: section)
    }
}