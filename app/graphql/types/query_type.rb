module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    ## GET ALL
    field :fetch_users, resolver: Queries::All::FetchUsers, description: "Fetching All Users"
    field :fetch_posts, resolver: Queries::All::FetchPosts, description: "Fetching All Posts"
    field :fetch_comments, resolver: Queries::All::FetchComments, description: "Fetching All Comments"
    field :fetch_likes, resolver: Queries::All::FetchLikes, description: "Fetching All Likes"
    field :fetch_follows, resolver: Queries::All::FetchFollows, description: "Fetching All Follows"

    ## GET ONE
    field :fetch_user, resolver: Queries::One::FetchUser, description: "Fetching One User"
    field :fetch_post, resolver: Queries::One::FetchPost, description: "Fetching One Post"
    field :fetch_comment, resolver: Queries::One::FetchComment, description: "Fetching One Comment"
    field :fetch_like, resolver: Queries::One::FetchLike, description: "Fetching One Like"
    field :fetch_follow, resolver: Queries::One::FetchFollow, description: "Fetching One Follow"
  end
end
