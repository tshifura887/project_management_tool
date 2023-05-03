class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.references :task, null: false, foreign_key: true
      t.binary :file

      t.timestamps
    end
  end
end
