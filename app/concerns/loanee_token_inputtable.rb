module LoaneeTokenInputtable
  extend ActiveSupport::Concern
  
  included do
    attr_accessible :loanee_token
    attr_reader :loanee_token
  end
  
  def loanee_token=(ids)
    self.loanee_id = ids
  end
end
