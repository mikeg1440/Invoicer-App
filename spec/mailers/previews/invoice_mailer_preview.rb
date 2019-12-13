# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview

  def simple_message
    InvoiceMailer.simple_message('yoda@clrmail.com', Invoice.first)
  end

end
