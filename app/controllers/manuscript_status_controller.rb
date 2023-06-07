# frozen_string_literal: true

# Render the Manuscript Status query UI
class ManuscriptStatusController < ApplicationController
  def search
    @manuscripts = Manuscript.lookup(code: params[:code], last_name: params[:last_name])
  end
end
