# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ArticleBookmark.destroy_all
TopicArticle.destroy_all
Article.destroy_all
Category.destroy_all
Source.destroy_all
Journalist.destroy_all
Topic.destroy_all
User.destroy_all

puts("Creating Users")
hedgy = User.new(email: 'hedgy@hedgenews.eu', password: 'coucou', admin: true)
hedgy.save!
User.create!(email: 'search@hedgenews.eu', password: 'coucou', admin: true)
User.create!(email: 'raphaelle.coudin@gmail.com', password: 'coucou', admin: true)
User.create!(email: 'julie.moiton@bluewin.ch', password: 'coucou', admin: true)
User.create!(email: 'guillaume.cabanel@gmail.com', password: 'coucou', admin: true)
User.create!(email: 'isauretroesch@gmail.com', password: 'coucou', admin: true)
# Topics TO DO : add most_used_words
# puts("Creating Topics")
# brexit = Topic.create!(name: "Brexit",
#                        presentation: "L'opposition à l'intégration européenne est présente au Royaume-Uni dès les premiers moments de l'intégration à la Communauté économique européenne (CEE) au début des années 1970. Cette question au sein de la société britannique donne lieu à deux différents référendums : un premier en 1975, où les Britanniques décident de se maintenir dans la Communauté économique européenne (CEE), et un second en 2016, au cours duquel les Britanniques décident de quitter l'Union européenne avec 51,9 % des voix3 exprimées.",
#                        image_url: "Brexit.jpg",
#                        number_sources: "23 Articles 3 Sources",
#                        logos: "logo/LePoint.jpg logo/Figaro.png logo/L'Express.png")

# cop22 = Topic.create!(name: "COP22",
#                       presentation: "La Conférence de Marrakech est une conférence sur le réchauffement climatique qui a lieu à Marrakech du 7 au 18 novembre 20161. Elle est la 22e conférence des parties (COP22) de la Convention-cadre des Nations unies sur les changements climatiques2. 196 États sont attendus3.",
#                       image_url: "cop22.jpg",
#                       number_sources: "15 Articles 4 Sources",
#                       logos: "logo/LaTribune.jpg logo/Figaro.png logo/Libération.png logo/Marianne.png")

# election = Topic.create!(name: "Park Geun-hye",
#                         presentation: "Ancienne présidente du premier parti d'opposition, le Grand parti national (GPN, conservateur), elle est la fille de l'ancien dictateur militaire Park Chung-hee, qui dirigea la Corée du Sud entre 1961 et 1979. De 1998 à 2012, elle est députée à l'Assemblée nationale sud-coréenne. Elle est élue présidente de la République en décembre 2012 et prend ses fonctions le 25 février 2013, devenant ainsi la première femme chef de l'État sud-coréen. En novembre 2016, des centaines de milliers de ses compatriotes défilent dans les rues pour demander sa destitution, à la suite d'un scandale de corruption, la considérant comme étant sous l'influence de sa confidente Choi Soon-Sil. Ses pouvoirs sont suspendus par le Parlement le 9 décembre 20161.",
#                         image_url: "presidente-Park-Geun.jpg",
#                         number_sources: "18 Articles 2 Sources",
#                         logos: "logo/L'Humanité.png logo/Les-Echos.png")


# Journalists
puts("Creating Journalists")
isaure = Journalist.create!(first_name: "Isaure",
                            last_name:"Troesch",
                            presentation: "I just finished my studies, and I decided to start the wagon in order to complete my CV. I think it is important to know the digital and to get into for the futur.")
julie = Journalist.create!(first_name: "Julie",
                           last_name:"Moiton",
                           presentation: "I just obtained a Bachelor of Business & Management. I want to learn to code in order to gain technical skills.")
guillaume = Journalist.create!(first_name: "Guillaume",
                               last_name:"Cabanel",
                               presentation: "I was in sustainable development for construction as an engineer for 6 years. I would like to change my of life by moving to Nantes, learning to code and find a job here.")
raph = Journalist.create!(first_name: "Raphaëlle",
                          last_name:"Coudin",
                          presentation: "After graduating from a business school -ESCP Europe- I worked one year as an Account Manager in WayzUp, a carsharing app to commute between home and work. Today, I want to learn to code to become a product manager.")

# Sources. TO DO : add logo_url
puts("Creating Sources")
guardian = Source.create!(name: "The Guardian",
                          presentation: "The Guardian is a National British daily newspaper, known until 1959 as the Manchester Guardian. Along with its sister papers The Observer and The Guardian Weekly, The Guardian is part of the Guardian Media Group, owned by The Scott Trust Limited. The Trust was created in 1936 'to secure the financial and editorial independence of The Guardian in perpetuity and to safeguard the journalistic freedom and liberal values of The Guardian free from commercial or political interference.'",
                          orientation: "Centre-left")
nytimes = Source.create!(name: "The New York Times",
                         presentation: "The New York Times (sometimes abbreviated to NYT) is an American daily newspaper, founded and continuously published in New York City since September 18, 1851, by The New York Times Company. The New York Times has won 117 Pulitzer Prizes, more than any other news organization. The paper's print version has the second-largest circulation, behind The Wall Street Journal, and the largest circulation among the metropolitan newspapers in the United States of America.",
                         orientation: "Liberal")
bbc = Source.create!(name: "BBC",
                     presentation: "The British Broadcasting Corporation (BBC) is a British public service broadcaster. It is headquartered at Broadcasting House in London, and is the world's oldest national broadcasting organisation and the largest broadcaster in the world by number of employees, with over 20,950 staff in total, of whom 16,672 are in public sector broadcasting; including part-time, flexible as well as fixed contract staff, the total number is 35,402.",
                     orientation: "Neutral")
financialtimes = Source.create!(name: "The Financial Times",
                                presentation: "The Financial Times (FT) is an English-language international daily newspaper with a special emphasis on business and economic news. The paper, published and owned by Nikkei in London, was founded in 1888 by James Sheridan and Horatio Bottomley, and merged in 1945 with its closest rival, the Financial News (which had been founded in 1884).",
                                orientation: "Liberal")

          # "l'express":    233,
          # "la croix":     1142,
          # "la tribune":   1174,
          # "le figaro":    641,
          # "le monde":     675,
          # "le parisien":  642,
          # "le point":     1192,
          # "les échos":    684,
          # "libération":   251,
          # "marianne":     1234,
          # "mediapart":    1243,
          # "valeurs actuelles": 1615

# presse française :
# manque aylien_id pour l'humanite, alternatives eco, nouvel obs
monde = Source.create!(name: "Le Monde",
                       presentation: "<p>Le Monde est un journal français fondé par Hubert Beuve-Méry en 1944. C'est l'un des derniers quotidiens français dits « du soir », qui paraît à Paris en début d'après-midi, daté du lendemain, et est distribué en province le matin suivant.</p>
                      <p>Sa ligne éditoriale est parfois présentée comme étant de centre gauche, bien que cette affirmation soit récusée par le journal lui-même, qui revendique un traitement non partisan, et son lectorat est majoritairement orienté à gauche.</p>
                      <p>Le journal est édité par le groupe Le Monde, détenu depuis 2010 à 64 % par la société Le Monde libre, elle-même propriété des hommes d'affaires Xavier Niel, Pierre Bergé et Matthieu Pigasse, ainsi que par le groupe de presse espagnol Prisa.</p>",
                       orientation: "centre-gauche",
                       aylien_id: 675)

figaro = Source.create!(name: "Le Figaro",
                        presentation: "<p>Le Figaro est un quotidien français fondé en 1826 sous le règne de Charles X. Il est à ce titre le plus ancien quotidien de la presse française encore publié. Il a été nommé d'après Figaro, le personnage de Beaumarchais, dont il met en exergue la réplique : « Sans la liberté de blâmer, il n'est point d'éloge flatteur. » <p>
                        <p>Sa ligne éditoriale est de droite gaulliste et conservatrice, selon le spectre politique français habituellement utilisé, et réunit une majorité de lecteurs de droite. <p>
                        <p>Le Figaro est, depuis 2004, la propriété de l'industriel et sénateur Serge Dassault via la Société du Figaro et Dassault media.<p>",
                        orientation: "droite",
                        aylien_id: 641)

liberation = Source.create!(name: "Libération",
                            presentation: "<p>Libération est un quotidien français paraissant le matin, disponible également dans une version en ligne. Fondé sous l'égide de Jean-Paul Sartre, le journal paraît pour la première fois le 18 avril 1973 et reprend le nom d'un titre de presse similaire créé en 1927 par le libertaire Jules Vignes, nom qui sera également celui d'un des journaux de la Résistance dirigé par Emmanuel d'Astier de La Vigerie. <p>
                            <p>Situé à l'extrême gauche à ses débuts, Libération évolue vers la gauche sociale-démocrate à la fin des années 1970 après la démission de Jean-Paul Sartre en 1974. Aujourd'hui, sa ligne éditoriale est toujours de centre gauche ou de gauche sociale-démocrate.<p>
                            <p>Libération a pour actionnaires de référence les hommes d'affaires Bruno Ledoux — propriétaire du siège du journal — et Patrick Drahi — président-fondateur du consortium luxembourgeois Altice.<p>",
                            orientation: "gauche",
                            aylien_id: 251)

echos = Source.create!(name: "Les Échos",
                       presentation: "<p>Les Échos est un quotidien français d’information économique et financière qui traite et analyse l'ensemble de l'actualité nationale, régionale et internationale ayant des répercussions sur la vie des affaires.<p>
                       <p>Fondé en 1908 par les frères Robert et Émile Servan-Schreiber, le journal est d'orientation libérale. <p>
                       <p>Il est actuellement propriété du Groupe Les Échos, pôle média du groupe LVMH et dirigé depuis avril 2013 par Nicolas Barré. <p>",
                       orientation: "libéral",
                       aylien_id: 684)

humanite = Source.create!(name: "L'Humanité",
                          presentation: "<p>L’Humanité est un tabloïde français, socialiste jusqu'à fin 1920 puis communiste, fondé en 1904 par le dirigeant socialiste Jean Jaurès, qui mettait la lutte pour la paix, la « communion avec le mouvement ouvrier » et l'indépendance face aux « groupes d'intérêt » au cœur de ses priorités. Aujourd'hui, il se range parmi les porte-paroles des mouvements, associations, et partis qui se réclament de «la gauche antilibérale.» <p>
                          <p>Organe central du Parti communiste français de 1920 à 1994, il en reste très proche après l’ouverture de ses pages à d'autres composantes de la gauche.<p>
                          <p>Il est aujourd'hui encore et toujours possédé par   Société nouvelle du journal L'Humanité et dirigé par le directeur de redaction Patrick Apel-Muller et la directeur de publication Patrick Le Hyaric.<p>",
                          orientation: "gauche communiste",
                          aylien_id: nil)

express = Source.create!(name: "L'Express",
                         presentation: "<p>L'Express est un magazine d'actualité hebdomadaire français fondé le 16 mai 1953 par Jean-Jacques Servan-Schreiber et Françoise Giroud comme supplément politique du journal économique libéral Les Échos.<p>
                         <p>Le journal fut très critique à l'encontre de la SFIO et du socialisme, et son anticommunisme racinaire à partir des années 1960 l'incline inéluctablement vers l'option centriste. <p>
                         <p>Aujourd'hui, il appartient au Groupe L'Express, filiale de Altice Media Group créé par l'entrepreneur franco-israélien Patrick Drahi et l'homme d'affaires français Marc Laufer.<p>",
                         orientation: "centre",
                         aylien_id: 233)

nouvel_observateur = Source.create!(name: "Le Nouvel Observateur",
                                    presentation: "<p>L’Obs (un temps intitulé France Observateur, puis Le Nouvel Observateur — familièrement surnommé Le Nouvel Obs — jusqu’au 23 octobre 2014) est un hebdomadaire français d'information générale de gauche. Héritier de L'Observateur politique, économique et littéraire né en 1950, le premier numéro de ce magazine d'actualité a été publié le 19 novembre 1964. <p>
                                    <p>Il s'agit d'un journal social-démocrate de gauche. <p>
                                    <p>Il est aujourd'hui dirigé par Matthieu Croissandeau et possédé à 66 % par Bergé-Niel-Pigasse et 34% par le Groupe Perdriel.<p>",
                                    orientation: "gauche",
                                    aylien_id: nil)

point = Source.create!(name: "Le Point",
                       presentation: "<p>Le Point est un magazine hebdomadaire français d'information générale, fondé en 1972. Son modèle générique est celui du magazine américain Time, fondé par Henry Luce dans les années 1920, ou de son confrère Newsweek.<p>
                        <p>Le magazine ouvre ses pages à toutes les opinions politiques. Sa ligne éditoriale est communément admise comme conservatrice et libérale.<p>
                        <p>En 1997, le journal est racheté par l'homme d'affaire François Pinault, PDG de la holding Artémis et présenté comme un proche de Jacques Chirac. François Pinault prend à travers son groupe le contrôle du Point. Claude Imbert, en garant de la continuité du journal et de sa ligne, demeure l'un des éditorialistes principaux.<p>",
                       orientation: "droite",
                       aylien_id: 1192)

marianne = Source.create!(name: "Marianne",
                          presentation: "<p>Marianne est un magazine d'information hebdomadaire français créé par Jean-François Kahn et Maurice Szafran en 1997. Refondu à partir du 29 juin 2013, le titre reprend celui de Marianne, un ancien journal politique et littéraire orienté à gauche qui fut publié à Paris dans les années 1930.<p>
                          <p>Le Marianne actuel combat ce qu'il nomme la pensée unique. Il se veut centriste révolutionnaire. <p>
                          <p>Les principaux actionnaires sont aujourd'hui à 57% Yves de Chaisemartin, à 31% Marianne Finances (Maurice Szafran), ainsi que Paul Lederman, Guy Sitbon, Thierry Verret et Frank Ullman.<p>",
                          orientation: "extrême gauche",
                          aylien_id: 1234)


croix = Source.create!(name: "La Croix",
                       presentation: "<p>La Croix est un journal quotidien français, propriété du groupe Bayard Presse depuis 1880. Fondé par la congrégation des assomptionnistes, le journal se réclame ouvertement chrétien et catholique, même si ce positionnement a pu évoluer au cours de son histoire.<p>
                       <p>Depuis l'élection de Benoît XVI, le journal qui se dit toujours très attaché au concile Vatican II, a modéré sa critique vis-à-vis des positions du Saint-Siège mais reste reconnu pour ses prises de position progressistes. Son traitement de l'information reste plutôt défavorable aux tendances traditionnelles.<p>
                       <p>Il est possédé par le Groupe Bayard Presse et depuis 2015, Guillaume Goubert est le nouveau directeur de La Croix.<p>",
                       orientation: "droite",
                       aylien_id: 1142)

tribune = Source.create!(name: "La Tribune",
                         presentation: "<p>La Tribune est un journal économique hebdomadaire et financier français, créé en janvier 1985 par Bruno Bertez, principal concurrent du quotidien Les Échos. Il aborde principalement les secteurs de l'industrie, des services, des hautes technologies, des médias, des pays émergents et du management. <p>
                         <p>Il est aujourd'hui possédé par le Groupe Hima (Jean-Christophe Tortora) à 68%, Laurant Alexandre à 28% et JCG Médias à 4%.<p>",
                         orientation: "liberal",
                         aylien_id: 1174)

mediapart = Source.create!(name: "Médiapart",
                           presentation: "<p>Mediapart est un site web d'information et d'opinion créé en 2008 par François Bonnet, Gérard Desportes, Laurent Mauduit et Edwy Plenel. Il a atteint son équilibre financier à l'automne 2010. <p>
                           <p>Mediapart héberge à la fois les articles rédigés par ses équipes propres (« le journal ») et ceux de ses utilisateurs (« le club »). Le site a joué un rôle clé dans la révélation de l'affaire Woerth-Bettencourt en 2010 et de l'affaire Cahuzac en 2012-2013. Mediapart défend un modèle où l'abonnement payant doit garantir l'indépendance du travail des journalistes, tout en permettant l'accès à un club participatif de qualité dont les contenus sont en accès libre.<p>
                           <p>Aujourd'hui les actionnaires directs ou indirects sont nombreux, comme Godefroy Beauvaller, Francois Bonnet, Gérard Desportes, Laurent Mauduit, Edwy Plenel, Marie-Hélène Smiéjan, Laurant Chemla, F.Vitrani, la Société Ecofinance, la Société Doxa et la Société des amis de Mediapart.<p>",
                           orientation: "centre",
                           aylien_id: 1243)

alternatives_economiques = Source.create!(name: "Alternatives Economiques",
                                          presentation: "<p>Alternatives économiques est un magazine mensuel traitant de questions économiques et sociales.<p>
                                          <p>Alternatives économiques a été fondée par l'économiste Denis Clerc en 1980.Proche du keynésianisme,Alternatives économiques traite également des thèmes altermondialistes et se montre critique vis-à-vis du néolibéralisme et de l'école néoclassique. Le journal revendique explicitement une ligne éditoriale « de gauche ». <p>",
                                          orientation: "gauche",
                                          aylien_id: nil)

valeurs_actuelles = Source.create!(name: "Valeurs Actuelles",
                                   presentation: "<p>Valeurs actuelles est un magazine hebdomadaire français créé en 1966 par Raymond Bourgine en reprenant le contenu de l'hebdomadaire Finances, qui était essentiellement une revue d'information boursière. Devenu peu à peu un journal d'opinion et un magazine généraliste, Valeurs actuelles traite de tous les sujets de société.<p>
                                   <p>Aujourd'hui le journal se situe très à droite sur l'échiquier politique, avec une ligne éditoriale généralement libérale-conservatrice voire réactionnaire.<p>
                                  <p>Il fait partie du groupe Valmonde. Celui-ci est la propriété de Privinvest Médias, une filiale de la holding Privinvest de l'homme d'affaires Iskandar Safa dont Étienne Mougeotte et Charles Villeneuve sont actionnaires.<p>",
                                   orientation: "extrême droite",
                                   aylien_id: 1615)

# Categories
puts("Creating Categories")
economy = Category.create!(name: "Economy")
politics = Category.create!(name: "Politics")
culture = Category.create!(name: "Culture")
international = Category.create!(name: "International")
environment = Category.create!(name: "Environment")


# Topics
puts("Creating Topics")
Topic.create!(
  name: "François Fillon",
  image_url: "http://md1.libe.com/photo/781277-henri-guaino-lors-du-congres-fondateur-du-parti-les-republicains.jpg?modified_at=1433427693&amp;picto=fb&amp;ratio_x=191&amp;ratio_y=100&amp;width=600",
  number_sources: 5,
  sources_json: "{\"sources\":[\"L'Express\",\"Liberation\",\"Le Point\",\"Le Monde\",\"Le Figaro\"]}",
  user: hedgy
)

presi = Topic.create!(
  name: "Présidentielles",
  image_url: "http://md1.libe.com/photo/781277-henri-guaino-lors-du-congres-fondateur-du-parti-les-republicains.jpg?modified_at=1433427693&amp;picto=fb&amp;ratio_x=191&amp;ratio_y=100&amp;width=600",
  number_sources: 5,
  sources_json: "{\"sources\":[\"L'Express\",\"Liberation\",\"Le Point\",\"Le Monde\",\"Le Figaro\"]}",
  user: hedgy
)

Topic.create!(
  name: "Hedgenews",
  image_url: "http://md1.libe.com/photo/781277-henri-guaino-lors-du-congres-fondateur-du-parti-les-republicains.jpg?modified_at=1433427693&amp;picto=fb&amp;ratio_x=191&amp;ratio_y=100&amp;width=600",
  number_sources: 5,
  sources_json: "{\"sources\":[\"L'Express\",\"Liberation\",\"Le Point\",\"Le Monde\",\"Le Figaro\"]}",
  user: hedgy
)

Topic.create!(
  name: "Le Wagon Nantes",
  image_url: "http://md1.libe.com/photo/781277-henri-guaino-lors-du-congres-fondateur-du-parti-les-republicains.jpg?modified_at=1433427693&amp;picto=fb&amp;ratio_x=191&amp;ratio_y=100&amp;width=600",
  number_sources: 5,
  sources_json: "{\"sources\":[\"L'Express\",\"Liberation\",\"Le Point\",\"Le Monde\",\"Le Figaro\"]}",
  user: hedgy
)

# Articles TO DO : add full_text, quoted_links, unique_words
# puts("Creating Articles")
# brexit_echoes = Article.new(title: "Echoes of ‘Brexit’ in U.S. Election",
#                                 date: Date.new(2016,11,01),
#                                 abstract: "The British referendum on leaving the European Union and the American presidential election bear some striking similarities. Both were won with a part of the electorate largely ignored by opinion polls.",
#                                 words_count: 2000,
#                                 time_to_read: 10,
#                                 source_url: "http://www.nytimes.com/video/world/europe/100000004757894/echoes-of-brexit-in-us-election.html")
# brexit_echoes.source = nytimes
# brexit_echoes.category = politics
# brexit_echoes.journalist = isaure
# brexit_echoes.save!

theresa_may_brexit = Article.new(title: "Exclusive: what Theresa May really thinks about Brexit shown in leaked recording",
                                     date: Date.new(2016,10,13),
                                     abstract: "Secret audio of Goldman Sachs talk in May shows she feared businesses would leave and wanted the UK to take a lead in Europe",
                                     words_count: 1500,
                                    #  time_to_read: 8,
                                     source_url: "https://www.theguardian.com/politics/2016/oct/25/exclusive-leaked-recording-shows-what-theresa-may-really-thinks-about-brexit")
theresa_may_brexit.source = guardian
theresa_may_brexit.journalist = julie
theresa_may_brexit.topic = presi
theresa_may_brexit.save!

# trump_cop_22 = Article.new(title: "Trump election casts shadow over COP 22 climate change talks",
#                                date: Date.new(2016,11,16),
#                                abstract: "Donald Trump’s victory in the US presidential election reverberated around the world this week, not least in the Moroccan city of Marrakesh that is hosting the first major UN talks on global warming since last year’s landmark Paris climate deal was struck.",
#                                words_count: 4000,
#                                time_to_read: 16,
#                                source_url: "https://www.ft.com/content/09a302c6-9459-11e6-a1dc-bdf38d484582")
# trump_cop_22.source = financialtimes
# trump_cop_22.category = environment
# trump_cop_22.journalist = guillaume
# trump_cop_22.save!

# carbon_capture = Article.new(title: "COP21: What is carbon capture?",
#                                  date: Date.new(2015,12,05),
#                                  abstract: "Negotiators from 196 countries are trying to reach a deal at the climate change conference in Paris to curb global warming. A draft deal was reached last week but key issues still remain",
#                                  words_count: 2000,
#                                  time_to_read: 11,
#                                  source_url: "http://www.bbc.com/news/science-environment-35029984")
# carbon_capture.source = bbc
# carbon_capture.category = environment
# carbon_capture.journalist = raph
# carbon_capture.save!

# # Topic_articles
# puts("Creating TopicArticles")
# TopicArticle.create!(topic_id: brexit.id, article_id: brexit_echoes.id)
# TopicArticle.create!(topic: brexit, article: theresa_may_brexit)
# TopicArticle.create!(topic: cop22, article: trump_cop_22)
# TopicArticle.create!(topic: cop22, article: carbon_capture)

# Topic_articles

#Look for topics through aylien API
#A topic needs to have a user
# puts("Look for topics through aylien API")
# Topic.get
# Topic.get
