# frozen_string_literal: true

user1 = User.new
user1.email = 'muhammad.affan@devsinc.com'
user1.encrypted_password = '$2a$12$ePQ961uLFdPshrK8ba229ugA.hRkB465we/vRmaFH1tBak5KCuUoO'
user1.name = 'Affan Devsinc'
user1.save!(validate: false)

user2 = User.new
user2.email = 'affanarif74@gmail.com'
user2.encrypted_password = '$2a$12$ePQ961uLFdPshrK8ba229ugA.hRkB465we/vRmaFH1tBak5KCuUoO'
user2.name = 'Affan Arif'
user2.save!(validate: false)

story1 = Story.new
story1.caption = "This is devsinc affan's story"
story1.user = user1
story1.image.attach(
  filename: 'jBiNts3SmPyaRH315BoWE8DE.jpg',
  io: URI.open('https://res.cloudinary.com/instagram-clone-affan/image/upload/v1663584876/jBiNts3SmPyaRH315BoWE8DE.jpg')
)

story1.save!

story2 = Story.new
story2.caption = "This is affan's personal story"
story2.user = user2
story2.image.attach(
  filename: 'AG3RdJv9D16yVor89dZ9M6L6.jpg',
  io: URI.open('https://res.cloudinary.com/instagram-clone-affan/image/upload/v1663583408/AG3RdJv9D16yVor89dZ9M6L6.jpg')
)

story2.save!
