public protocol ShoppingServiceProtocol {
    func searchProducts(with query: String, page: Int, _ completion: @escaping ((Result<SearchResponse, Error>) -> Void))
}
