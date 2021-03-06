class ConsequenceGuide < ApplicationRecord

  belongs_to :organization, optional: true
  belongs_to :project, optional: true
  has_many :consequences, dependent: :destroy

  attr_accessor :default_source

  def clone_from(source)
    return if source == self
    consequences.destroy_all
    if source.is_a?(ConsequenceGuide)
      consequences = source.consequences
    else
      consequences = source.consequence_guide&.consequences
    end
    consequences.each do |consequence|
      Consequence.create(
        consequence_guide_id: id,
        severity: consequence.severity,
        label: consequence.label,
        action: consequence.action,
        consequence: consequence.consequence
      )
    end
  end

end
