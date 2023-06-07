# frozen_string_literal: true

module Admin
  # List manuscripts
  class ManuscriptsController < ApplicationController
    def index
      @manuscripts = Manuscript.all
    end
  end
end
