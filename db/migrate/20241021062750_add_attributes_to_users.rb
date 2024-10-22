class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :skills, :text
    add_column :users, :user_attributes, :json
    add_column :users, :interests, :string
    add_column :users, :languages, :string
    add_column :users, :website, :string
    add_column :users, :social_links, :text
    add_column :users, :company, :string
    add_column :users, :job_title, :string
    add_column :users, :experience_years, :integer
  end
end
