class Review < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :comments, dependent: :destroy


  # 仮の仮想属性 tag_list（フォーム用）
  attr_accessor :tag_list

  # タグの保存/表示用
  def tag_list
    tags.pluck(:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(',').map(&:strip).uniq.map do |n|
      Tag.find_or_create_by(name: n)
    end
  end
end
