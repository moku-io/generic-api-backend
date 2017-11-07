ActiveAdmin.register User do
  menu priority: 3

  controller do
    # def create
    #   params[:user][:uid] = params[:user][:email]
    #   params[:user][:provider] = 'email'
    #   super
    # end

    def update
      # params[:user][:uid] = params[:user][:email]
      if params[:user][:password].blank?
        # Ignore password change if no password is changed in AA.
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end

  permit_params :email, :password, :password_confirmation

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    attributes_table :email, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at
  end

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
