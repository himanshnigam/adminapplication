ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :name, :username, :profile_image


  index do
    selectable_column
    id_column
    column "Email ID of User", :email
    column "Name of User", :name
    column "Username", :username
    column "User created at", :created_at
    column "Details updated at", :updated_at
    column "Profile Image" do |user|
      if user.profile_image.attached?
        image_tag url_for(user.profile_image), size: "100x100"
      else
        "No Image"
      end
    end
    actions
  end


  filter :email
  filter :name
  filter :username
  filter :created_at


  form do |f|
    f.inputs "User Details" do
      f.input :email, label: "Enter you email address"
      f.input :name, label: "Enter you name"
      f.input :username, label: "Enter the username"
      f.input :password, label: "Make your unique password"
      f.input :password_confirmation, label: "Confirm password"
      f.input :profile_image, as: :file, label: "Upload your profile image"
    end
    f.actions
  end


  show do
    attributes_table do
      row  "User ID" do |user|
        user.id
      end
      row "User Email ID" do |user|
        user.email
      end
      row "Fullname of the user" do |user|
        user.name
      end
      row "Username" do |user|
        user.username
      end
      row "Account Created at" do |user|
        user.created_at
      end
      row "Last updated at" do |user|
        user.updated_at
      end
      row "Profile Image" do |user|
        if user.profile_image.attached?
          image_tag url_for(user.profile_image), size: "200x200"
        else
          "No Image"
        end
      end
    end

  
    panel "Posts by this User" do
      table_for user.posts do
        column "Post Title" do |post|
          link_to post.title, admin_post_path(post)
        end
        column "Post Description", :description
        column "Post Created at", :created_at
        column "Post Updated at", :updated_at
        column "Images" do |post|
          if post.images.attached?
            post.images.map do |image|
              image_tag url_for(image), size: "85x85"
            end.join(' ').html_safe
          else
            "No Images"
          end
        end
      end
    end

   
    panel "Messages by this User" do
      table_for user.messages do
        column "Body of message" do |message|
          link_to message.content, admin_message_path(message)
        end
        column "Post Title" do |message|
          link_to message.post.title, admin_post_path(message.post)
        end
        column "Post Creator" do |message|
          link_to message.post.user.name, admin_user_path(message.post.user)
        end
        column :created_at
      end
    end

    active_admin_comments
  end
end
