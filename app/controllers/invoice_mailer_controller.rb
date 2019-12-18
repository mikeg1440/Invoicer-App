
class InvoiceMailerController < ApplicationController
  before_action :authenticate_user!


  def send_invoice
    @invoice = Invoice.find_by(id: params[:id])
    @invoice.status = 'sent'
    @invoice.save
    if @invoice
      # simple_message(@invoice.account.client.email)
      InvoiceMailer.send_invoice_to_client(@invoice.account.client.email, @invoice).deliver_now
    else
      flash[:alert] = "Failed to find invoice to send"
      redirect_to invoices_path
    end
  end

end
