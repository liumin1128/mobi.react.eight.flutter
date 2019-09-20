String bxgifListSchema = """
  query bxgifList(\$skip: Int) {
    list: bxgifList(skip: \$skip) {
      __typename
      _id
      title
      cover
      comment
      createdAt
      total
      height
    }
  }
""";

String bxgifDetailSchema = """
  query bxgifDetail(\$_id: String!) {
    detail: bxgifDetail(_id: \$_id) {
      __typename
      _id
      title
      list {
        url
        title
        width
        height
      }
    }
  }
""";
