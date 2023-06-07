# frozen_string_literal: true

require 'rails_helper'

describe Author do
  describe '#last_name is derived from first component of comma separated :publish_name' do
    subject(:author) { Author.new }

    example 'Smith from Smith,Joe' do
      author.publish_name = 'Smith,Joe'
      expect(author.last_name).to eql('Smith')
    end

    example 'Smith from Smith,Joe,M' do
      author.publish_name = 'Smith,Joe,M'
      expect(author.last_name).to eql('Smith')
    end

    it 'strips leading/trailing white-space' do
      author.publish_name = " \t\nSmith , Joe"
      expect(author.last_name).to eq('Smith')
    end

    it 'keeps embedded white-space' do
      author.publish_name = 'Smith Jr.,Joe'
      expect(author.last_name).to eq('Smith Jr.')
    end

    describe '#last_name_matches?' do
      it 'ignores surrounding whitespace and case' do
        author = Author.new(publish_name: ' Smith,Joe')
        expect(author.last_name_matches?('smith')).to eq(true)
      end

      it 'returns false if author name is 1 char long' do
        author = Author.new(publish_name: 'X,Joe')
        expect(author.last_name_matches?('X')).to eq(false)
      end

      it 'returns true given an exact match to a 2-char author name' do
        author = Author.new(publish_name: 'Li,Joe')
        expect(author.last_name_matches?('li')).to eq(true)
        expect(author.last_name_matches?('l')).to eq(false)
      end

      it 'returns true given a 3-char prefix of the author name' do
        author = Author.new(publish_name: 'Jones,Joe')
        expect(author.last_name_matches?('jon')).to eq(true)
      end

      it 'returns false given a matching prefix less than 3-chars long' do
        author = Author.new(publish_name: 'Jones,Joe')
        expect(author.last_name_matches?('jo')).to eq(false)
      end

      it 'returns false if the given string has any mismatches beyond the third char' do
        author = Author.new(publish_name: 'Smith,Joe')
        expect(author.last_name_matches?('smio')).to eq(false)
      end

      it 'returns true if the given string has no mismatches beyond the third char' do
        author = Author.new(publish_name: ' Smith,Joe')
        expect(author.last_name_matches?(' smith ')).to eq(true)
      end
    end
  end
end
