# frozen_string_literal: true

# Manuscript model
class Manuscript
  include Mongoid::Document

  embeds_many :authors

  field :code, type: String
  field :title, type: String
  field :status, type: String
  field :status_date, type: Date

  # The number of authors to consider as "major" authors.
  MAJOR_AUTHOR_THRESHOLD = 3

  # Return a list of manuscripts matching the given `code` exactly, and where
  # the `last_name` of a major author to an acceptable tolerance level (the
  # conditions for which are defined in Author#last_name_matches?).
  def self.lookup(code:, last_name:)
    return if code.blank? || last_name.blank?

    where(code: code.strip.upcase).select do |manuscript|
      manuscript.authors.first(MAJOR_AUTHOR_THRESHOLD).any? { _1.last_name_matches?(last_name) }
    end
  end
end
