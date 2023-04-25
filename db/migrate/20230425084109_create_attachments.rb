class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :file
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
