# frozen_string_literal: true

Manuscript.create(code: 'AA1001', title: 'My awesome paper', status: 'WITH_AUTHOR',
                  status_date: Date.parse('01Jan2014')) do |m|
  m.authors << Author.new(publish_name: 'Smith,Joe')
  m.authors << Author.new(publish_name: 'Li,Wen')
  m.authors << Author.new(publish_name: 'Jones,Ben')
end
