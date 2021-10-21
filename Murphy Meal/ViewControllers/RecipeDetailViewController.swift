//
//  RecipeDetailViewController.swift
//  Murphy Meal
//
//  Created by Joel Murphy on 10/8/21.
//

import UIKit

class RecipeDetailViewController: UITableViewController {

    var selectedRecipe: Recipe? = nil {
        didSet {
            if let recipe = self.selectedRecipe {
                self.title = recipe.strMeal
                QueryHandler.fetchRecipeDetails(recipe: recipe) { [weak self] result in

                    switch result {
                    case .failure(let error):

                        // Basic error handler
                        print(error)

                    case .success(let lookupResult):

                        if var recipeDetails = lookupResult.meals.first {
                            recipeDetails.buildIngredientArrays()
                            self?.recipeDetails = recipeDetails
                        }
                    }
                }
            }
        }
    }
    var recipeDetails: RecipeDetails? = nil {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var cachedImage: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ingredient count + 2 (MealImageCell and MealInstructionCell
        if let recipeDetails = self.recipeDetails {

            // Once cell for the image, cells for each ingredient, one cell for instructions
            return recipeDetails.ingredients.count + 2

        } else {

            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {

            // Display the image in the first row
            let cell: MealImageTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "MealImageCell")! as! MealImageTableViewCell
            cell.imageView?.image = cachedImage
            return cell

        } else if indexPath.row <= (recipeDetails?.ingredients.count)! {

            // Display each ingredient in (1...count) rows
            let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "MealIngredientCell")!
            if let recipeDetails = self.recipeDetails {
                cell.textLabel?.text = recipeDetails.measurements[indexPath.row - 1]
                cell.detailTextLabel?.text = recipeDetails.ingredients[indexPath.row - 1]
            }
            return cell

        } else {

            // Remaining cell is the instructions
            let cell: MealInstructionTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "MealInstructionCell")! as! MealInstructionTableViewCell
            if let recipeDetails = self.recipeDetails {
                cell.mealInstructionLabel.text = recipeDetails.strInstructions
            }
            return cell
        }
    }
}
