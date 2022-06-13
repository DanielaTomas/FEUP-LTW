--.mode columns
--.headers on
--Pragma Foreign_Keys = on;

drop table if exists PromotionAdmin;
drop table if exists DishOrder;
drop table if exists RestaurantMenu;
drop table if exists Dish;
drop table if exists Promotion;
drop table if exists Menu;
drop table if exists Comment;
drop table if exists Review;
drop table if exists Orders;
drop table if exists Administrator;
drop table if exists Users;
drop table if exists Restaurant;

-- Create Tables --

create table Restaurant(
    RestaurantId int PRIMARY KEY,
    RestaurantName varchar(80) NOT NULL,
    RestaurantAddress varchar(70),
    Category varchar(30),
    RestaurantPhoto text NOT NULL
);

create table Users(
    UserId int PRIMARY KEY,
    FirstLastName varchar(60) NOT NULL,
    Username varchar(50) NOT NULL UNIQUE,
    Password varchar(40) NOT NULL,
    UserAddress varchar(70),
    PhoneNumber varchar(24),
    RestaurantId int NOT NULL references Restaurant ON DELETE CASCADE
                                                    ON UPDATE CASCADE 
);

create table Administrator(
    UserId int PRIMARY KEY references Users ON DELETE CASCADE                                                                                
                                            ON UPDATE CASCADE
);

alter table Restaurant
add UserId int CONSTRAINT userid REFERENCES Administrator ON DELETE CASCADE
                                                          ON UPDATE CASCADE;                                                                         

create table Orders(
    OrderId int PRIMARY KEY,
    OrderStatus varchar(60) NOT NULL,
    RestaurantId int NOT NULL references Restaurant ON DELETE CASCADE
                                                    ON UPDATE CASCADE,  
    UserId int NOT NULL references Users ON DELETE CASCADE
                                         ON UPDATE CASCADE                                                                                
);

create table Review(
    ReviewId int PRIMARY KEY,
    Score float constraint score_c CHECK(Score >= 0 and Score <= 5),
    ReviewText varchar(250),
    RestaurantId int NOT NULL references Restaurant ON DELETE CASCADE
                                                    ON UPDATE CASCADE          
);

create table Comment(
    CommentId int PRIMARY KEY,
    AdminComment varchar(250),
    UserId int NOT NULL references Administrator ON DELETE CASCADE                                                                                
                                                 ON UPDATE CASCADE
);

create table Menu(
    MenuId int PRIMARY KEY,
    MenuType text CHECK((MenuType = "APPETIZER" OR
                         MenuType = "SOUP" OR
                         MenuType = "MEAT" OR
                         MenuType = "FISH" OR
                         MenuType = "DRINK" OR
                         MenuType = "DESSERT"))
);

create table Promotion(
    PromotionId int PRIMARY KEY,
    Discount float NOT NULL
                   CHECK(Discount >= 0)
);

create table Dish(
    DishId int PRIMARY KEY,
    DishName varchar(80) NOT NULL,
    Price float NOT NULL
                CHECK(price >= 0),          
    DishDescription varchar(150) NOT NULL,
    Photo text,
    PromotionId int references Promotion ON DELETE CASCADE
                                         ON UPDATE CASCADE,  
    MenuId int NOT NULL references Menu ON DELETE CASCADE
                                        ON UPDATE CASCADE,
    DishPhoto text NOT NULL
);

-- ** --

create table RestaurantMenu(
    RestaurantId int NOT NULL references Restaurant ON DELETE CASCADE
                                                    ON UPDATE CASCADE,  
    MenuId int NOT NULL references Menu ON DELETE CASCADE
                                        ON UPDATE CASCADE,  
    PRIMARY KEY (RestaurantId, MenuId)
);

create table DishOrder(
    DishId int NOT NULL references Dish ON DELETE CASCADE
                                        ON UPDATE CASCADE,  
    OrderId int NOT NULL references Orders ON DELETE CASCADE
                                           ON UPDATE CASCADE,  
    PRIMARY KEY (DishId, OrderId)
);

create table PromotionAdmin(
    PromotionId int NOT NULL references Promotion ON DELETE CASCADE
                                                  ON UPDATE CASCADE,  
    UserId int NOT NULL references Administrator ON DELETE CASCADE
                                                 ON UPDATE CASCADE,  
    PRIMARY KEY (PromotionId, UserId)
);

-- Populate Tables --

-- Restaurants --

insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (001,"The Vintage Dinner","Rua Alexandre Herculano Nº7, Pombal 3100-494 Portugal","Cafe","https://i.pinimg.com/564x/f2/af/fd/f2affd7d5d19e280cb8dc03fbe07313a.jpg",001);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (002,"O Monarca","Rua de Miguel Bombarda 18, 4050-179 Porto","Casual Dining","https://resizer.otstatic.com/v2/photos/wide-xlarge/3/46818715.jpg",002);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (003,"Little Persia","38 Queensway, London W2 3RS, United kingdom","Family Style","https://b.zmtcdn.com/data/reviews_photos/0e2/40f10f402cd0a12885b14009732120e2_1562593796.jpg",003);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (004,"Le Chapeau","Corso Giuseppe Garibaldi, 120, 47121 Forlì FC, Italy","Fine Dining","https://media-cdn.tripadvisor.com/media/photo-s/11/b4/b5/81/salle-de-restaurant.jpg",004);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (005,"Quinta dos Sabores","CM1184 304, 4615-545 Vila Cova de Lixa","Casual Dining","https://cms.infoportugal.info/media/pois/final/152/JRN.RE.29331-152597.JPG",005);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (006,"Brasa & Cia","Av. Alan Kardec, 120 - Dr. Luiz Tinoco da Fonseca, Cachoeiro de Itapemirim - ES, 29313-226, Brasil","Casual Dining","https://res.cloudinary.com/tf-lab/image/upload/restaurant/ee987337-575f-411e-8f80-cb98c044c349/0fceab41-ea23-48aa-8859-4fae213e8782.jpg",006);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (007,"Casa da Sogra","R. Elias Garcia 76, 2700-329 Amadora","Family Style","https://media-cdn.tripadvisor.com/media/photo-s/17/10/c0/f7/casa-da-sogra.jpg",007);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (008,"Arigato","Centro Comercial Campo Pequeno, Praça de Touros Loja 605, 1000-082 Lisboa","Japonese Restaurant","https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,g_auto:subject,q_auto,f_auto/restaurant/10f60a1c-2511-4780-9752-9102b789c838/cd6461cb-13ee-459b-a29f-3f6de81e9a14.jpg",008);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (009,"Station","R. da Madeira 222, 4000-069 Porto","Contemporary Casual","https://images.squarespace-cdn.com/content/v1/5eecf28fbb27655754cf5b3c/1599665880697-1RZPDUVZVVQ7ZISLSJVA/Lounge%2BEast%2Bwall%2Bfacing%2BN.jpg?format=2500w",009);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (010,"The Flavor","Largo Cais Herculano 15 8200-061, Albufeira 8200 Portugal","Bar","https://media-cdn.tripadvisor.com/media/photo-s/0a/f8/e7/67/caption.jpg",010); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (011,"Holy Moly","Unit 1, The School Yard, 106 High St, Harborne, Birmingham B17 9NJ, United Kingdom","Fast Casual","https://i2-prod.birminghammail.co.uk/incoming/article22429157.ece/ALTERNATES/s1200b/0_EntranceJPG.jpg",011); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (012,"Six Seven","2411 Alaskan Way, Seattle, WA 98121, USA","Cafe","https://www.thebespokeblackbook.com/wp-content/uploads/2018/05/sixseven-1024x613.jpg",012); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (013,"Porta 4","R. do Dr. Barbosa de Castro 4, 4050-090 Porto","Casual Dining","https://media.timeout.com/images/103977741/750/422/image.jpg",013); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (014,"Pátio do Duque","Av. de Rodrigues de Freitas 411 Lj I, 4000-422 Porto","Family Style","https://10619-2.s.cdn12.com/rests/small/w550/h367/802_503287925.jpg",014); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (015,"Amour Bistrô","Block C, No.10 Yes Bank, 48, Malcha Marg, Diplomatic Enclave, New Delhi, Delhi 110021, India","Fine Dining","https://b.zmtcdn.com/data/pictures/0/306320/5da09ff3658fe7cf3de34599cbc909a7.jpeg",015); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (016,"Alma","Rua Anchieta, 15, 1200-023 Lisboa","Buffet","https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,g_auto:subject,q_auto,f_auto/restaurant/5df82aae-3bf0-4ac7-93f1-b400c38f95c2/c9c6531c-ff49-4e7a-a827-ec9759b34b27.jpg",016); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (017,"Casserole","Largo do Arouche, 346 - República, São Paulo - SP, 01219-010, Brasil","Casual Dining","https://media-cdn.tripadvisor.com/media/photo-s/1a/e6/34/08/casserole.jpg",017); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (018,"McDonalds","Praça da Liberdade 126, 4000-322 Porto","Fast Food","https://multinews.sapo.pt/wp-content/uploads/2021/05/mcdonalds.jpg",018); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (019,"Dom Joaquim","R. dos Penedos 6, 7000-133 Évora","Casual Dining","https://foodle.pro/restaurants-images/2017-07-17-22-25-44-263434_1.jpg",019); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantAddress,Category,RestaurantPhoto,UserId) values (020,"O Marinheiro","Caminho Praia da Coelha, 8200-385 Albufeira","Casual Dining","https://media-cdn.tripadvisor.com/media/photo-s/19/62/6b/c1/nova-imagem-de-o-marinheiro.jpg",020); 

-- Menus --

insert into Menu(MenuId,MenuType) values (01,"APPETIZER");
insert into Menu(MenuId,MenuType) values (02,"SOUP");
insert into Menu(MenuId,MenuType) values (03,"MEAT");
insert into Menu(MenuId,MenuType) values (04,"FISH");
insert into Menu(MenuId,MenuType) values (05,"DRINK");
insert into Menu(MenuId,MenuType) values (06,"DESSERT");

insert into Menu(MenuId,MenuType) values (07,"APPETIZER");
insert into Menu(MenuId,MenuType) values (08,"SOUP");
insert into Menu(MenuId,MenuType) values (09,"MEAT");
insert into Menu(MenuId,MenuType) values (10,"FISH");
insert into Menu(MenuId,MenuType) values (11,"DRINK");
insert into Menu(MenuId,MenuType) values (12,"DESSERT");

insert into Menu(MenuId,MenuType) values (13,"APPETIZER");
insert into Menu(MenuId,MenuType) values (14,"SOUP");
insert into Menu(MenuId,MenuType) values (15,"MEAT");
insert into Menu(MenuId,MenuType) values (16,"FISH");
insert into Menu(MenuId,MenuType) values (17,"DRINK");
insert into Menu(MenuId,MenuType) values (18,"DESSERT");

insert into Menu(MenuId,MenuType) values (19,"APPETIZER");
insert into Menu(MenuId,MenuType) values (20,"SOUP");
insert into Menu(MenuId,MenuType) values (21,"MEAT");
insert into Menu(MenuId,MenuType) values (22,"FISH");
insert into Menu(MenuId,MenuType) values (23,"DRINK");
insert into Menu(MenuId,MenuType) values (24,"DESSERT");

insert into Menu(MenuId,MenuType) values (25,"APPETIZER");
insert into Menu(MenuId,MenuType) values (26,"MEAT");
insert into Menu(MenuId,MenuType) values (27,"FISH");
insert into Menu(MenuId,MenuType) values (28,"DRINK");
insert into Menu(MenuId,MenuType) values (29,"DESSERT");

insert into Menu(MenuId,MenuType) values (30,"APPETIZER");
insert into Menu(MenuId,MenuType) values (31,"MEAT");
insert into Menu(MenuId,MenuType) values (32,"FISH");
insert into Menu(MenuId,MenuType) values (33,"DRINK");

insert into Menu(MenuId,MenuType) values (34,"APPETIZER");
insert into Menu(MenuId,MenuType) values (35,"SOUP");
insert into Menu(MenuId,MenuType) values (36,"MEAT");
insert into Menu(MenuId,MenuType) values (37,"FISH");
insert into Menu(MenuId,MenuType) values (38,"DRINK");

insert into Menu(MenuId,MenuType) values (39,"APPETIZER");
insert into Menu(MenuId,MenuType) values (40,"MEAT");
insert into Menu(MenuId,MenuType) values (41,"FISH");
insert into Menu(MenuId,MenuType) values (42,"DRINK");

insert into Menu(MenuId,MenuType) values (43,"MEAT");
insert into Menu(MenuId,MenuType) values (44,"FISH");
insert into Menu(MenuId,MenuType) values (45,"DRINK");

insert into Menu(MenuId,MenuType) values (46,"SOUP");
insert into Menu(MenuId,MenuType) values (47,"MEAT");
insert into Menu(MenuId,MenuType) values (48,"FISH");
insert into Menu(MenuId,MenuType) values (49,"DRINK");

insert into Menu(MenuId,MenuType) values (50,"APPETIZER");
insert into Menu(MenuId,MenuType) values (51,"MEAT");
insert into Menu(MenuId,MenuType) values (52,"FISH");
insert into Menu(MenuId,MenuType) values (53,"DRINK");

insert into Menu(MenuId,MenuType) values (54,"MEAT");
insert into Menu(MenuId,MenuType) values (55,"FISH");
insert into Menu(MenuId,MenuType) values (56,"DRINK");
insert into Menu(MenuId,MenuType) values (57,"DESSERT");

insert into Menu(MenuId,MenuType) values (58,"APPETIZER");
insert into Menu(MenuId,MenuType) values (59,"SOUP");
insert into Menu(MenuId,MenuType) values (60,"MEAT");
insert into Menu(MenuId,MenuType) values (61,"FISH");
insert into Menu(MenuId,MenuType) values (62,"DRINK");

insert into Menu(MenuId,MenuType) values (63,"APPETIZER");
insert into Menu(MenuId,MenuType) values (64,"MEAT");
insert into Menu(MenuId,MenuType) values (65,"FISH");
insert into Menu(MenuId,MenuType) values (66,"DRINK");
insert into Menu(MenuId,MenuType) values (67,"DESSERT");

insert into Menu(MenuId,MenuType) values (68,"SOUP");
insert into Menu(MenuId,MenuType) values (69,"MEAT");
insert into Menu(MenuId,MenuType) values (70,"FISH");
insert into Menu(MenuId,MenuType) values (71,"DRINK");
insert into Menu(MenuId,MenuType) values (72,"DESSERT");

insert into Menu(MenuId,MenuType) values (73,"MEAT");
insert into Menu(MenuId,MenuType) values (74,"FISH");
insert into Menu(MenuId,MenuType) values (75,"DRINK");

insert into Menu(MenuId,MenuType) values (76,"SOUP");
insert into Menu(MenuId,MenuType) values (77,"MEAT");
insert into Menu(MenuId,MenuType) values (78,"FISH");
insert into Menu(MenuId,MenuType) values (79,"DRINK");

insert into Menu(MenuId,MenuType) values (80,"MEAT");
insert into Menu(MenuId,MenuType) values (81,"FISH");
insert into Menu(MenuId,MenuType) values (82,"DRINK");
insert into Menu(MenuId,MenuType) values (83,"DESSERT");

insert into Menu(MenuId,MenuType) values (84,"APPETIZER");
insert into Menu(MenuId,MenuType) values (85,"MEAT");
insert into Menu(MenuId,MenuType) values (86,"FISH");
insert into Menu(MenuId,MenuType) values (87,"DRINK");

insert into Menu(MenuId,MenuType) values (88,"SOUP");
insert into Menu(MenuId,MenuType) values (89,"MEAT");
insert into Menu(MenuId,MenuType) values (90,"FISH");
insert into Menu(MenuId,MenuType) values (91,"DRINK");
insert into Menu(MenuId,MenuType) values (92,"DESSERT");

-- Dishes --
-- APPETIZER --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (001,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",01,"https://7zedasfrancesinhas.pt/wp-content/uploads/2021/07/prato-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (002,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",01,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (003,"Melão com presunto",5,"Melão com presunto.",01,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (004,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",01,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (005,"Rodelas de salpicão",3,"Rodelas de salpicão.",01,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (006,"Bruschettas",1.5,"Pão torrado na grelha com tomate e manjericão",07,"https://img.itdg.com.br/images/recipes/000/003/876/326223/326223_original.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (007,"Rissol de carne",0.9,"Pastel salgado recheado com carnes variadas.",07,"https://amodadoflavio.pt/ophaboah/2020/09/Rissóis-de-carne.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (008,"Rissol de camarão",0.9,"Pastel salgado recheado com camarão.",07,"https://1.bp.blogspot.com/-uvsE8bm59u8/T8jkFf6qXMI/AAAAAAAAEvY/aCpR7M7Kb2s/s1600/1.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (009,"Carpaccio",3,"Carne crua cortada em fatias finas.",07,"https://www.sabornamesa.com.br/media/k2/items/cache/0bbf3df5693cbd3118c040cdf0cdd245_XL.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (010,"Polenta",3,"Polenta frita com queijo ralado.",07,"https://img.itdg.com.br/tdg/images/recipes/000/080/700/131267/131267_original.jpg?mode=crop&width=710&height=400");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (011,"Pão de alho",1.5,"Pão tostado com mistura de alho, azeite, manteiga e oregãos.",13,"https://pt.petitchef.com/imgupl/recipe/pao-de-alho-no-forno--449988p695605.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (012,"Cocktail de camarão",8,"Camarões cozidos com casca num molho servido num copo.",13,"https://www.homemnacozinha.com/wp-content/uploads/2006/08/coquetel-de-camar%C3%A3o.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (013,"Bolinhos de bacalhau",0.9,"Pasteis recheados com bacalhau.",13,"https://www.anamariabrogui.com.br/assets/uploads/receitas/fotos/usuario-3000-e4e0799af29a323af1bbf43ce9bc44b0.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (014,"Cogumelos recheados",4,"Cogumelos recheados com ovos e farinheira.",13,"https://www.pingodoce.pt/wp-content/uploads/2018/11/cogumelos-recheados.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (015,"Salada de carpese",3,"Salada feita de mussarela fresca fatiada, tomate e manjericão.",13,"https://s2.glbimg.com/rCTNVxxnpF7D-RoDvkmjUYFS6Uc=/696x390/smart/filters:cover():strip_icc()/s.glbimg.com/po/rc/media/2012/06/13/15/40/52/579/salada_caprese.png");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (016,"Amendoins, tremoços e azeitonas",5,"Amendoins, tremoços e azeitonas.",19,"https://media-cdn.tripadvisor.com/media/photo-s/11/6d/de/43/entradas-amendoins-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (017,"Pão recheado",2,"Pão recheado com queijo e chouriço.",19,"https://feed.continente.pt/media/vcbk31rj/bacalhauemcamadebatatajpg.jpg?anchor=center&mode=crop&width=1680&height=720&rnd=132694549896330000");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (018,"Melão com presunto",5,"Melão com presunto.",19,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (019,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",19,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (020,"Rodelas de salpicão",3,"Rodelas de salpicão.",19,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (021,"Patê de delicias do mar",2,"Preparação cremosa à base de delicias do mar para comer com com pão.",25,"https://www.teleculinaria.pt/wp-content/uploads/2015/04/Pat%C3%A9-de-del%C3%ADcias-do-mar-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (022,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",25,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (023,"Melão com presunto",5,"Melão com presunto.",25,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (024,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",25,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (025,"Rodelas de salpicão",3,"Rodelas de salpicão.",25,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (026,"Chouriço assado",2,"Chouriço assado sobre a grelha do assador de barro.",30,"https://media-cdn.tripadvisor.com/media/photo-s/06/b9/d2/28/aldea-restaurante.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (027,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",30,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (028,"Melão com presunto",5,"Melão com presunto.",30,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (029,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",30,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (030,"Rodelas de salpicão",3,"Rodelas de salpicão.",30,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (031,"Alheira",5,"Alheira assada no forno.",34,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Como-fazer-alheiras-caseiras.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (032,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",34,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (033,"Melão com presunto",5,"Melão com presunto.",34,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (034,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",34,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (035,"Rodelas de salpicão",3,"Rodelas de salpicão.",34,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (036,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",39,"https://7zedasfrancesinhas.pt/wp-content/uploads/2021/07/prato-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (037,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",39,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (038,"Melão com presunto",5,"Melão com presunto.",39,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (039,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",39,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (040,"Rodelas de salpicão",3,"Rodelas de salpicão.",39,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (041,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",50,"https://7zedasfrancesinhas.pt/wp-content/uploads/2021/07/prato-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (042,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",50,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (043,"Melão com presunto",5,"Melão com presunto.",50,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (044,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",50,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (045,"Rodelas de salpicão",3,"Rodelas de salpicão.",50,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (046,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",58,"https://7zedasfrancesinhas.pt/wp-content/uploads/2021/07/prato-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (047,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",58,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (048,"Melão com presunto",5,"Melão com presunto.",58,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (049,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",58,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (050,"Rodelas de salpicão",3,"Rodelas de salpicão.",58,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (051,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",63,"https://7zedasfrancesinhas.pt/wp-content/uploads/2021/07/prato-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (052,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",63,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (053,"Melão com presunto",5,"Melão com presunto.",63,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (054,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",63,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (055,"Rodelas de salpicão",3,"Rodelas de salpicão.",63,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (056,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",84,"https://7zedasfrancesinhas.pt/wp-content/uploads/2021/07/prato-azeitonas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (057,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",84,"https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/630E9508-FB13-4ECD-9155-361716C2C967/Derivates/A1A23CB2-4ED9-4450-B763-B6E17E705ECD.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (058,"Melão com presunto",5,"Melão com presunto.",84,"https://www.receitasfaceisrapidasesaborosas.pt/wp-content/uploads/2020/07/Mel%C3%A3o-com-presuntos.jpg-2.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (059,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",84,"https://www.almaregional.pt/wp-content/uploads/2020/09/queijo-ovelha-cura-apiment-1.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (060,"Rodelas de salpicão",3,"Rodelas de salpicão.",84,"https://baccoroloco.com/wp-content/uploads/2015/03/SAM_3451.jpg");

-- SOUP --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (061,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",02,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (062,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",02,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (063,"Creme de espargos",9.,"Sopa com espargos.",02,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (064,"Sopa de agrião",1.4,"Sopa de agrião.",02,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (065,"Sopa de legumes",1.2,"Sopa com legumes.",02,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (066,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",02,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (067,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",08,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (068,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",08,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (069,"Creme de espargos",9.,"Sopa com espargos.",08,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (070,"Sopa de agrião",1.4,"Sopa de agrião.",08,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (071,"Sopa de legumes",1.2,"Sopa com legumes.",08,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (072,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",08,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (073,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",14,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (074,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",14,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (075,"Creme de espargos",9.,"Sopa com espargos.",14,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (076,"Sopa de agrião",1.4,"Sopa de agrião.",14,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (077,"Sopa de legumes",1.2,"Sopa com legumes.",14,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (078,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",14,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (079,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",20,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (080,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",20,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (081,"Creme de espargos",9.,"Sopa com espargos.",20,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (082,"Sopa de agrião",1.4,"Sopa de agrião.",20,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (083,"Sopa de legumes",1.2,"Sopa com legumes.",20,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (084,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",20,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (085,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",35,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (086,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",35,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (087,"Creme de espargos",9.,"Sopa com espargos.",35,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (088,"Sopa de agrião",1.4,"Sopa de agrião.",35,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (089,"Sopa de legumes",1.2,"Sopa com legumes.",35,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (090,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",35,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (091,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",46,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (092,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",46,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (093,"Creme de espargos",9.,"Sopa com espargos.",46,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (094,"Sopa de agrião",1.4,"Sopa de agrião.",46,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (095,"Sopa de legumes",1.2,"Sopa com legumes.",46,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (096,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",46,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (097,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",59,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (098,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",59,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (099,"Creme de espargos",9.,"Sopa com espargos.",59,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (100,"Sopa de agrião",1.4,"Sopa de agrião.",59,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (101,"Sopa de legumes",1.2,"Sopa com legumes.",59,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (102,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",59,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (103,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",68,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (104,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",68,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (105,"Creme de espargos",9.,"Sopa com espargos.",68,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (106,"Sopa de agrião",1.4,"Sopa de agrião.",68,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (107,"Sopa de legumes",1.2,"Sopa com legumes.",68,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (108,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",68,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (109,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",76,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (110,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",76,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (111,"Creme de espargos",9.,"Sopa com espargos.",76,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (112,"Sopa de agrião",1.4,"Sopa de agrião.",76,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (113,"Sopa de legumes",1.2,"Sopa com legumes.",76,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (114,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",76,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (115,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",88,"https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/shutterstock_316111241_CaldoVerde_GV_Natalia%20Mylova_660x371.jpg?itok=nEVwwtvi");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (116,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",88,"https://i0.statig.com.br/bancodeimagens/bn/th/0v/bnth0vpaeyqreobzguso5d65h.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (117,"Creme de espargos",9.,"Sopa com espargos.",88,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Creme-de-espargos.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (118,"Sopa de agrião",1.4,"Sopa de agrião.",88,"https://www.foodfromportugal.com/content/uploads/2012/11/sopa-agriao.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (119,"Sopa de legumes",1.2,"Sopa com legumes.",88,"https://images.aws.nestle.recipes/original/710943f7bf83e778f7185b2c50ef538d_sopa-de-legumes-cenoura-batata-tomate-e-manjericao-receitas-nestle.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (120,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",88,"https://images.squarespace-cdn.com/content/v1/5ba7a02a7fdcb8cb9072e572/1597066267859-K47T3476WKAJV8GMWEMT/Arroz+de+Garoupa.JPG?format=2500w");

-- MEAT --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (121,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",03,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (122,"Filé mignon",19.99,"Carne bovina fatiada com batata.",03,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (123,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",03,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (124,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",03,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (125,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",03,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (126,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",03,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (127,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",03,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (128,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",09,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (129,"Filé mignon",19.99,"Carne bovina fatiada com batata.",09,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (130,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",09,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (131,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",09,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (132,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",09,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (133,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",09,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (134,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",09,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (135,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",15,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (136,"Filé mignon",19.99,"Carne bovina fatiada com batata.",15,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (137,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",15,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (138,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",15,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (139,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",15,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (140,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",15,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (141,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",15,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (142,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",21,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (143,"Filé mignon",19.99,"Carne bovina fatiada com batata.",21,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (144,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",21,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (145,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",21,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (146,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",21,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (147,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",21,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (148,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",21,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (149,"Filé mignon",19.99,"Carne bovina fatiada com batata.",26,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (150,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",26,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (151,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",26,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (152,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",26,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (153,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",26,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (154,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",26,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (155,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",31,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (156,"Filé mignon",19.99,"Carne bovina fatiada com batata.",31,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (157,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",31,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (158,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",31,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (159,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",31,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (160,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",31,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (161,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",31,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (162,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",36,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (163,"Filé mignon",19.99,"Carne bovina fatiada com batata.",36,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (164,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",36,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (165,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",36,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (166,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",36,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (167,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",36,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (168,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",36,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (169,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",40,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (170,"Filé mignon",19.99,"Carne bovina fatiada com batata.",40,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (171,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",40,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (172,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",40,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (173,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",40,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (174,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",40,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (175,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",40,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (176,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",43,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (177,"Filé mignon",19.99,"Carne bovina fatiada com batata.",43,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (178,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",43,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (179,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",43,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (180,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",43,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (181,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",43,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (182,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",43,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (183,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",47,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (184,"Filé mignon",19.99,"Carne bovina fatiada com batata.",47,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (185,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",47,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (186,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",47,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (187,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",47,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (188,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",47,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (189,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",47,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (190,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",51,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (191,"Filé mignon",19.99,"Carne bovina fatiada com batata.",51,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (192,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",51,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (193,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",51,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (194,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",51,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (195,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",51,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (196,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",51,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (197,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",54,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (198,"Filé mignon",19.99,"Carne bovina fatiada com batata.",54,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (199,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",54,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (200,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",54,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (201,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",54,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (202,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",54,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (203,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",54,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (204,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",60,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (205,"Filé mignon",19.99,"Carne bovina fatiada com batata.",60,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (206,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",60,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (207,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",60,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (208,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",60,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (209,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",60,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (210,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",60,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (211,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",64,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (212,"Filé mignon",19.99,"Carne bovina fatiada com batata.",64,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (213,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",64,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (214,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",64,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (215,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",64,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (216,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",64,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (217,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",64,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (218,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",69,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (219,"Filé mignon",19.99,"Carne bovina fatiada com batata.",69,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (220,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",69,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (221,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",69,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (222,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",69,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (223,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",69,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (224,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",69,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (225,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",73,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (226,"Filé mignon",19.99,"Carne bovina fatiada com batata.",73,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (227,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",73,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (228,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",73,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (229,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",73,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (230,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",73,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (231,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",73,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (232,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",77,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (233,"Filé mignon",19.99,"Carne bovina fatiada com batata.",77,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (234,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",77,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (235,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",77,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (236,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",77,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (237,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",77,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (238,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",77,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (239,"McChicken",4.90,"Hamburguer de frango.",80,"https://cache-backend-mcd.mcdonaldscupones.com/media/image/product$kUXZKLM5/200/200/original?country=br");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (240,"Big Mac",5.10,"Hamburguer bovino com picles, alface, cebola e queijo.",80,"https://www.mcdonalds.pt/media/7040/produtos_500x500_bestburgers_big-mac.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (241,"McBifana",2.45,"Bifana no pão com ou sem mostarda. Ingredientes 100% portugueses.",80,"https://www.meiosepublicidade.pt/wp-content/uploads/2021/04/image015.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (242,"Double Cheeseburguer",4.90,"Dois hamburgueres de carne bovina com picles, ketchup, mostarda e duas fatias de queijo.",80,"https://s7d1.scene7.com/is/image/mcdonalds/t-mcdonalds-Double-Cheeseburger-1:1-3-product-tile-desktop?wid=829&hei=515&dpr=off");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (243,"McRoyal Bacon",5.5,"Dois hamburgueres de carne de vaca grelhada com tiras de bacon crocante e duas fatias de queijo.",80,"https://www.mcdonalds.pt/media/1472/013_mcroyalbacon_01-tinified.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (244,"McRoyal Deluxe",5.70,"Hamburguer com alface, tomate e queijo.",80,"https://www.mcdonalds.pt/media/1470/011_mcroyaldeluxe_02-tinified.png");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (245,"Chicken McNuggets",2,"Feitos com frango e sem corantes ou conservantes artificiais.",80,"https://www.greenmebrasil.com/wp-content/uploads/2014/12/mc_nuggets_pollo.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (246,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",85,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (247,"Filé mignon",19.99,"Carne bovina fatiada com batata.",85,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (248,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",85,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (249,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",85,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (250,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",85,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (251,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",85,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (252,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",85,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (253,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",89,"https://d1e3z2jco40k3v.cloudfront.net/-/media/margpt2018/recipes/800/costeletas_de_borrego_grelhadas_com_ervas_aromaticas_800.jpg?rev=2cc142a8bf1f43b9b439997f412286bb&vd=20200616T045250Z&hash=00044C1857C533F0F883485EDCB21BE3");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (254,"Filé mignon",19.99,"Carne bovina fatiada com batata.",89,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2018/11/file-mignon-no-forno.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (255,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",89,"https://cdn.guiadacozinha.com.br/wp-content/uploads/2019/10/frango-assado-com-ervas.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (256,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",89,"https://www.teleculinaria.pt/wp-content/uploads/2015/06/iscas-a-portuguesa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (257,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",89,"https://www.vortexmag.net/wp-content/uploads/2021/01/leitao-assado-.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (258,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",89,"https://t2.rg.ltmcdn.com/pt/posts/6/2/6/picanha_a_brasileira_2626_600.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (259,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",89,"https://res.cloudinary.com/serdy-m-dia-inc/image/upload/f_auto/fl_lossy/q_auto:eco/x_1813,y_11,w_2740,h_1542,c_crop/w_576,h_324,c_scale/v1534362528/foodlavie/prod/recettes/beurre-maitre-d-hotel-3719ea65");

-- FISH --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (260,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",04,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (261,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",04,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (262,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",04,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (263,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",04,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (264,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",04,"https://www.cozinharsemstress.pt/cozinhar/wp-content/uploads/2014/08/B-015_1270.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (265,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",04,"https://pt.petitchef.com/imgupl/recipe/peixe-espada-grelhado--md-133515p200925.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (266,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",04,"https://www.pingodoce.pt/wp-content/uploads/2016/09/polvo-a-lagareiro.jpeg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (267,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",04,"http://1.bp.blogspot.com/-yzNwj-HSGNc/Uycq29HkMSI/AAAAAAAAFn0/Jg9ErGFU7Ag/s1600/012.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (268,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",04,"https://www.teleculinaria.pt/wp-content/uploads/2018/06/sardinhas-assadas-com-salada-de-batata-e-pimentos.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (269,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",10,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (270,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",10,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (271,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",10,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (272,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",10,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (273,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",10,"https://www.cozinharsemstress.pt/cozinhar/wp-content/uploads/2014/08/B-015_1270.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (274,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",10,"https://pt.petitchef.com/imgupl/recipe/peixe-espada-grelhado--md-133515p200925.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (275,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",10,"https://www.pingodoce.pt/wp-content/uploads/2016/09/polvo-a-lagareiro.jpeg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (276,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",10,"http://1.bp.blogspot.com/-yzNwj-HSGNc/Uycq29HkMSI/AAAAAAAAFn0/Jg9ErGFU7Ag/s1600/012.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (277,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",10,"https://www.teleculinaria.pt/wp-content/uploads/2018/06/sardinhas-assadas-com-salada-de-batata-e-pimentos.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (278,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",16,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (279,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",16,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (280,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",16,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (281,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",16,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (282,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",16,"https://www.cozinharsemstress.pt/cozinhar/wp-content/uploads/2014/08/B-015_1270.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (283,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",16,"https://pt.petitchef.com/imgupl/recipe/peixe-espada-grelhado--md-133515p200925.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (284,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",16,"https://www.pingodoce.pt/wp-content/uploads/2016/09/polvo-a-lagareiro.jpeg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (285,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",16,"http://1.bp.blogspot.com/-yzNwj-HSGNc/Uycq29HkMSI/AAAAAAAAFn0/Jg9ErGFU7Ag/s1600/012.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (286,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",16,"https://www.teleculinaria.pt/wp-content/uploads/2018/06/sardinhas-assadas-com-salada-de-batata-e-pimentos.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (287,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",22,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (288,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",22,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (289,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",22,"https://www.cozinharsemstress.pt/cozinhar/wp-content/uploads/2014/08/B-015_1270.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (290,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",22,"https://pt.petitchef.com/imgupl/recipe/peixe-espada-grelhado--md-133515p200925.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (291,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",22,"https://www.pingodoce.pt/wp-content/uploads/2016/09/polvo-a-lagareiro.jpeg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (292,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",22,"http://1.bp.blogspot.com/-yzNwj-HSGNc/Uycq29HkMSI/AAAAAAAAFn0/Jg9ErGFU7Ag/s1600/012.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (293,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",22,"https://www.teleculinaria.pt/wp-content/uploads/2018/06/sardinhas-assadas-com-salada-de-batata-e-pimentos.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (294,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",27,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (295,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",27,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (296,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",27,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (297,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",27,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (298,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",27,"https://www.cozinharsemstress.pt/cozinhar/wp-content/uploads/2014/08/B-015_1270.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (299,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",27,"https://pt.petitchef.com/imgupl/recipe/peixe-espada-grelhado--md-133515p200925.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (300,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",27,"https://www.pingodoce.pt/wp-content/uploads/2016/09/polvo-a-lagareiro.jpeg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (301,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",27,"http://1.bp.blogspot.com/-yzNwj-HSGNc/Uycq29HkMSI/AAAAAAAAFn0/Jg9ErGFU7Ag/s1600/012.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (302,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",27,"https://www.teleculinaria.pt/wp-content/uploads/2018/06/sardinhas-assadas-com-salada-de-batata-e-pimentos.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (303,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",32,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (304,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",32,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (305,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",32,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (306,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",32,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (307,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",32,"https://www.cozinharsemstress.pt/cozinhar/wp-content/uploads/2014/08/B-015_1270.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (308,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",32,"https://pt.petitchef.com/imgupl/recipe/peixe-espada-grelhado--md-133515p200925.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (309,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",32,"https://www.pingodoce.pt/wp-content/uploads/2016/09/polvo-a-lagareiro.jpeg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (310,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",32,"http://1.bp.blogspot.com/-yzNwj-HSGNc/Uycq29HkMSI/AAAAAAAAFn0/Jg9ErGFU7Ag/s1600/012.JPG");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (311,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",32,"https://www.teleculinaria.pt/wp-content/uploads/2018/06/sardinhas-assadas-com-salada-de-batata-e-pimentos.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (3000,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",37,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (312,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",41,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (313,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",41,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (314,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",41,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (315,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",41,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (316,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",44,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (317,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",44,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (318,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",44,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (319,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",44,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (320,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",48,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (321,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",48,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (322,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",48,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (323,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",48,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (324,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",52,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (325,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",52,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (326,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",52,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (327,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",52,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (328,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",55,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (329,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",55,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (330,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",55,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (331,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",55,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (332,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",61,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (333,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",61,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (334,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",61,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (335,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",61,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (336,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",65,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (337,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",65,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (338,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",65,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (339,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",65,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (340,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",70,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (341,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",70,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (342,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",70,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (343,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",70,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (344,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",74,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (345,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",74,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (346,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",74,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (347,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",74,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (348,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",78,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (349,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",78,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (350,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",78,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (351,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",78,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (352,"Salada mista",0.6,"Salada mista.",81,"https://www.mcdonalds.pt/media/1446/001_saladamistaacoresmadeira-tinified.png?anchor=center&mode=crop&width=416&height=416&rnd=132086144200000000");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (353,"Sopa",0.6,"Sopa.",81,"https://newinoeiras.nit.pt/wp-content/uploads/2020/09/2585d7deebd2e348b24acc9cc843edec-754x424.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (354,"Batatas fritas médias",0.60,"Batatas fritas médias",81,"https://cache-backend-mcd.mcdonaldscupones.com/media/image/product$kUXVg4F7/200/200/original?country=br");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (355,"Batata fritas pequenas",1.10,"Batata fritas pequenas.",81,"https://www.mcdonalds.pt/media/1315/001_batatasfritaspequenas_02-tinified.png?anchor=center&mode=crop&width=416&height=416&rnd=132086133950000000");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (356,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",86,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (357,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",86,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (358,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",86,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (359,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",86,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (360,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",90,"https://www.foodfromportugal.com/content/uploads/2012/11/ameijoas-bulhao-pato-1.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (361,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",90,"https://i2.wp.com/www.chefluismachado.com/wp-content/uploads/2019/04/170317105113_site.jpg?fit=800%2C532&ssl=1");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (362,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",90,"https://media-cdn.tripadvisor.com/media/photo-s/11/81/11/c2/bacalhau-lagareiro.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (363,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",90,"https://pt.petitchef.com/imgupl/recipe/carapaus-grelhados-acompanhados-com-legumes--md-315293p513354.jpg");

-- DRINK --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (364,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",05,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (365,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",05,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (366,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",05,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (367,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",05,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw1b9a8e51/images/hi-res/000953998.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (368,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",05,"https://estadoliquido.pt/6707-medium_default/esteva-tinto-meia-garrafa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (369,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",05,"https://mcgad.pt/wp-content/uploads/2022/01/PCT0.75.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (370,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",11,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (371,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",11,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (372,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",11,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (373,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",11,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw1b9a8e51/images/hi-res/000953998.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (374,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",11,"https://estadoliquido.pt/6707-medium_default/esteva-tinto-meia-garrafa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (375,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",11,"https://mcgad.pt/wp-content/uploads/2022/01/PCT0.75.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (376,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",17,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (377,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",17,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (378,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",17,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (379,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",17,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw1b9a8e51/images/hi-res/000953998.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (380,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",17,"https://estadoliquido.pt/6707-medium_default/esteva-tinto-meia-garrafa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (381,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",17,"https://mcgad.pt/wp-content/uploads/2022/01/PCT0.75.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (382,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",23,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (383,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",23,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (384,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",23,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (385,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",23,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw1b9a8e51/images/hi-res/000953998.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (386,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",23,"https://estadoliquido.pt/6707-medium_default/esteva-tinto-meia-garrafa.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (387,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",23,"https://mcgad.pt/wp-content/uploads/2022/01/PCT0.75.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (388,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",28,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (389,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",28,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (390,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",28,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (391,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",33,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (392,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",33,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (393,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",33,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (394,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",38,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (395,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",38,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (396,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",38,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (397,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",42,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (398,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",42,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (399,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",42,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (400,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",45,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (401,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",45,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (402,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",45,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (403,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",49,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (404,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",49,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (405,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",49,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (406,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",53,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (407,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",53,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (408,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",53,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (409,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",56,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (410,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",56,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (411,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",56,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (412,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",62,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (413,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",62,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (414,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",62,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (415,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",66,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (416,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",66,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (417,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",66,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (418,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",71,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (419,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",71,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (420,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",71,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (421,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",75,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (422,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",75,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (423,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",75,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (424,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",79,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (425,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",79,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (426,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",79,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (427,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",82,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (428,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",82,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (429,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",82,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (430,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",87,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (431,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",87,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (432,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",87,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (433,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",91,"https://media.recheio.pt/catalogo/media/catalog/product/cache/1/image/415x415/9df78eab33525d08d6e5fb8d27136e95/9/2/922602_4.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (434,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",91,"https://trincanela.pt/271-medium_default/pepsi-max.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (435,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",91,"https://www.auchan.pt/dw/image/v2/BFRC_PRD/on/demandware.static/-/Sites-auchan-pt-master-catalog/default/dw42d300c9/images/hi-res/000197462.jpg?sw=500&sh=500&sm=fit&bgcolor=FFFFFF");

-- DESSERT --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (436,"Arroz doce",2.5,"Arroz com sabor adocicado.",06,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (437,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",06,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (438,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",06,"https://www.culturalusa.net/news/wp-content/uploads/2013/06/leite-creme.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (439,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",06,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2019/01/mousse-de-chocolate-light.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (440,"Arroz doce",2.5,"Arroz com sabor adocicado.",12,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (441,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",12,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (442,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",12,"https://www.culturalusa.net/news/wp-content/uploads/2013/06/leite-creme.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (443,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",12,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2019/01/mousse-de-chocolate-light.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (444,"Arroz doce",2.5,"Arroz com sabor adocicado.",18,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (445,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",18,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (446,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",18,"https://www.culturalusa.net/news/wp-content/uploads/2013/06/leite-creme.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (447,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",18,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2019/01/mousse-de-chocolate-light.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (448,"Arroz doce",2.5,"Arroz com sabor adocicado.",24,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (449,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",24,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (450,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",24,"https://www.culturalusa.net/news/wp-content/uploads/2013/06/leite-creme.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (451,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",24,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2019/01/mousse-de-chocolate-light.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (452,"Arroz doce",2.5,"Arroz com sabor adocicado.",29,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (453,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",29,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (454,"Arroz doce",2.5,"Arroz com sabor adocicado.",57,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (455,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",57,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (456,"Arroz doce",2.5,"Arroz com sabor adocicado.",67,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (457,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",67,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (458,"Arroz doce",2.5,"Arroz com sabor adocicado.",72,"https://www.mulherportuguesa.com/wp-content/uploads/2016/10/Receita-de-Arroz-doce-tradicional.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (459,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",72,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (460,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",72,"https://www.culturalusa.net/news/wp-content/uploads/2013/06/leite-creme.jpg");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (461,"Sundae",1,"Gelado caramelo, chocolate ou morango.",83,"https://www.mcdonalds.pt/media/5280/sundae-caramelo_500x500_3.png?anchor=center&mode=crop&width=210&height=210&rnd=132429149040000000");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (462,"McFlurry",1,"Gelado de Oreo, M&M's, Snickers ou KitKat.",83,"https://www.mashed.com/img/gallery/the-untold-truth-of-mcdonalds-mcflurry/intro-1551716950.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (463,"Fruta",2.5,"Maçã fatiada.",83,"https://www.mcdonalds.pt/media/1699/009_pacotemaca-tinified.png?anchor=center&mode=crop&width=210&height=210&rnd=132086139570000000");

insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (464,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",92,"https://www.foodfromportugal.com/content/uploads/2012/11/gelado-chocolate-01.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (465,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",92,"https://www.culturalusa.net/news/wp-content/uploads/2013/06/leite-creme.jpg");
insert into Dish(DishId,DishName,Price,DishDescription,MenuId,DishPhoto) values (466,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",92,"https://static.clubedaanamariabraga.com.br/wp-content/uploads/2019/01/mousse-de-chocolate-light.jpg");

-- RestaurantMenu --
-- Restaurant 1 --
insert into RestaurantMenu(RestaurantId,MenuId) values (001,01); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (001,02); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (001,03); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (001,04); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (001,05); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (001,06); -- DESSERT --

-- Restaurant 2 --
insert into RestaurantMenu(RestaurantId,MenuId) values (002,07); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (002,08); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (002,09); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (002,10); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (002,11); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (002,12); -- DESSERT --

-- Restaurant 3 --
insert into RestaurantMenu(RestaurantId,MenuId) values (003,13); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (003,14); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (003,15); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (003,16); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (003,17); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (003,18); -- DESSERT --

-- Restaurant 4 --
insert into RestaurantMenu(RestaurantId,MenuId) values (004,19); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (004,20); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (004,21); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (004,22); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (004,23); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (004,24); -- DESSERT --

-- Restaurant 5 --
insert into RestaurantMenu(RestaurantId,MenuId) values (005,25); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (005,26); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (005,27); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (005,28); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (005,29); -- DESSERT --

-- Restaurant 6 --
insert into RestaurantMenu(RestaurantId,MenuId) values (006,30); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (006,31); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (006,32); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (006,33); -- DRINK --

-- Restaurant 7 --
insert into RestaurantMenu(RestaurantId,MenuId) values (007,34); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (007,35); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (007,36); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (007,37); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (007,38); -- DRINK --

-- Restaurant 8 --
insert into RestaurantMenu(RestaurantId,MenuId) values (008,39); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (008,40); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (008,41); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (008,42); -- DRINK --

-- Restaurant 9 --
insert into RestaurantMenu(RestaurantId,MenuId) values (009,43); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (009,44); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (009,45); -- DRINK --

-- Restaurant 10 --
insert into RestaurantMenu(RestaurantId,MenuId) values (010,46); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (010,47); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (010,48); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (010,49); -- DRINK --

-- Restaurant 11 --
insert into RestaurantMenu(RestaurantId,MenuId) values (011,50); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (011,51); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (011,52); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (011,53); -- DRINK --

-- Restaurant 12 --
insert into RestaurantMenu(RestaurantId,MenuId) values (012,54); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (012,55); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (012,56); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (012,57); -- DESSERT --

-- Restaurant 13 --
insert into RestaurantMenu(RestaurantId,MenuId) values (013,58); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (013,59); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (013,60); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (013,61); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (013,62); -- DRINK --

-- Restaurant 14 --
insert into RestaurantMenu(RestaurantId,MenuId) values (014,63); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (014,64); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (014,65); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (014,66); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (014,67); -- DESSERT --

-- Restaurant 15 --
insert into RestaurantMenu(RestaurantId,MenuId) values (015,68); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (015,69); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (015,70); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (015,71); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (015,72); -- DESSERT --

-- Restaurant 16 --
insert into RestaurantMenu(RestaurantId,MenuId) values (016,73); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (016,74); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (016,75); -- DRINK --

-- Restaurant 17 --
insert into RestaurantMenu(RestaurantId,MenuId) values (017,76); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (017,77); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (017,78); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (017,79); -- DRINK --

-- Restaurant 18 --
insert into RestaurantMenu(RestaurantId,MenuId) values (018,80); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (018,81); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (018,82); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (018,83); -- DESSERT --

-- Restaurant 19 --
insert into RestaurantMenu(RestaurantId,MenuId) values (019,84); -- APPETIZER --
insert into RestaurantMenu(RestaurantId,MenuId) values (019,85); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (019,86); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (019,87); -- DRINK --

-- Restaurant 20 --
insert into RestaurantMenu(RestaurantId,MenuId) values (020,88); -- SOUP --
insert into RestaurantMenu(RestaurantId,MenuId) values (020,89); -- MEAT --
insert into RestaurantMenu(RestaurantId,MenuId) values (020,90); -- FISH --
insert into RestaurantMenu(RestaurantId,MenuId) values (020,91); -- DRINK --
insert into RestaurantMenu(RestaurantId,MenuId) values (020,92); -- DESSERT --

-- Users (testes) --
insert into Users(UserId, FirstLastName, Username, Password, UserAddress, PhoneNumber, RestaurantId) values (1, 'Henrique Vicente', 'Hacker', '2d7cd852faf790678785453124f3b4f5d5d25860', 'rua teste 1', 936108692, 1);
insert into Users(UserId, FirstLastName, Username, Password, UserAddress, PhoneNumber, RestaurantId) values (2, 'Daniela Tomás', 'Daniela', '2d7cd852faf790678785453124f3b4f5d5d25860', 'rua teste 2', 912345678, 2);


-- Orders --
insert into Orders(OrderId,OrderStatus,RestaurantId,UserId) values (1,"Pendente",1,1);

-- DishOrders --
insert into DishOrder(DishId,OrderId) values (1,1);

-- Admin --
insert into Administrator(UserId)values(1);