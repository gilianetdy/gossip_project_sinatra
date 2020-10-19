require 'bundler'
Bundler.require

	require 'gossip'	

class ApplicationController < Sinatra::Base #on définit une classe AC héritant des fonctionnalités de sinatra
	#attr_accessor :author, :content 


 get '/' do # quand ler serveur rencontre une requete "/" renvoie à l'index et qui affiche tous les gossips
  erb :index, locals: {gossips: Gossip.all}		
end

 get '/gossips/new/' do #requete gossip/new renvoie à la page new_gossip
 	erb :new_gossip
 end

get '/gossips/:id' do # pareil mais id. On passe id dans params pour qu'il se modifie dans l'url dans la page show.erb 
	erb :show
end

get '/gossips/:id/edit/' do # en théorie pareil qu'en haut pour id mais pour la page d'édition
	erb :edit
end


post '/gossips/new/' do # requête post : à travers un formulaire on envoie deux données, le nom d'auteur et le contenu du message
	Gossip.new(params["gossip_author"], params["gossip_content"]).save # en créant un nouveau gossip avec ses paramètres, on applique la méthode
	redirect '/'  																										 # save 
  end

post '/gossips/:id/edit/' do
	Gossip.update(params["id"], params["gossip_new_author"], params["gossip_new_content"])
	puts "Edited Hash params : #{params}"
	puts "Edited gossip_new_author : #{params["gossip_new_author"]}"
	puts "Edited gossip_new_content :#{params["gossip_new_content"]}"
  puts "ID :#{params["id"]}"

  redirect '/'
end 

end

