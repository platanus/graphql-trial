class GraphqlTrialSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  use BatchLoader::GraphQL

  # def self.object_from_id(node_id, ctx)
  #   binding.pry
  # end
end
