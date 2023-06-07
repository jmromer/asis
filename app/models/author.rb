# frozen_string_literal: true

# Manuscript Author model
class Author
  include Mongoid::Document

  embedded_in :manuscript

  field :publish_name, type: String

  # The minimum length of a surname to be considered for matching.
  MATCHING_MINIMUM_SURNAME_LENGTH = 2

  # The number of characters of a surname to be accepted as a prefix-match.
  MATCHING_PREFIX_LENGTH = 3

  def last_name_matches?(last_name)
    surname = self.last_name.downcase.strip
    return false if surname.length < MATCHING_MINIMUM_SURNAME_LENGTH

    target_surname = last_name.downcase.strip
    if target_surname.length == MATCHING_PREFIX_LENGTH
      surname.starts_with?(target_surname)
    else
      surname == target_surname
    end
  end

  def display_name
    @display_name ||= name_components.join(' ')
  end

  def last_name
    @last_name ||= name_components.last
  end

  private

  def name_components
    @name_components ||= publish_name.split(',').reverse.map(&:strip)
  end
end
