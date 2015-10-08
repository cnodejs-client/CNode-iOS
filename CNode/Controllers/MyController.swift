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
import SDWebImage

class MyController: BaseGroupedListController {
    // section 1
    let CELL_MY_PROFILE  : String = "ID_CELL_MY_PROFILE"
    let CELL_MY_BLOG     : String = "ID_CELL_MY_BLOG"
    let CELL_MY_FAVORITES: String = "ID_CELL_MY_FAVORITES"
    // section 2
    let CELL_MY_PROJECTS : String = "ID_CELL_MY_PROJECTS"
    let CELL_MY_TEAMS    : String = "ID_CELL_MY_TEAMS"

    var btnSettings: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_MY".localized
        
        self.btnSettings = UIBarButtonItem(title: "ACTION_SETTINGS".localized, style: .Plain, target: self, action: "settings:")
        self.navigationItem.rightBarButtonItem = btnSettings
        
        self.navigationController?.navigationBar.shadowImage = UIImage();
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (!User.isLogged()) {
            self.navigationItem.leftBarButtonItem = nil
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var title: String = "";
        var identifier: String = "";
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0:
                title = "我的动弹"
                identifier = CELL_MY_PROFILE
                let cell = MyProfileCell()
                cell.bind(User.current())
                cell.restorationIdentifier = identifier
                return cell
            case 1:
                title = "我的博客"
                identifier = CELL_MY_BLOG
                break
            case 2:
                title = "我的收藏"
                identifier = CELL_MY_FAVORITES
                if (User.isLogged()) {
                    //count = (User.current()?.favoritecount)!
                }
                break
            default:
                break
            }
            break
        case 1:
            switch (indexPath.row) {
            case 0:
                title = "我的项目"
                identifier = CELL_MY_PROJECTS
                break
            case 1:
                title = "我的团队"
                identifier = CELL_MY_TEAMS
                break
            default:
                break
            }
            break
        default:
            break
        }
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = title
        cell.restorationIdentifier = identifier
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        switch (cell.restorationIdentifier!) {
        case CELL_MY_PROFILE:
            if (!User.isLogged()) {
                let controller: LoginController = LoginController()
                self.presentViewController(controller, animated: true, leftButtonType: .Cancel)
            }
//            let controller: TweetListController = TweetListController(flag: .My)
//            controller.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(controller, animated: true)
            break
        case CELL_MY_BLOG:
//            let controller: BlogListController = BlogListController(flag: BlogListFlag.My)
//            controller.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(controller, animated: true)
            break
        case CELL_MY_FAVORITES:
//            let controller: FavoriteListController = FavoriteListController()
//            controller.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(controller, animated: true)
            break
        case CELL_MY_PROJECTS:
//            let controller: ProjectListController = ProjectListController()
//            controller.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(controller, animated: true)
            break
        case CELL_MY_TEAMS:
//            let controller: TeamController = TeamController()
//            controller.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(controller, animated: true)
            break
        default:
            return
        }
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

    func settings(sender: UIBarButtonItem) {
        let controller: SettingsController = SettingsController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}