class CreateTokenInvalids < ActiveRecord::Migration[5.1]
  def change
    create_table :token_invalids do |t|
      t.string :token

      t.timestamps
    end
  end
end
