String newsSchema = """
query NewsList(\$first: Int, \$skip: Int) {
  list: NewsList(first: \$first, skip: \$skip) {
    __typename
    _id
    title
    createdAt
    content
    appCode
    appName
    html
    photos
    cover
    tags
  }
}
""";