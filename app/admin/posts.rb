ActiveAdmin.register Post do

  permit_params :title, :description, :category_id, :user_id, images: []

  index do
    selectable_column
    id_column
    column "Title of the Post", :title
    column "Description of the Post", :description
    column "Post Category", :category
    column "Post Creator", :user
    column "Post created at", :created_at
    column "Images" do |post|
      if post.images.attached?
        post.images.map do |image|
          image_tag url_for(image), size: "100x100"
        end.join(' ').html_safe
      else
        "No Images"
      end
    end
    actions
  end


  filter :user
  filter :title
  filter :description
  filter :category
  filter :created_at


  form do |f|
    f.inputs 'Post Details' do
      f.input :title, label: "Title of the Post"
      f.input :description, label: "Add post description"
      f.input :category, label: "Select the category to which the post belongs", include_blank: false
      f.input :user,label: "Select Post Creator", as: :select, collection: User.all.map { |u| [u.email, u.id] }, include_blank: false
      f.input :images, lable: "Upload images/videos", as: :file, input_html: { multiple: true }
    end
    f.actions
  end


  show do
    attributes_table do
      row "Post Title" do |post|
        post.title
      end
      row "Description of the post" do |post|
        post.description
      end
      row "Category of the post" do |post|
        post.category
      end
      row "Post Creator" do |post|
        post.user
      end
      row "Post created at" do |post|
        post.created_at
      end
      row "Images" do |post|
        if post.images.attached?
          post.images.map do |image|
            image_tag url_for(image), size: "200x200"
          end.join(' ').html_safe
        else
          "No Images"
        end
      end
    end

    panel "Messages on this Post" do
      table_for post.messages do
        column "Message" do |message|
          link_to message.content, admin_message_path(message)
        end
        column "Message By" do |message|
          link_to message.user.name, admin_user_path(message.user)
        end
        column "Message creation details", :created_at
        column "Last updated details", :updated_at
      end
    end
    
    active_admin_comments
  end

  
end
