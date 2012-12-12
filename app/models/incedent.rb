# encoding: utf-8
class Incedent < ActiveRecord::Base
  audit(:create)  { |model, user, action| "Жалоба \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Жалоба \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил жалобу \"#{model.name}\"" }

  belongs_to :initiator, class_name: 'User', foreign_key: "initiator_id"
  belongs_to :status
  belongs_to :priority
  belongs_to :type
  
  validates :name, :description, presence: true

  has_many :incedent_tags, dependent: :destroy
  has_many :tags, through: :incedent_tags, dependent: :destroy

  attr_accessible :description, :name, :tags, :tag_ids, :initiator_id, :priority_id, :type_id, :status_id


  def self.incedents_by_tag(tag)
    where("id in (select incedent_id from incedent_tags where tag_id = #{tag.id})")
  end

end
