ActiveAdmin.register Message do

  permit_params :content, :post_id, :user_id

  index do
    selectable_column
    id_column
    column "Message of the post", :content
    column "Message Creator" do |message| 
      message.user.name
    end    
    column "Post on which message is made", :post
    column :created_at
    actions
  end

  
  filter :content
  filter :user
  filter :post
  filter :created_at
  filter :updated_at


  form do |f|
    f.inputs 'Message Details' do
      f.input :content, label: "Write your message"
      f.input :post, label: "Select the post for your message", as: :select, collection: Post.all.map { |p| [p.title, p.id] }, include_blank: false
      f.input :user, label: "Select the message creator", as: :select, collection: User.all.map { |u| [u.name, u.id] }, include_blank: false
    end
    f.actions
  end


  show do
    attributes_table do
      row "Message" do |message|
        message.content
      end
      row "Post Title" do |message|
        link_to message.post.title, admin_post_path(message.post)
      end
      row "Message Creator" do |message|
        message.user
      end
      row "Message created at" do |message|
        message.created_at
      end
      row "Message updated at" do |message|
        message.updated_at
      end
    end

    active_admin_comments
  end
  
  
end
