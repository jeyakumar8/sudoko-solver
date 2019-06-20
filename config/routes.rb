Rails.application.routes.draw do
	# resources :game do
	# 	get 'mine', to: 'game#mine'
	# end
	get 'mine', to: 'game#mine'
	get 'newgame', to: 'game#new_game'
	post 'calculate', to: 'game#calculate'
	get 'mine', to: 'game#mine'
	get 'incorrect', to: 'game#incorrect'
end
