//
//  CategoryListViewController.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/8/21.
//

import UIKit

class CategoryListViewController: UITableViewController {

    var categoryList = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        QueryHandler.fetchCategoryList { [weak self] result in
            switch result {
            case .failure(let error):
                
                // Basic error handler
                print(error)

            case .success(let categoryList):

                // Sort and store received categories
                var categories = categoryList.categories

                categories.sort { left, right in
                    return left.strCategory.compare(right.strCategory) == .orderedAscending
                }

                self?.categoryList = categories
            }
        }
    }

    // MARK:- Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Set selected category on target
        if let recipeListVC = segue.destination as? RecipeListViewController,
           let indexPath = self.tableView.indexPathForSelectedRow,
           indexPath.row < categoryList.count {

            recipeListVC.selectedCategory = self.categoryList[indexPath.row]
        }
    }

    // MARK:- UITableView Delegate & Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        let category = categoryList[indexPath.row]
        cell.textLabel?.text = category.strCategory

        return cell
    }
}
