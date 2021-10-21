//
//  RecipeListViewController.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/8/21.
//

import UIKit

class RecipeListViewController: UITableViewController {

    var selectedCategory: Category? = nil {
        didSet {
            if let category = self.selectedCategory {
                self.title = category.strCategory
                QueryHandler.fetchRecipeList(category: category) { [weak self] result in

                    switch result {
                    case .failure(let error):

                        // Basic error handler
                        print(error)

                    case .success(let recipeList):

                        // Sort and store received recipes
                        var recipes = recipeList.meals

                        recipes.sort { left, right in
                            return left.strMeal.compare(right.strMeal) == .orderedAscending
                        }

                        self?.recipeList = recipes
                    }
                }
            } else {
                self.title = ""
            }
        }
    }

    var recipeList = [Recipe]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:- Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Set selected recipe on target
        if let recipeDetailVC = segue.destination as? RecipeDetailViewController,
           let indexPath = self.tableView.indexPathForSelectedRow,
           indexPath.row < recipeList.count {

            let recipe = self.recipeList[indexPath.row]
            let cell = self.tableView.cellForRow(at: indexPath)! as! RecipeTableViewCell

            recipeDetailVC.selectedRecipe = recipe
            recipeDetailVC.cachedImage = cell.recipeImageView.image
        }
    }

    // MARK:- UITableView Delegate & Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell")! as! RecipeTableViewCell
        let recipe = recipeList[indexPath.row]

        cell.recipeLabel.text = recipe.strMeal
        cell.recipeImageView.image = nil

        DispatchQueue.global().async {
            QueryHandler.fetchImage(urlString: recipe.strMealThumb) { result in

                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell.recipeImageView.image = image
                        print(image)
                    }
                }
            }
        }

        return cell
    }
}
