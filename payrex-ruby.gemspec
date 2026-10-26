Gem::Specification.new do |s|
  s.name        = "payrex-ruby"
  s.version     = "1.7.9"
  s.summary     = "PayRex Ruby"
  s.description = "PayRex Ruby Library"
  s.author      = "PayRex"
  s.email       = "support@payrex.com"
  s.files       = [
    "lib/api_resource.rb",
    "lib/client.rb",
    "lib/config.rb",
    "lib/http_client.rb",
    "lib/payrex_error.rb",
    "lib/payrex-ruby.rb",
    "lib/entities/checkout_session.rb",
    "lib/entities/customer_session.rb",
    "lib/entities/event.rb",
    "lib/entities/deleted.rb",
    "lib/entities/listing.rb",
    "lib/entities/customer.rb",
    "lib/entities/billing_statement.rb",
    "lib/entities/billing_statement_line_item.rb",
    "lib/entities/setup_intent.rb",
    "lib/entities/payment_intent.rb",
    "lib/entities/payment_method.rb",
    "lib/entities/payment.rb",
    "lib/entities/payout.rb",
    "lib/entities/payout_transaction.rb",
    "lib/entities/refund.rb",
    "lib/entities/webhook.rb",
    "lib/errors/base_error.rb",
    "lib/errors/authentication_invalid_error.rb",
    "lib/errors/request_invalid_error.rb",
    "lib/errors/resource_not_found_error.rb",
    "lib/errors/signature_invalid_error.rb",
    "lib/errors/value_unexpected_error.rb",
    "lib/helpers/parameter.rb",
    "lib/services/base_service.rb",
    "lib/services/checkout_sessions_service.rb",
    "lib/services/customer_sessions_service.rb",
    "lib/services/payment_intents_service.rb",
    "lib/services/setup_intents_service.rb",
    "lib/services/payments_service.rb",
    "lib/services/payouts_service.rb",
    "lib/services/customers_service.rb",
    "lib/services/billing_statements_service.rb",
    "lib/services/billing_statement_line_items_service.rb",
    "lib/services/refunds_service.rb",
    "lib/services/webhooks_service.rb",
    "lib/services/service_factory.rb"
  ]
  s.homepage    = "https://www.payrexhq.com"
  s.license     = "MIT"
end
