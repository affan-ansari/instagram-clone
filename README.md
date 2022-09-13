# Instagram Clone

Instagram clone developed using Ruby on Rails

## **Getting Started**

---

### **Requirements**

- Ruby version **2.7.1**
- Rails version **5.2.8.1**
- Bundler version **2.4.1**
- Postgres version **14.5**

### **Installing gems**

`bundle install`

### **Getting Migrations up**

`rails db:migrate`

### **Starting Server**

`rails s`

# **Features**

## **Users**

- User can sign up and sign in
- User can have a display photo

## **Posts**

- User can create a post
- User can edit and delete their posts
- Post can have multiple images **(Max 10)**
- User can like/unlike a post

## **Stories**

- User can add stories
- User can delete their stories
- Story will remain visible for 24 hours unless deleted
- User can view other user's stories

## **Comments**

- Post can have many comments
- User can comment on their posts and other posts
- User can edit and delete their comments
- Post owner can delete comments on their posts

## **Followers**

- Users can follow each other
- Posts of followed users will be shown on feed
- User can set their profile private or public
- Posts and stories of private users cannot be viewed

## **Search**

- User can search for other users
- Users can view other user's profiles
