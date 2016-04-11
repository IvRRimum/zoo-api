User.create(email: 'trychatch@awesome.com', password: 'rootroot', confirmed_at: Time.now, role: 'Administrator')
User.create(email: 'outdream1337@gmail.com', password: 'rootroot', confirmed_at: Time.now, role: 'User')
User.create(email: 'absolute@gmail.com', password: 'rootroot', confirmed_at: Time.now, role: 'Guest')

Post.create(title: 'This is a test post!', body: 'Body is for body people.', user_id: User.first.id)

Note.create(text: 'I am a note for the first post!', post: Post.first)
