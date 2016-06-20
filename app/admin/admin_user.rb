ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  controller do
    def create
      params[:user][:uid] = params[:user][:email]
      params[:user][:provider] = 'email'
      super
    end

    def update
      params[:user][:uid] = params[:user][:email]
      if params[:user][:password].blank?
        # Ignore password change if no password is changed in AA.
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
