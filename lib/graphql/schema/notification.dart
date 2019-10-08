String notificationListSchema = """
  query NotificationList(\$first: Int, \$skip: Int, \$unread: Boolean, \$type: String) {
    list: notifications(first: \$first, skip: \$skip, unread: \$unread, type: \$type) {
      __typename
      createdAt
      _id
      type
      user {
        _id
        nickname
        avatarUrl
      }
      actionor {
        _id
        nickname
        avatarUrl
        followStatus
      }
      
      actionShowText
      userShowText
      actionorShowText
    }
    meta: _notificationsMeta {
      count
    }
  }
""";
