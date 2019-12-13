require "rails_helper"

RSpec.describe InvoiceMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  def simple_message_preview
    InvoiceMailer.simple_message("yoda@clrmail.com")
  end
end
