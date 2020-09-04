class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: get_current_user
    }
    result = GraphqlTrialSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    # set_authentication_cookie(result["data"]["login"]["token"]) if result["data"]["login"]
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def set_authentication_cookie(token)
    cookies[:_graphql_token] = token
  end

  def get_current_user
    if request.headers['Authorization']
      type, token = request.headers['Authorization'].split
      decoded_token = JWT.decode token, ENV['HMAC_SECRET'], true, { algorithm: 'HS256' }
      User.find(decoded_token.first["id"])
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: :internal_server_error
  end
end
