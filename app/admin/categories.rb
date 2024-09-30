ActiveAdmin.register Category do

  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  form do |f|
    f.inputs 'Category Details' do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end

    panel "Posts in this Category" do

      table_for category.posts do

        column "Post Title" do |post|
          link_to post.title, admin_post_path(post)
        end

        column "Post Description", :description

        column "Created By" do |post|
          link_to post.user.email, admin_user_path(post.user)
        end

        column "Post Created At", :created_at
        
        column "User Created At" do |post|
          post.user.created_at
        end
      end
    end

    active_admin_comments
  end
  
end
