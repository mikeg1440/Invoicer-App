
table user{
  id integer [pk]
  username string [not null]
  email string [not null]
  password_digest string
  admin boolean [default: false]
  is_client boolean [default: false]
}

table client{
  id integer [pk]
  name string [not null]
  business_name string
  email string [not null]
  phone_number string
  address string
}

table invoice{
  id integer [pk]
  created_on datetime
  due_on datetime
  amount_due integer
  creation_date integger
  account_id integer
}

table product{
  id integer [pk]
  name string [not null]
  description text
  price integer [default: 0]
}

table account {
  id integer
  name string
  user_id integer
  client_id integer
}

table invoice_products{
  id integer [pk]
  product_id integer
  invoice_id integer
  quantity integer
  total_cost integer

}


Ref: product.id < invoice_products.product_id
Ref: invoice.id < invoice_products.invoice_id
Ref: account.user_id > user.id
Ref: account.client_id > client.id
Ref: account.id < invoice.account_id
