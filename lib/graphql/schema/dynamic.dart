String dynamicListSchema = """
  query DynamicList(\$first: Int, \$skip: Int, \$topic: String, \$user: String) {
    list: dynamics(first: \$first, skip: \$skip, topic: \$topic, user: \$user) {
      __typename
      createdAt
      _id
      content
      pictures
      zanCount
      zanStatus
      commentCount
      topics {
        _id
        title
        number
      }
      user {
        nickname
        avatarUrl
      }
    }
    meta: _dynamicsMeta {
      count
    }
  }
""";
