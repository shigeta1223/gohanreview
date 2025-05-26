class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  # ゲストログイン用
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  # ✅ 退会していないユーザーだけを取得するスコープ
  scope :active, -> { where(deleted_at: nil) }

  # ✅ Devise：論理削除されたユーザーをログイン不能にする
  def active_for_authentication?
    super && deleted_at.nil?
  end

  # ✅ Devise：ログインできない理由のカスタムメッセージ（任意）
  def inactive_message
    deleted_at.nil? ? super : :deleted_account
  end
end

