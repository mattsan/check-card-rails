Rails.application.routes.draw do
  resource :check_cards, only: %i(show create)
end
