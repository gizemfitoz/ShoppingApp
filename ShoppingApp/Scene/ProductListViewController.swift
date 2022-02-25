//
//  ProductListViewController.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import UIKit

final class ProductListViewController: BaseViewController, ProductListViewProtocol {
    @IBOutlet var tableView: UITableView!
    var viewModel: ProductListViewModelProtocol!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        self.navigationController?.isNavigationBarHidden = false
        tableView.register(cell: "ProductCell")
        setUpSearch()
        self.bindUI()
        title = viewModel.title
        viewModel.viewDidLoad()
    }
    
    private func setUpSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.placeholder = "Search Product.."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.isActive = true
    }
    
    private func bindUI() {
        viewModel.reloadProducts = self.tableView.reloadData
        viewModel.loader = { [weak self] show in
            show ? self?.showLoadingView() : self?.hideLoadingView()
        }
        viewModel.showError = { [weak self] error in
            self?.showError(error: error)
        }
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        else { return UITableViewCell() }
        cell.setup(viewModel.cellViewModel(at: indexPath.row))
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height {
            viewModel.getProducts()
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
    }
}


extension ProductListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        viewModel.searchProducts(with: text)
    }
}
