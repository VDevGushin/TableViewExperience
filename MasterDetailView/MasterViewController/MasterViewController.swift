//
//  MasterViewController.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    //Можно было бы создать отдельный класс UIview - и в нем описать все элементы
    var myRefreshControl: MyUIRefreshControl = {
        let refreshControl = MyUIRefreshControl()
        return refreshControl
    }()

    //Можно было бы это все сделать через DI!
    private let dataController: MasterViewDataController = FightMasterViewDataController(netwokrService: NetworkLayerOrService())
    private lazy var tableManager = TableManager(modelManager: ModelManager(), cellManager: CellManager(), tableView: self.tableView)

    var detailViewController: DetailViewController? = nil
    private let infoButton = UIBarButtonItem(title: "0", style: .plain, target: nil, action: nil)
    private lazy var upButton = UIBarButtonItem(title: "Up", style: .plain, target: self, action: #selector(up))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = upButton
        navigationItem.rightBarButtonItem = infoButton

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }

        //это все можно было бы сделать аккуратней
        self.tableView.addSubview(self.myRefreshControl)

        self.myRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        self.dataController.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500)) {
            self.dataController.fetchNewData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    private func refresh() {
        self.tableManager.clearAll()
        self.dataController.fetchNewData()
    }

    @objc
    private func up() {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let _ = self.tableManager[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                // controller.detailItem = DisplayModel()
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableManager.dataSourceCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableManager.getCell(model: self.tableManager[indexPath.row], indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableManager.getCellHeight(indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableManager.getCellHeight(indexPath: indexPath)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            self.dataController.fetchNewData()
        }
    }
}

extension MasterViewController: MasterViewDataControllerDelegate {

    func masterViewDataController(_ dataController: MasterViewDataController, new data: [BaseCellModel]) {
        self.tableManager.loadNewBatch(source: data) { [weak self] isClean, newIndexPaths in
            guard let self = self else { return }
            if isClean {
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(300)) {
                    self.myRefreshControl.stopLoading()
                }
            } else {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: newIndexPaths, with: .automatic)
                self.tableView.endUpdates()
            }
            self.infoButton.title = "\(self.tableManager.dataSourceCount)"
        }
    }
}

final class MyUIRefreshControl: UIRefreshControl {
    func stopLoading() {
        if self.isRefreshing {
            self.endRefreshing()
        }
    }
}
