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

String dynamicDetailSchema = """
query DynamicDetail(\$_id: String!) {
  data: dynamic(_id: \$_id) {
    __typename
    _id
    content
    pictures
    iframe
    createdAt
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
      sign
    }
  }
}
""";
