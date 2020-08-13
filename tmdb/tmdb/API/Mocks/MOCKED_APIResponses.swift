//  MOCKED_APIResponses.swift
//  tmdb

#if DEBUG
import Foundation

class MOCKED_APIResponses {

    static let MOCKED_GenresResponse: String = """
    {
        \"genres\": [
            {
                \"id\": 28,
                \"name\": \"Action\"
            },
            {
                \"id\": 12,
                \"name\": \"Adventure\"
            },
            {
                \"id\": 16,
                \"name\": \"Animation\"
            },
            {
                \"id\": 35,
                \"name\": \"Comedy\"
            },
            {
                \"id\": 80,
                \"name\": \"Crime\"
            },
            {
                \"id\": 99,
                \"name\": \"Documentary\"
            },
            {
                \"id\": 18,
                \"name\": \"Drama\"
            },
            {
                \"id\": 10751,
                \"name\": \"Family\"
            },
            {
                \"id\": 14,
                \"name\": \"Fantasy\"
            },
            {
                \"id\": 36,
                \"name\": \"History\"
            },
            {
                \"id\": 27,
                \"name\": \"Horror\"
            },
            {
                \"id\": 10402,
                \"name\": \"Music\"
            },
            {
                \"id\": 9648,
                \"name\": \"Mystery\"
            },
            {
                \"id\": 10749,
                \"name\": \"Romance\"
            },
            {
                \"id\": 878,
                \"name\": \"Science Fiction\"
            },
            {
                \"id\": 10770,
                \"name\": \"TV Movie\"
            },
            {
                \"id\": 53,
                \"name\": \"Thriller\"
            },
            {
                \"id\": 10752,
                \"name\": \"War\"
            },
            {
                \"id\": 37,
                \"name\": \"Western\"
            }
        ]
    }
    """

    static let MOCKED_DiscoverMovies_pg0 = """
    {
        \"page\": 1,
        \"total_results\": 10000,
        \"total_pages\": 500,
        \"results\": [
            {
                \"popularity\": 124.493,
                \"id\": 531499,
                \"video\": false,
                \"vote_count\": 44,
                \"vote_average\": 6,
                \"title\": \"The Tax Collector\",
                \"release_date\": \"2020-08-07\",
                \"original_language\": \"en\",
                \"original_title\": \"The Tax Collector\",
                \"genre_ids\": [
                    28,
                    80,
                    18,
                    53
                ],
                \"backdrop_path\": \"/zogWnCSztU8xvabaepQnAwsOtOt.jpg\",
                \"adult\": false,
                \"overview\": \"David e Creeper são coletores de taxas para o chefão do crime chamado Wizard, que pega uma parte dos lucros de todas as operações ilegais de outras gangues. Mas quando um rival de seu chefe retorna para Los Angeles vindo do México, David irá precisar tomar medidas drásticas para proteger sua família.\",
                \"poster_path\": \"/3eg0kGC2Xh0vhydJHO37Sp4cmMt.jpg\"
            },
            {
                \"popularity\": 87.088,
                \"id\": 703771,
                \"video\": false,
                \"vote_count\": 64,
                \"vote_average\": 7.3,
                \"title\": \"Exterminador: Cavaleiros e Dragões\",
                \"release_date\": \"2020-08-04\",
                \"original_language\": \"en\",
                \"original_title\": \"Deathstroke: Knights & Dragons - The Movie\",
                \"genre_ids\": [
                    16,
                    28
                ],
                \"backdrop_path\": \"/owraiceOKtSOa3t8sp3wA9K2Ox6.jpg\",
                \"adult\": false,
                \"overview\": \"Com sua alma despedaçada e seu filho preso, o mercenário e mestre assassino Slade Wilson terá que redimir os pecados do seu passado para alimentar as batalhas do seu futuro!\",
                \"poster_path\": \"/vFIHbiy55smzi50RmF8LQjmpGcx.jpg\"
            },
            {
                \"popularity\": 88.994,
                \"vote_count\": 152,
                \"video\": false,
                \"poster_path\": \"/iK3Nqzqbp0HL7Mbnm3hKOsldxjn.jpg\",
                \"id\": 703745,
                \"adult\": false,
                \"backdrop_path\": \"/hIHtyIYgBqHybOgUdoAmveipuiO.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Deep Blue Sea 3\",
                \"genre_ids\": [
                    28,
                    27,
                    878
                ],
                \"title\": \"Do Fundo do Mar 3\",
                \"vote_average\": 6.5,
                \"overview\": \"A Doutora Emma Collins e sua equipe estão passando o verão na ilha de Little Happy, estudando o efeito das mudanças climáticas nos grandes tubarões brancos que vêm todos os anos ao berçário próximo para dar à luz. Juntamente com os dois últimos habitantes desta antiga vila de pescadores, sua vida pacífica é interrompida quando uma equipe “científica” liderada por seu ex-namorado e biólogo marinho Richard aparece à procura de três tubarões-touro que logo descobrimos que não são apenas tubarões… e sim máquinas de matar.\",
                \"release_date\": \"2020-07-28\"
            },
            {
                \"popularity\": 81.827,
                \"vote_count\": 869,
                \"video\": false,
                \"poster_path\": \"/el7iWlogQ4Mv6A0qvBn4ZyxHGiW.jpg\",
                \"id\": 516486,
                \"adult\": false,
                \"backdrop_path\": \"/xXBnM6uSTk6qqCf0SRZKXcga9Ba.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Greyhound\",
                \"genre_ids\": [
                    28,
                    18,
                    10752
                ],
                \"title\": \"Greyhound - Na Mira do Inimigo\",
                \"vote_average\": 7.5,
                \"overview\": \"No início da Segunda Guerra Mundial, um inexperiente capitão da Marinha dos EUA deve liderar um comboio aliado sendo perseguido por navios e submarinos nazistas.\",
                \"release_date\": \"2020-06-19\"
            },
            {
                \"popularity\": 77.675,
                \"vote_count\": 19266,
                \"video\": false,
                \"poster_path\": \"/89QTZmn34iwXYeCpVxhC9UrT8sX.jpg\",
                \"id\": 299536,
                \"adult\": false,
                \"backdrop_path\": \"/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Avengers: Infinity War\",
                \"genre_ids\": [
                    28,
                    12,
                    878
                ],
                \"title\": \"Vingadores: Guerra Infinita\",
                \"vote_average\": 8.3,
                \"overview\": \"Homem de Ferro, Thor, Hulk e os Vingadores se unem para combater seu inimigo mais poderoso, o maligno Thanos. Em uma missão para coletar todas as seis pedras infinitas, Thanos planeja usá-las para infligir sua vontade maléfica sobre a realidade.\",
                \"release_date\": \"2018-04-25\"
            },
            {
                \"popularity\": 87.564,
                \"id\": 27205,
                \"video\": false,
                \"vote_count\": 26755,
                \"vote_average\": 8.3,
                \"title\": \"A Origem\",
                \"release_date\": \"2010-07-15\",
                \"original_language\": \"en\",
                \"original_title\": \"Inception\",
                \"genre_ids\": [
                    28,
                    878,
                    12
                ],
                \"backdrop_path\": \"/s3TBrRGB1iav7gFOCNx3H31MoES.jpg\",
                \"adult\": false,
                \"overview\": \"Um ladrão que rouba segredos corporativos por meio do uso da tecnologia de compartilhamento de sonhos, recebe a tarefa inversa de plantar uma ideia na mente de um Diretor Executivo.\",
                \"poster_path\": \"/o1SB1gHCmEEURs8P6dfmSC9O3iu.jpg\"
            },
            {
                \"popularity\": 67.901,
                \"vote_count\": 5416,
                \"video\": false,
                \"poster_path\": \"/lFx2i2pg1BoaD7grcpGDyHM1eML.jpg\",
                \"id\": 181812,
                \"adult\": false,
                \"backdrop_path\": \"/SPkEiZGxq5aHWQ2Zw7AITwSEo2.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Star Wars: The Rise of Skywalker\",
                \"genre_ids\": [
                    28,
                    12,
                    878
                ],
                \"title\": \"Star Wars: A Ascensão Skywalker\",
                \"vote_average\": 6.6,
                \"overview\": \"Com o retorno do Imperador Palpatine, todos voltam a temer seu poder e, com isso, a Resistência toma a frente da batalha que ditará os rumos da galáxia. Treinando para ser uma completa Jedi, Rey (Daisy Ridley) ainda se encontra em conflito com seu passado e futuro, mas teme pelas respostas que pode conseguir a partir de sua complexa ligação com Kylo Ren (Adam Driver), que também se encontra em conflito pela Força.\",
                \"release_date\": \"2019-12-18\"
            },
            {
                \"popularity\": 63.264,
                \"id\": 495764,
                \"video\": false,
                \"vote_count\": 5381,
                \"vote_average\": 7.2,
                \"title\": \"Aves de Rapina: Arlequina e sua Emancipação Fantabulosa\",
                \"release_date\": \"2020-02-05\",
                \"original_language\": \"en\",
                \"original_title\": \"Birds of Prey (and the Fantabulous Emancipation of One Harley Quinn)\",
                \"genre_ids\": [
                    28,
                    80,
                    35
                ],
                \"backdrop_path\": \"/9xNOiv6DZZjH7ABoUUDP0ZynouU.jpg\",
                \"adult\": false,
                \"overview\": \"Arlequina, Canário Negro, Caçadora, Cassandra Cain e a policial Renée Montoya formam um grupo inusitado de heroínas. Quando um perigoso criminoso começa a causar destruição em Gotham, as cinco mulheres precisam se unir para defender a cidade.\",
                \"poster_path\": \"/A50Ngq9lh9aCTGHC6kttrppHNoF.jpg\"
            },
            {
                \"popularity\": 61.355,
                \"vote_count\": 1612,
                \"video\": false,
                \"poster_path\": \"/knfExByNW2jCwtmIuwYYxzPKpkm.jpg\",
                \"id\": 547016,
                \"adult\": false,
                \"backdrop_path\": \"/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"The Old Guard\",
                \"genre_ids\": [
                    28,
                    14
                ],
                \"title\": \"The Old Guard\",
                \"vote_average\": 7.4,
                \"overview\": \"Quatro guerreiros com o dom da imortalidade protegem a humanidade há séculos. Mas seus misteriosos poderes viram alvo de ataque quando outra imortal entra em cena.\",
                \"release_date\": \"2020-07-10\"
            },
            {
                \"popularity\": 54.208,
                \"id\": 531876,
                \"video\": false,
                \"vote_count\": 268,
                \"vote_average\": 6.6,
                \"title\": \"The Outpost\",
                \"release_date\": \"2020-06-24\",
                \"original_language\": \"en\",
                \"original_title\": \"The Outpost\",
                \"genre_ids\": [
                    10752,
                    18,
                    36,
                    28
                ],
                \"backdrop_path\": \"/n1RohH2VoK1CdVI2fXvcP19dSlm.jpg\",
                \"adult\": false,
                \"overview\": \"Uma pequena equipe de soldados dos EUA batalham contra centenas de combatentes do Talibã no Afeganistão.\",
                \"poster_path\": \"/hPkqY2EMqWUnFEoedukilIUieVG.jpg\"
            },
            {
                \"popularity\": 60.114,
                \"vote_count\": 147,
                \"video\": false,
                \"poster_path\": \"/bZh84xueMcj98gqbWIHcKvLk8sT.jpg\",
                \"id\": 430155,
                \"adult\": false,
                \"backdrop_path\": \"/8HbqSozBJxv6UldR9lMUECUlbLI.jpg\",
                \"original_language\": \"ru\",
                \"original_title\": \"Кома\",
                \"genre_ids\": [
                    28,
                    14,
                    878
                ],
                \"title\": \"Submersos\",
                \"vote_average\": 6,
                \"overview\": \"Depois de um acidente misterioso e terrível, um jovem arquiteto talentoso encontra-se em um mundo muito estranho, apenas parcialmente semelhante a realidade. O mundo que se baseia na memória da realidade das pessoas que estão em coma profundo. A memória humana é fragmentada, caótica e mutável. O mesmo é o espaço de coma - um conjunto estranho de memórias, onde rios, geleiras e cidades podem caber em um quarto, onde todas as lei da física pode ser quebrada. O personagem principal tem que descobrir as leis deste espaço, lutar pela vida, encontrar o amor e finalmente encontrar uma saída para o mundo real, realizando-se em uma nova forma de entender o que na verdade é o Coma.\",
                \"release_date\": \"2019-11-19\"
            },
            {
                \"popularity\": 55.619,
                \"id\": 11,
                \"video\": false,
                \"vote_count\": 14103,
                \"vote_average\": 8.2,
                \"title\": \"Guerra nas Estrelas\",
                \"release_date\": \"1977-05-25\",
                \"original_language\": \"en\",
                \"original_title\": \"Star Wars\",
                \"genre_ids\": [
                    12,
                    28,
                    878
                ],
                \"backdrop_path\": \"/zqkmTXzjkAgXmEWLRsY4UpTWCeo.jpg\",
                \"adult\": false,
                \"overview\": \"A princesa Leia é mantida refém pelas forças imperiais comandadas por Darth Vader. Luke Skywalker e o capitão Han Solo precisam libertá-la e restaurar a liberdade e a justiça na galáxia.\",
                \"poster_path\": \"/iSNdwFauC1QODm1ntk07wqJV1pf.jpg\"
            },
            {
                \"popularity\": 55.657,
                \"vote_count\": 8056,
                \"video\": false,
                \"poster_path\": \"/tX0o4AdHpidgniTWwfzK0dNTKrc.jpg\",
                \"id\": 429617,
                \"adult\": false,
                \"backdrop_path\": \"/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Spider-Man: Far from Home\",
                \"genre_ids\": [
                    28,
                    12,
                    878
                ],
                \"title\": \"Homem-Aranha: Longe de Casa\",
                \"vote_average\": 7.5,
                \"overview\": \"Peter Parker está em uma viagem de duas semanas pela Europa, ao lado de seus amigos de colégio, quando é surpreendido pela visita de Nick Fury. Convocado para mais uma missão heroica, ele precisa enfrentar vários vilões que surgem em cidades-símbolo do continente, como Londres, Paris e Veneza, e também a aparição do enigmático Mysterio.\",
                \"release_date\": \"2019-06-28\"
            },
            {
                \"popularity\": 53.266,
                \"id\": 514847,
                \"video\": false,
                \"vote_count\": 1228,
                \"vote_average\": 6.7,
                \"title\": \"A Caçada\",
                \"release_date\": \"2020-03-11\",
                \"original_language\": \"en\",
                \"original_title\": \"The Hunt\",
                \"genre_ids\": [
                    28,
                    53,
                    27
                ],
                \"backdrop_path\": \"/naXUDz0VGK7aaPlEpsuYW8kNVsr.jpg\",
                \"adult\": false,
                \"overview\": \"Doze estranhos acordam em uma clareira. Eles não sabem onde estão ou como chegaram lá. Eles não sabem que foram escolhidos para um propósito muito específico, A Caçada.\",
                \"poster_path\": \"/mDt3GkephI5yrRsEgLfdo3MYxyj.jpg\"
            },
            {
                \"popularity\": 45.641,
                \"vote_count\": 22913,
                \"video\": false,
                \"poster_path\": \"/u49fzmIJHkb1H4oGFTXtBGgaUS1.jpg\",
                \"id\": 24428,
                \"adult\": false,
                \"backdrop_path\": \"/kwUQFeFXOOpgloMgZaadhzkbTI4.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"The Avengers\",
                \"genre_ids\": [
                    28,
                    12,
                    878
                ],
                \"title\": \"Os Vingadores: The Avengers\",
                \"vote_average\": 7.7,
                \"overview\": \"Loki, o irmão de Thor, ganha acesso ao poder ilimitado do cubo cósmico ao roubá-lo de dentro das instalações da S.H.I.E.L.D. Nick Fury, o diretor desta agência internacional que mantém a paz, logo reúne os únicos super-heróis que serão capazes de defender a Terra de ameaças sem precedentes. Homem de Ferro, Capitão América, Hulk, Thor, Viúva Negra e Gavião Arqueiro formam o time dos sonhos de Fury, mas eles precisam aprender a colocar os egos de lado e agir como um grupo em prol da humanidade.\",
                \"release_date\": \"2012-04-25\"
            },
            {
                \"popularity\": 47.146,
                \"vote_count\": 2870,
                \"video\": false,
                \"poster_path\": \"/5DS1Xh1dxfrR1H0sqATPxkwWFzi.jpg\",
                \"id\": 545609,
                \"adult\": false,
                \"backdrop_path\": \"/1R6cvRtZgsYCkh8UFuWFN33xBP4.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Extraction\",
                \"genre_ids\": [
                    28,
                    18,
                    53
                ],
                \"title\": \"Resgate\",
                \"vote_average\": 7.5,
                \"overview\": \"Em Resgate, Tyler Rake (Chris Hemsworth) um agente especial recebe a difícil missão de libertar um garoto indiano que é mantido refém na cidade de Dhaka. Apesar de estar preparado fisicamente, ele precisa lidar com crises de identidade e com seu emocional fragilizado por problemas do passado para que consiga designar sua tarefa da melhor maneira possível.\",
                \"release_date\": \"2020-04-24\"
            },
            {
                \"popularity\": 37.28,
                \"id\": 383498,
                \"video\": false,
                \"vote_count\": 11879,
                \"vote_average\": 7.5,
                \"title\": \"Deadpool 2\",
                \"release_date\": \"2018-05-10\",
                \"original_language\": \"en\",
                \"original_title\": \"Deadpool 2\",
                \"genre_ids\": [
                    28,
                    35,
                    12
                ],
                \"backdrop_path\": \"/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg\",
                \"adult\": false,
                \"overview\": \"Quando o super soldado Cable chega em uma missão para assassinar o jovem mutante Russel, o mercenário Deadpool precisa aprender o que é ser herói de verdade para salvá-lo. Para isso, ele recruta seu velho amigo Colossus e forma o novo grupo X-Force, sempre com o apoio do fiel escudeiro Dopinder.\",
                \"poster_path\": \"/6CABdPx68rYoLdvXhIJkilOj6XZ.jpg\"
            },
            {
                \"popularity\": 57.756,
                \"vote_count\": 5358,
                \"video\": false,
                \"poster_path\": \"/Kt9iFdTu5TbAm7tNfc876mrWU.jpg\",
                \"id\": 454626,
                \"adult\": false,
                \"backdrop_path\": \"/diFNHa3SXaGSSFovGatNWxLz2tn.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Sonic the Hedgehog\",
                \"genre_ids\": [
                    28,
                    35,
                    878,
                    10751
                ],
                \"title\": \"Sonic: O Filme\",
                \"vote_average\": 7.5,
                \"overview\": \"Baseado na franquia global de videogames de sucesso da Sega, Sonic: O Filme conta a história do ouriço mais rápido do mundo enquanto ele abraça sua nova casa na Terra. Nesta comédia de aventura de ação ao vivo, Sonic e seu novo melhor amigo se unem para defender o planeta do gênio do mal Dr. Robotnik e seus planos para dominar o mundo.\",
                \"release_date\": \"2020-02-12\"
            },
            {
                \"popularity\": 45.412,
                \"vote_count\": 2991,
                \"video\": false,
                \"poster_path\": \"/5Z7AJiQhocA20MkI5JXZ6OjTxEW.jpg\",
                \"id\": 338762,
                \"adult\": false,
                \"backdrop_path\": \"/lP5eKh8WOcPysfELrUpGhHJGZEH.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"Bloodshot\",
                \"genre_ids\": [
                    28,
                    878
                ],
                \"title\": \"Bloodshot\",
                \"vote_average\": 7,
                \"overview\": \"Bloodshot é um ex-soldado com poderes especiais: o de regeneração e a capacidade de se metamorfosear. Assassinado ao lado da esposa, ele é ressuscitado e aprimorado com nanotecnologia, desenvolvendo tais habilidades. Ao apagarem sua memória várias vezes, ele finalmente descobre quem realmente é e parte em um busca de vingança daqueles que mataram sua família.\",
                \"release_date\": \"2020-03-05\"
            },
            {
                \"popularity\": 48.221,
                \"vote_count\": 10126,
                \"video\": false,
                \"poster_path\": \"/q9eDVkrj2moWTZp8PZiPccjs5Vo.jpg\",
                \"id\": 122917,
                \"adult\": false,
                \"backdrop_path\": \"/bVmSXNgH1gpHYTDyF9Q826YwJT5.jpg\",
                \"original_language\": \"en\",
                \"original_title\": \"The Hobbit: The Battle of the Five Armies\",
                \"genre_ids\": [
                    28,
                    12,
                    14
                ],
                \"title\": \"O Hobbit: A Batalha dos Cinco Exércitos\",
                \"vote_average\": 7.3,
                \"overview\": \"O dragão Smaug lança sua fúria ardente contra a Cidade do Lago que fica próxima da montanha de Erebor. Bard consegue derrotá-lo, mas, rapidamente, sem a ameaça do dragão, inicia-se uma batalha pelo controle de Erebor e sua riqueza. Os anões, liderados por Thorin, adentram a montanha e estão dispostos a impedir a entrada de elfos, anões e orcs. Bilbo Bolseiro e Gandalf tentam impedir a guerra.\",
                \"release_date\": \"2014-12-10\"
            }
        ]
    }
    """

    static let MOCKED_ConfigurationResponse = """
    {
        \"images\": {
            \"base_url\": \"http://image.tmdb.org/t/p/\",
            \"secure_base_url\": \"https://image.tmdb.org/t/p/\",
            \"backdrop_sizes\": [
                \"w300\",
                \"w780\",
                \"w1280\",
                \"original\"
            ],
            \"logo_sizes\": [
                \"w45\",
                \"w92\",
                \"w154\",
                \"w185\",
                \"w300\",
                \"w500\",
                \"original\"
            ],
            \"poster_sizes\": [
                \"w92\",
                \"w154\",
                \"w185\",
                \"w342\",
                \"w500\",
                \"w780\",
                \"original\"
            ],
            \"profile_sizes\": [
                \"w45\",
                \"w185\",
                \"h632\",
                \"original\"
            ],
            \"still_sizes\": [
                \"w92\",
                \"w185\",
                \"w300\",
                \"original\"
            ]
        },
        \"change_keys\": [
            \"adult\",
            \"air_date\",
            \"also_known_as\",
            \"alternative_titles\",
            \"biography\",
            \"birthday\",
            \"budget\",
            \"cast\",
            \"certifications\",
            \"character_names\",
            \"created_by\",
            \"crew\",
            \"deathday\",
            \"episode\",
            \"episode_number\",
            \"episode_run_time\",
            \"freebase_id\",
            \"freebase_mid\",
            \"general\",
            \"genres\",
            \"guest_stars\",
            \"homepage\",
            \"images\",
            \"imdb_id\",
            \"languages\",
            \"name\",
            \"network\",
            \"origin_country\",
            \"original_name\",
            \"original_title\",
            \"overview\",
            \"parts\",
            \"place_of_birth\",
            \"plot_keywords\",
            \"production_code\",
            \"production_companies\",
            \"production_countries\",
            \"releases\",
            \"revenue\",
            \"runtime\",
            \"season\",
            \"season_number\",
            \"season_regular\",
            \"spoken_languages\",
            \"status\",
            \"tagline\",
            \"title\",
            \"translations\",
            \"tvdb_id\",
            \"tvrage_id\",
            \"type\",
            \"video\",
            \"videos\"
        ]
    }
    """

}

#endif
