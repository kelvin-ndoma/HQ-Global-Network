class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :photo
      t.text :bio
      t.string :status
      t.integer :role
      
      # New attributes to add
      t.string :city           # City of the user
      t.string :country        # Country of the user
      t.text :skills           # Skills of the user
      t.json :attributes       # Flexible user attributes
      t.string :interests      # Interests of the user
      t.string :languages      # Languages spoken by the user
      t.string :website        # User's personal website
      t.text :social_links, default: {}  # Using text to store JSON
      t.string :company        # Company where the user works
      t.string :job_title      # User's job title
      t.integer :experience_years # Years of experience

      t.timestamps
    end
  end
end
