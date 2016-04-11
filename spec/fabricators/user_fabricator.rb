Fabricator :user do
  email 'user@gmail.com'
  password 'rootroot'
  role 'User'
end

Fabricator :administrator, from: :user do
  email 'admin@gmail.com'
  password 'rootroot'
  role 'Administrator'
end

Fabricator :guest, from: :user do
  email 'guest@gmail.com'
  password 'rootroot'
  role 'Guest'
end
