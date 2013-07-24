class IncedentAttach < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :attach

  attr_accessible :attach_id, :incedent_id, :incedent, :attach

  before_destroy { |record| Attach.destroy_all "id = #{record.attach_id}" }

  accepts_nested_attributes_for :incedent, :attach

end
