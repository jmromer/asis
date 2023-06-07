# frozen_string_literal: true

require 'rails_helper'

describe Manuscript do
  let(:valid_attributes) do
    { code: 'AA1001', title: 'some title', status: 'NEW', status_date: Date.today }
  end

  describe 'persistence' do
    it 'creates with valid attributes' do
      Manuscript.create!(valid_attributes)
    end
  end

  describe '#lookup' do
    before do
      Manuscript.create!(valid_attributes).tap do |manuscript|
        manuscript.authors << Author.new(publish_name: 'Smith,Joe')
        manuscript.authors << Author.new(publish_name: 'Li,Wen')
        manuscript.authors << Author.new(publish_name: 'Jones,Ben')
        manuscript.authors << Author.new(publish_name: 'Miller,Mike')
        manuscript.authors << Author.new(publish_name: 'Herman,Friedrich')
      end
    end

    after { Manuscript.delete_all }

    it 'returns nil given a blank code or last_name' do
      expect(Manuscript.lookup(code: '', last_name: 'Li')).to be_nil
      expect(Manuscript.lookup(code: 'AA1001', last_name: '')).to be_nil
    end

    it 'returns an empty result set if no manuscripts match' do
      expect(Manuscript.lookup(code: 'AA1002', last_name: 'Li')).to be_empty
      expect(Manuscript.lookup(code: 'AA1008', last_name: 'Li')).to be_empty
    end

    it 'returns matching manuscripts with a matching major author, by last_name' do
      results = Manuscript.lookup(code: 'AA1001', last_name: 'Smith')
      expect(results.length).to eq(1)
      expect(results.first.code).to eq('AA1001')

      results = Manuscript.lookup(code: 'AA1001', last_name: 'Li')
      expect(results.length).to eq(1)
      expect(results.first.code).to eq('AA1001')

      results = Manuscript.lookup(code: 'AA1001', last_name: 'Jones')
      expect(results.length).to eq(1)
      expect(results.first.code).to eq('AA1001')
    end

    it 'retuns an empty result set if given a matching minor author' do
      expect(Manuscript.lookup(code: 'AA1001', last_name: 'Miller')).to be_empty
      expect(Manuscript.lookup(code: 'AA1001', last_name: 'Herman')).to be_empty
    end
  end
end
