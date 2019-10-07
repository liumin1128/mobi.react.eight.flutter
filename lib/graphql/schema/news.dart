String newsListSchema = """
  query NewsList(\$first: Int, \$skip: Int) {
    list: NewsList(first: \$first, skip: \$skip) {
      __typename
      _id
      title
      createdAt
      # content
      appCode
      appName
       #html
      photos
      cover
      tags
    }
  }
""";

String newsDetailSchema = """
  query NewsDetail(\$_id: String!) {
    data: NewsDetail(_id: \$_id) {
      __typename
      _id
      title
      createdAt
      content
      appCode
      appName
      showHtml
      html
      photos
      cover
      tags
      url
    }
  }
""";
