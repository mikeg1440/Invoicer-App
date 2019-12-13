class InvoiceMailer < ApplicationMailer


  def send_invoice_to_client(recipient, invoice)
    @invoice = invoice
    mail( :to => recipient, :subject => 'You have recieved a invoice created by InvoicerApp' )
  end

end
