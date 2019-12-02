
// # User
// User has many invoices
// User has many products through invoices
// User has many clients, through invoices

// # Client
// Client has many invoices

// # Invoice
// Invoice belongs to user
// Invoice belongs to client
// Invoice has many products

// # Product
// belongs to invoice


table user{
  id integer [pk]
  username string [not null]
  email string [not null]
  password_digest string
  admin boolean [default: false]
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
  quantity integer [default: 1]
  price integer [default: 0]
  invoice_id integer
}

table account {
  id integer
  user_id integer
  client_id integer
}


Ref: product.invoice_id < invoice.id
Ref: account.user_id > user.id
Ref: account.client_id > client.id
Ref: account.id < invoice.account_id


// Relationships

// user has many accounts
// user has many invoices through accounts
// user has many products, through invoices

// client has many accounts
// client has many invoices, through accounts

// account belongs to user
// account belongs to client
// account has many invoices
// account has many products through invoices

// invoice belongs to account
// invoice has many products

// product belongs to invoice

// OR MAYBE

// invoice has many invoice_products
// invoice has many products, through invoice_products

// product belongs to invoice_products  

// table site{
//   id integer
//   name string
//   url string
// }

// table login{
//   id integer
//   site_id integer
//   username string
//   password string
//   email email
// }



// Ref: "site"."id" < "login"."site_id"

// table user{
//   id integer
//   name string
//   username string
//   password_digest string
// }

// table user_sites{
//   id integer
//   user_id integer
//   site_id integer
// }

// Ref: "user_sites"."user_id" < "user"."id"

// Ref: "user_sites"."site_id" < "site"."id"
