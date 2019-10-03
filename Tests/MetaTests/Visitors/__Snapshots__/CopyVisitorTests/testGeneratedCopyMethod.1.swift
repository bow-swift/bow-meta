extension Article {
    func copy(withTitle title: String? = nil,
			  withSubtitle subtitle: String?? = nil,
			  withState state: PublicationState? = nil,
			  withAuthor author: Author? = nil) -> Article {
        Article(title: title ?? self.title,
			subtitle: subtitle ?? self.subtitle,
			state: state ?? self.state,
			author: author ?? self.author)
    }
}

extension Blog {
    func copy(withArticles articles: [Article]? = nil) -> Blog {
        Blog(articles: articles ?? self.articles)
    }
}

