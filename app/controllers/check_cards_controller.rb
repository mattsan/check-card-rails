class CheckCardsController < ApplicationController
  def create
    respond_to do |format|
      format.pdf do
        send_data CheckCard.render(params), filename: "check_card.pdf", type: "application/pdf", disposition: 'inline'
      end
    end
  end
end
