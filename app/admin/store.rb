ActiveAdmin.register Store do
  permit_params(
    :details,
    :phone_number,
    :image,
    :email,
    :slug,
    :pilot,
    :user_token,
    :city,
    :country,
    :full_name
    # only on a very specific and verified case
    # you should change this param otherwise is dangerous.
    # :instagram_account,

  )

  hstore_editor

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
# specify the type does not necessarily
  form do |f|
    f.inputs do
      f.input :phone_number
      f.input :image
      f.input :email
      f.input :slug
      f.input :user_token
      f.input :city
      f.input :details, as: :hstore
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug!
  end



end
