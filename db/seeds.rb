# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Topics TO DO : add most_used_words
brexit = Topic.create!(name: "Brexit",
                       presentation: "The United Kingdom's withdrawal from the European Union is widely known as Brexit, a portmanteau of 'British exit'. Following a referendum held in June 2016, in which 52% of votes were cast in favour of leaving the EU")
cop22 = Topic.create!(name: "Cop22",
                      presentation: "The United Nations Climate Change Conferences are yearly conferences held in the framework of the United Nations Framework Convention on Climate Change (UNFCCC). They serve as the formal meeting of the UNFCCC Parties (Conference of the Parties, COP) to assess progress in dealing with climate change, and beginning in the mid-1990s, to negotiate the Kyoto Protocol to establish legally binding obligations for developed countries to reduce their greenhouse gas emissions.")


# Journalists
isaure = Journalist.create!(first_name: "Isaure",
                            last_name:"Troesch",
                            presentation: "I just finished my studies, and I decided to start the wagon in order to complete my CV. I think it is important to know the digital and to get into for the futur.")
julie = Journalist.create!(first_name: "Julie",
                           last_name:"Moiton",
                           presentation: "I have obtained a Bachelor of Business & Management (Queen Mary, University of London). I want to learn to code in order to gain technical skills.")
guillaume = Journalist.create!(first_name: "Guillaume",
                               last_name:"Cabanel",
                               presentation: "I was in sustainable development for construction as an engineer for 6 years. I would like to change my of life by moving to Nantes, learning to code and find a job here.")
raph = Journalist.create!(first_name: "Raphaëlle",
                          last_name:"Coudin",
                          presentation: "After graduating from a business school -ESCP Europe- I worked one year as an Account Manager in WayzUp, a carsharing app to commute between home and work. Today, I want to learn to code to become a product manager.")

# Sources. TO DO : add logo_url
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

# Categories
economy = Category.create!(name: "Economy")
politics = Category.create!(name: "Politics")
culture = Category.create!(name: "Culture")
international = Category.create!(name: "International")
environment = Category.create!(name: "Environment")

# Articles TO DO : add full_text, quoted_links, unique_words
brexit_echoes = Article.new(title: "Echoes of ‘Brexit’ in U.S. Election",
                                date: Date.new(2016,11,01),
                                abstract: "The British referendum on leaving the European Union and the American presidential election bear some striking similarities. Both were won with a part of the electorate largely ignored by opinion polls.",
                                words_count: 2000,
                                time_to_read: 10,
                                source_url: "http://www.nytimes.com/video/world/europe/100000004757894/echoes-of-brexit-in-us-election.html")
brexit_echoes.source = nytimes
brexit_echoes.category = politics
brexit_echoes.journalist = isaure
brexit_echoes.save!

theresa_may_brexit = Article.new(title: "Exclusive: what Theresa May really thinks about Brexit shown in leaked recording",
                                     date: Date.new(2016,10,13),
                                     abstract: "Secret audio of Goldman Sachs talk in May shows she feared businesses would leave and wanted the UK to take a lead in Europe",
                                     words_count: 1500,
                                     time_to_read: 8,
                                     source_url: "https://www.theguardian.com/politics/2016/oct/25/exclusive-leaked-recording-shows-what-theresa-may-really-thinks-about-brexit")
theresa_may_brexit.source = guardian
theresa_may_brexit.category = politics
theresa_may_brexit.journalist = julie
theresa_may_brexit.save!

trump_cop_22 = Article.new(title: "Trump election casts shadow over COP 22 climate change talks",
                               date: Date.new(2016,11,16),
                               abstract: "Donald Trump’s victory in the US presidential election reverberated around the world this week, not least in the Moroccan city of Marrakesh that is hosting the first major UN talks on global warming since last year’s landmark Paris climate deal was struck.",
                               words_count: 4000,
                               time_to_read: 16,
                               source_url: "https://www.ft.com/content/09a302c6-9459-11e6-a1dc-bdf38d484582")
trump_cop_22.source = financialtimes
trump_cop_22.category = environment
trump_cop_22.journalist = guillaume
trump_cop_22.save!

carbon_capture = Article.new(title: "COP21: What is carbon capture?",
                                 date: Date.new(2015,12,05),
                                 abstract: "Negotiators from 196 countries are trying to reach a deal at the climate change conference in Paris to curb global warming. A draft deal was reached last week but key issues still remain",
                                 words_count: 2000,
                                 time_to_read: 11,
                                 source_url: "http://www.bbc.com/news/science-environment-35029984")
carbon_capture.source = bbc
carbon_capture.category = environment
carbon_capture.journalist = raph
carbon_capture.save!

# Topic_articles
TopicArticle.create!(topic_id: brexit.id, article_id: brexit_echoes.id)
TopicArticle.create!(topic: brexit, article: theresa_may_brexit)
TopicArticle.create!(topic: cop22, article: trump_cop_22)
TopicArticle.create!(topic: cop22, article: carbon_capture)
