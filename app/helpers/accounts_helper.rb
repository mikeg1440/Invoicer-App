module AccountsHelper

  def account_info(account)
    "#{account.name} - #{account.client.name} -> #{account.client.business_name}"
  end
end
