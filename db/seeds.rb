ROLES = ["admin", "premium", "normal"]

def create_user(mail, name, password, username, user_role)
  return unless User.where(email: mail).empty?
  user = User.create!(
      email: mail, 
      name: name,
      password: password,
      user_role: user_role
  )
end

def create_posts
  18.times do |i|
    Post.create!(
      title: Faker::Name.name,
      body: Faker::Lorem.paragraph(sentence_count: 2),
      user: User.all.sample
    )
  end
end

def create_comments
  50.times do |i|
    Comment.create!(
      body: Faker::Lorem.paragraph(sentence_count: 2),
      post: Post.all.sample,
      user: User.all.sample
    )
  end
end

def create_likes
  50.times do |i|
    lk = Like.where(
      post: Post.all.sample,
      user: User.all.sample
    ).first_or_initialize
    lk.is_like = [true, false].sample
    lk.save!
  end
end

ROLES.each do |user_role|
  create_user("waled_#{user_role}@mail.com", "waled_#{user_role}", "123456", "waled_#{user_role}", "#{user_role}")
  create_user("osama_#{user_role}@mail.com", "osama_#{user_role}", "123456", "osama_#{user_role}", "#{user_role}")
  create_user("ahmed_#{user_role}@mail.com", "ahmed_#{user_role}", "123456", "ahmed_#{user_role}", "#{user_role}")
end

create_posts
create_comments
create_likes