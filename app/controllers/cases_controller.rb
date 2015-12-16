class CasesController < ApplicationController
  def index
    @cases = Case.published
  end
end
