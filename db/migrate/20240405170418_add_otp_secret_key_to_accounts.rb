# frozen_string_literal: true

class AddOtpSecretKeyToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :otp_secret_key, :string
  end
end
