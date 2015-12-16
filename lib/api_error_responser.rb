module ApiErrorResponser

  def invalid_json;                                   render_error(__method__); end
  def invalid_query_string;                           render_error(__method__); end
  def from_address_not_verified;                      render_error(__method__); end
  def invalid_credential;                             render_error(__method__); end
  def authentication_error;                           render_error(__method__); end
  def authorization_not_found;                        render_error(__method__); end
  def session_expired;                                render_error(__method__); end
  def operation_not_permitted;                        render_error(__method__); end
  def login_temporarily_disabled;                     render_error(__method__); end
  def group_not_associable;                           render_error(__method__); end
  def app_not_allowed_to_use_this_api;                render_error(__method__); end
  def app_not_allowed_to_this_user;                   render_error(__method__); end
  def charge_not_belonging_to_customer;               render_error(__method__); end
  def file_storage_limit_exceeded;                    render_error(__method__); end
  def password_expired;                               render_error(__method__); end
  def same_password_not_allowed;                      render_error(__method__); end
  def group_not_found;                                render_error(__method__); end
  def app_not_found;                                  render_error(__method__); end
  def app_not_associated;                             render_error(__method__); end
  def collection_not_found;                           render_error(__method__); end
  def resource_not_found;                             render_error(__method__); end
  def payment_provider_not_found;                     render_error(__method__); end
  def payment_api_key_not_found;                      render_error(__method__); end
  def customer_not_registered;                        render_error(__method__); end
  def feedback_email_not_found;                       render_error(__method__); end
  def non_associated_app_specified;                   render_error(__method__); end
  def email_not_found;                                render_error(__method__); end
  def login_id_already_taken;                         render_error(__method__); end
  def duplicated_key_error;                           render_error(__method__); end
  def card_already_registered;                        render_error(__method__); end
  def too_many_device;                               render_error(__method__); end
  def message_size_limit_exceeded;                    render_error(__method__); end
  def from_field_limit_exceeded;                      render_error(__method__); end
  def too_many_recipient;                             render_error(__method__); end
  def internal_error;                                 render_error(__method__); end
  def validation_error(message = nil);                render_error(__method__, message); end
  def invalid_use_of_mongo_operator(message = nil);   render_error(__method__, message); end

  def conflicting_update current_version
    desc = get_error_desc.assoc __method__.to_s.classify
    render :json => {code:  desc[2], error: desc[0], description: desc[3], currentVersion: current_version}, :status => desc[1]
  end

  def cannot_happen
    render_error('internal_error')
  end


  def render_error type , message = nil
    desc = get_error_desc.assoc type.to_s.classify
    unless message.nil?
      render :json => {code:  desc[2], error: desc[0], description: message}, status: desc[1]
    else
      render :json => {code:  desc[2], error: desc[0], description: desc[3]}, status: desc[1]
    end
  end

  private
  def get_error_desc
    return [
        ['InvalidJson',                   :bad_request,           '400-00', "The request body is not a valid JSON document."],
        ['InvalidQueryString',            :bad_request,           '400-01', "The URL query string has invalid parameter(s)."],
        ['ValidationError',               :bad_request,           '400-02', "(description about errors in request body)"],
        ['InvalidUseOfMongoOperator',     :bad_request,           '400-03', "(description about errors)"],
        ['RoutingError',                  :bad_request,           '400-04', "No action found for the URL."],
        ['FromAddressNotVerified',        :bad_request,           '400-05', "The given sender's address is not yet verified. Please check the 'from' parameter or contact the Dev team for support."],
        ['BadRequest',                    :bad_request,           '400-06', "Unable to understand the request."],
        ['InvalidCredential',             :unauthorized,          '401-00', "The given credential is invalid."],
        ['AuthenticationError',           :unauthorized,          '401-01', "The given email or account or ctn and password are incorrect."],
        ['SessionExpired',                :unauthorized,          '401-02', "The session of given credential has expired."],
        ['AuthorizationNotFound',         :unauthorized,          '401-03', "The authorization key is empty."],
        ['PaymentProviderError',          :payment_required,      '402-00', "(error message returned from the payment provider)"],
        ['PaymentInvalidRequestError',    :payment_required,      '402-01', "(error message returned from the payment provider)"],
        ['PaymentAuthenticationError',    :payment_required,      '402-02', "(error message returned from the payment provider)"],
        ['PaymentCardError',              :payment_required,      '402-03', "(error message returned from the payment provider)"],
        ['OperationNotPermitted',         :forbidden,             '403-00', "The request cannot be processed with the given credential."],
        ['GroupNotAssociable',            :forbidden,             '403-02', "The specified group cannot be associated with the app."],
        ['AppNotAllowedToUseThisApi',     :forbidden,             '403-03', "Only a limited number of apps are allowed to use this API. Please contact the Dev team to enable your app to use this API."],
        ['AppNotAllowedToThisUser',       :forbidden,             '403-04', "The user is not allowed to use this app according to the usage rule settings."],
        ['ChargeNotBelongingToCustomer',  :forbidden,             '403-05', "The given charge does not belong to the customer and thus is not accessible from the user or the group."],
        ['FileStorageLimitExceeded',      :forbidden,             '403-06', "The usage of the file storage volume exceeded the limit of the group."],
        ['PasswordExpired',               :forbidden,             '403-07', "The given password is no longer valid. Please reset your password."],
        ['SamePasswordNotAllowed',        :forbidden,             '403-08', "Resetting to the same password as before is not allowed. Please input a different password."],
        ['GroupNotFound',                 :not_found,             '404-00', "No group matches the given Group ID."],
        ['AppNotFound',                   :not_found,             '404-01', "No app matches the given App ID."],
        ['AppNotAssociated',              :not_found,             '404-02', "The given App ID is not associated with the group."],
        ['CollectionNotFound',            :not_found,             '404-03', "No collection matches the given collection name."],
        ['ResourceNotFound',              :not_found,             '404-04', "The resource does not exist in the database."],
        ['PaymentProviderNotFound',       :not_found,             '404-05', "No payment provider matches the given provider name."],
        ['PaymentApiKeyNotFound',         :not_found,             '404-06', "The payment API key does not exist in the database."],
        ['CustomerNotRegistered',         :not_found,             '404-07', "Customer registration of the user or the group has not yet completed."],
        ['FeedbackEmailNotFound',         :not_found,             '404-08', "The app does not have feedback email which is required by the email API."],
        ['NonAssociatedAppSpecified',     :not_found,             '404-09', "The app ID specified in the request is not found in the list of associated apps of the group."],
        ['EmailNotFound',                 :not_found,             '404-10', "No email matches the given Email ID."],
        ['LoginIdAlreadyTaken',           :conflict,              '409-00', "The given email and/or account and/or ctn is already taken."],
        ['DuplicatedKeyError',            :conflict,              '409-01', "The given ID is already used by existing resource."],
        ['CardAlreadyRegistered',         :conflict,              '409-02', "A credit card of the user is already registered for use in this app."],
        ['ConflictingUpdate',             :conflict,              '409-03', "The document version your request is based on is outdated. Check 'currentVersion' for the content of the current document."],
        ['TooManyDevice',                 :conflict,              '409-04', "The user already has %{ENV['MAX_DEVICES_PER_USER_PER_APP']} devices for the app."],
        ['MessageSizeLimitExceeded',      :conflict,              '409-05', "The message size exceeded 10M."],
        ['FromFieldLimitExceeded',        :conflict,              '409-06', "The from field with senderName exceeded 320bytes."],
        ['TooManyRecipient',              :conflict,              '409-07', "The maximum number of recipients are 50."],
        ['InternalError',                 :internal_server_error, '500-00', "The server encountered an unexpected error."],
        ['FileServerConnectionRefused',   :internal_server_error, '500-10', "The connection to the file server was denied."],
    ]
  end

end
