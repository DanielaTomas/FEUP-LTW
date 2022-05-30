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
    Photo varchar(2083),
    PromotionId int references Promotion ON DELETE CASCADE
                                                  ON UPDATE CASCADE,  
    MenuId int NOT NULL references Menu ON DELETE CASCADE
                                        ON UPDATE CASCADE
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

insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (001,"The Vintage Dinner","https://i.pinimg.com/564x/f2/af/fd/f2affd7d5d19e280cb8dc03fbe07313a.jpg",001);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (002,"O Monarca","https://resizer.otstatic.com/v2/photos/wide-xlarge/3/46818715.jpg",002);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (003,"Little Persia","https://b.zmtcdn.com/data/reviews_photos/0e2/40f10f402cd0a12885b14009732120e2_1562593796.jpg",003);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (004,"Le Chapeau","https://media-cdn.tripadvisor.com/media/photo-s/11/b4/b5/81/salle-de-restaurant.jpg",004);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (005,"Quinta do Sabor","https://cms.infoportugal.info/media/pois/final/152/JRN.RE.29331-152597.JPG",005);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (006,"Brasa & Cia","https://res.cloudinary.com/tf-lab/image/upload/restaurant/ee987337-575f-411e-8f80-cb98c044c349/0fceab41-ea23-48aa-8859-4fae213e8782.jpg",006);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (007,"Casa da Sogra","https://media-cdn.tripadvisor.com/media/photo-s/17/10/c0/f7/casa-da-sogra.jpg",007);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (008,"Arigato","https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,g_auto:subject,q_auto,f_auto/restaurant/10f60a1c-2511-4780-9752-9102b789c838/cd6461cb-13ee-459b-a29f-3f6de81e9a14.jpg",008);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (009,"Station","https://images.squarespace-cdn.com/content/v1/5eecf28fbb27655754cf5b3c/1599665880697-1RZPDUVZVVQ7ZISLSJVA/Lounge%2BEast%2Bwall%2Bfacing%2BN.jpg?format=2500w",009);
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (010,"The Flavor","https://media-cdn.tripadvisor.com/media/photo-s/0a/f8/e7/67/caption.jpg",010); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (011,"Holy Moly","https://i2-prod.birminghammail.co.uk/incoming/article22429157.ece/ALTERNATES/s1200b/0_EntranceJPG.jpg",011); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (012,"Six Seven","https://www.thebespokeblackbook.com/wp-content/uploads/2018/05/sixseven-1024x613.jpg",012); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (013,"Porta 4","https://media.timeout.com/images/103977741/750/422/image.jpg",013); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (014,"Pátio do Duque","https://10619-2.s.cdn12.com/rests/small/w550/h367/802_503287925.jpg",014); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (015,"Amour Bistrô","https://b.zmtcdn.com/data/pictures/0/306320/5da09ff3658fe7cf3de34599cbc909a7.jpeg",015); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (016,"Alma","https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,g_auto:subject,q_auto,f_auto/restaurant/5df82aae-3bf0-4ac7-93f1-b400c38f95c2/c9c6531c-ff49-4e7a-a827-ec9759b34b27.jpg",016); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (017,"Casserole","https://media-cdn.tripadvisor.com/media/photo-s/1a/e6/34/08/casserole.jpg",017); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (018,"O Botequim","https://res.cloudinary.com/tf-lab/image/upload/restaurant/db7613a2-9a80-4e4c-90ef-4ee1e61c056e/263ef65c-b3ef-469c-b093-ce635a894f55.jpg",018); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (019,"Dom Joaquim","https://foodle.pro/restaurants-images/2017-07-17-22-25-44-263434_1.jpg",019); 
insert into Restaurant(RestaurantId,RestaurantName,RestaurantPhoto,UserId) values (020,"O Marinheiro","https://media-cdn.tripadvisor.com/media/photo-s/19/62/6b/c1/nova-imagem-de-o-marinheiro.jpg",020); 

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
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (001,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (002,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (003,"Melão com presunto",5,"Melão com presunto.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (004,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (005,"Rodelas de salpicão",3,"Rodelas de salpicão.",01);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (006,"Bruschettas",1.5,"Pão torrado na grelha com tomate e manjericão",07);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (007,"Rissol de carne",0.9,"Pastel salgado recheado com carnes variadas.",07);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (008,"Rissol de camarão",0.9,"Pastel salgado recheado com camarão.",07);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (009,"Carpaccio",3,"Carne crua cortada em fatias finas.",07);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (010,"Polenta",3,"Polenta frita com queijo ralado.",07);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (011,"Pão de alho",1.5,"Pão tostado com mistura de alho, azeite, manteiga e oregãos.",13);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (012,"Cocktail de camarão",8,"Camarões cozidos com casca num molho servido num copo.",13);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (013,"Pastel de bacalhau",0.9,"Pastel recheado com bacalhau.",13);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (014,"Cogumelos recheados",4,"Cogumelos recheados com ovos e farinheira.",13);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (015,"Salada de carpese",3,"Salada feita de mussarela fresca fatiada, tomate e manjericão.",13);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (016,"Amendoins, tremoços e azeitonas",5,"Amendoins, tremoços e azeitonas.",19);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (017,"Pão recheado",2,"Pão recheado com queijo e chouriço.",19);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (018,"Melão com presunto",5,"Melão com presunto.",19);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (019,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",19);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (020,"Rodelas de salpicão",3,"Rodelas de salpicão.",19);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (021,"Patê de delicias do mar",2,"Preparação cremosa à base de delicias do mar para comer com com pão.",25);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (022,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",25);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (023,"Melão com presunto",5,"Melão com presunto.",25);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (024,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",25);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (025,"Rodelas de salpicão",3,"Rodelas de salpicão.",25);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (026,"Chouriço assado",2,"Chouriço assado sobre a grelha do assador de barro.",30);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (027,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",30);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (028,"Melão com presunto",5,"Melão com presunto.",30);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (029,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",30);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (030,"Rodelas de salpicão",3,"Rodelas de salpicão.",30);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (031,"Alheira",5,"Alheira assada no forno.",34);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (032,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",34);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (033,"Melão com presunto",5,"Melão com presunto.",34);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (034,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",34);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (035,"Rodelas de salpicão",3,"Rodelas de salpicão.",34);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (036,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",39);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (037,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",39);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (038,"Melão com presunto",5,"Melão com presunto.",39);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (039,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",39);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (040,"Rodelas de salpicão",3,"Rodelas de salpicão.",39);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (041,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",50);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (042,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",50);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (043,"Melão com presunto",5,"Melão com presunto.",50);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (044,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",50);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (045,"Rodelas de salpicão",3,"Rodelas de salpicão.",50);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (046,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",58);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (047,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",58);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (048,"Melão com presunto",5,"Melão com presunto.",58);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (049,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",58);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (050,"Rodelas de salpicão",3,"Rodelas de salpicão.",58);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (051,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",63);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (052,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",63);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (053,"Melão com presunto",5,"Melão com presunto.",63);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (054,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",63);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (055,"Rodelas de salpicão",3,"Rodelas de salpicão.",63);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (056,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",84);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (057,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",84);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (058,"Melão com presunto",5,"Melão com presunto.",84);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (059,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",84);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (060,"Rodelas de salpicão",3,"Rodelas de salpicão.",84);

-- SOUP --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (061,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (062,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (063,"Creme de espargos",9.,"Sopa com espargos.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (064,"Sopa de agrião",1.4,"Sopa de agrião.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (065,"Sopa de legumes",1.2,"Sopa com legumes.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (066,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",02);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (067,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",08);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (068,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",08);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (069,"Creme de espargos",9.,"Sopa com espargos.",08);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (070,"Sopa de agrião",1.4,"Sopa de agrião.",08);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (071,"Sopa de legumes",1.2,"Sopa com legumes.",08);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (072,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",08);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (073,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",14);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (074,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",14);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (075,"Creme de espargos",9.,"Sopa com espargos.",14);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (076,"Sopa de agrião",1.4,"Sopa de agrião.",14);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (077,"Sopa de legumes",1.2,"Sopa com legumes.",14);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (078,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",14);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (079,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",20);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (080,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",20);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (081,"Creme de espargos",9.,"Sopa com espargos.",20);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (082,"Sopa de agrião",1.4,"Sopa de agrião.",20);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (083,"Sopa de legumes",1.2,"Sopa com legumes.",20);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (084,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",20);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (085,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",35);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (086,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",35);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (087,"Creme de espargos",9.,"Sopa com espargos.",35);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (088,"Sopa de agrião",1.4,"Sopa de agrião.",35);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (089,"Sopa de legumes",1.2,"Sopa com legumes.",35);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (090,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",35);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (091,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",46);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (092,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",46);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (093,"Creme de espargos",9.,"Sopa com espargos.",46);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (094,"Sopa de agrião",1.4,"Sopa de agrião.",46);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (095,"Sopa de legumes",1.2,"Sopa com legumes.",46);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (096,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",46);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (097,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",59);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (098,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",59);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (099,"Creme de espargos",9.,"Sopa com espargos.",59);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (100,"Sopa de agrião",1.4,"Sopa de agrião.",59);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (101,"Sopa de legumes",1.2,"Sopa com legumes.",59);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (102,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",59);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (103,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",68);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (104,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",68);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (105,"Creme de espargos",9.,"Sopa com espargos.",68);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (106,"Sopa de agrião",1.4,"Sopa de agrião.",68);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (107,"Sopa de legumes",1.2,"Sopa com legumes.",68);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (108,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",68);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (109,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",76);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (110,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",76);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (111,"Creme de espargos",9.,"Sopa com espargos.",76);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (112,"Sopa de agrião",1.4,"Sopa de agrião.",76);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (113,"Sopa de legumes",1.2,"Sopa com legumes.",76);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (114,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",76);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (115,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",88);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (116,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",88);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (117,"Creme de espargos",9.,"Sopa com espargos.",88);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (118,"Sopa de agrião",1.4,"Sopa de agrião.",88);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (119,"Sopa de legumes",1.2,"Sopa com legumes.",88);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (120,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",88);

-- MEAT --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (121,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (122,"Filé mignon",19.99,"Carne bovina fatiada com batata.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (123,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (124,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (125,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (126,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (127,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",03);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (128,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",09);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (129,"Filé mignon",19.99,"Carne bovina fatiada com batata.",09);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (130,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",09);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (131,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",09);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (132,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",09);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (133,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",09);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (134,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",09);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (135,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",15);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (136,"Filé mignon",19.99,"Carne bovina fatiada com batata.",15);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (137,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",15);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (138,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",15);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (139,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",15);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (140,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",15);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (141,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",15);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (142,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",21);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (143,"Filé mignon",19.99,"Carne bovina fatiada com batata.",21);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (144,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",21);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (145,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",21);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (146,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",21);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (147,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",21);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (148,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",21);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (149,"Filé mignon",19.99,"Carne bovina fatiada com batata.",26);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (150,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",26);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (151,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",26);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (152,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",26);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (153,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",26);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (154,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",26);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (155,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",31);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (156,"Filé mignon",19.99,"Carne bovina fatiada com batata.",31);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (157,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",31);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (158,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",31);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (159,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",31);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (160,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",31);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (161,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",31);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (162,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",36);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (163,"Filé mignon",19.99,"Carne bovina fatiada com batata.",36);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (164,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",36);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (165,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",36);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (166,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",36);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (167,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",36);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (168,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",36);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (169,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",40);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (170,"Filé mignon",19.99,"Carne bovina fatiada com batata.",40);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (171,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",40);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (172,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",40);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (173,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",40);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (174,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",40);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (175,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",40);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (176,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",43);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (177,"Filé mignon",19.99,"Carne bovina fatiada com batata.",43);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (178,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",43);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (179,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",43);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (180,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",43);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (181,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",43);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (182,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",43);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (183,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",47);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (184,"Filé mignon",19.99,"Carne bovina fatiada com batata.",47);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (185,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",47);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (186,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",47);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (187,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",47);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (188,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",47);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (189,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",47);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (190,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",51);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (191,"Filé mignon",19.99,"Carne bovina fatiada com batata.",51);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (192,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",51);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (193,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",51);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (194,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",51);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (195,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",51);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (196,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",51);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (197,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",54);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (198,"Filé mignon",19.99,"Carne bovina fatiada com batata.",54);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (199,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",54);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (200,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",54);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (201,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",54);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (202,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",54);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (203,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",54);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (204,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",60);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (205,"Filé mignon",19.99,"Carne bovina fatiada com batata.",60);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (206,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",60);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (207,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",60);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (208,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",60);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (209,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",60);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (210,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",60);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (211,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",64);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (212,"Filé mignon",19.99,"Carne bovina fatiada com batata.",64);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (213,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",64);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (214,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",64);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (215,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",64);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (216,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",64);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (217,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",64);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (218,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",69);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (219,"Filé mignon",19.99,"Carne bovina fatiada com batata.",69);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (220,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",69);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (221,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",69);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (222,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",69);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (223,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",69);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (224,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",69);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (225,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",73);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (226,"Filé mignon",19.99,"Carne bovina fatiada com batata.",73);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (227,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",73);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (228,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",73);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (229,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",73);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (230,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",73);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (231,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",73);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (232,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",77);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (233,"Filé mignon",19.99,"Carne bovina fatiada com batata.",77);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (234,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",77);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (235,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",77);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (236,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",77);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (237,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",77);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (238,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",77);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (239,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",80);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (240,"Filé mignon",19.99,"Carne bovina fatiada com batata.",80);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (241,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",80);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (242,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",80);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (243,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",80);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (244,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",80);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (245,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",80);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (246,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",85);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (247,"Filé mignon",19.99,"Carne bovina fatiada com batata.",85);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (248,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",85);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (249,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",85);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (250,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",85);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (251,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",85);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (252,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",85);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (253,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",89);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (254,"Filé mignon",19.99,"Carne bovina fatiada com batata.",89);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (255,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",89);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (256,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",89);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (257,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",89);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (258,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",89);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (259,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",89);

-- FISH --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (260,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (261,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (262,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (263,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (264,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (265,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (266,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (267,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (268,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",04);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (269,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (270,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (271,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (272,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (273,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (274,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (275,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (276,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",10);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (277,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",10);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (278,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (279,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (280,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (281,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (282,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (283,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (284,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (285,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",16);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (286,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",16);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (287,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",22);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (288,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",22);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (289,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",22);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (290,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",22);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (291,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",22);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (292,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",22);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (293,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",22);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (294,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (295,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (296,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (297,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (298,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (299,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (300,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (301,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",27);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (302,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",27);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (303,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (304,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (305,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (306,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (307,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (308,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (309,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (310,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",32);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (311,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",32);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (3000,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",37);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (312,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",41);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (313,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",41);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (314,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",41);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (315,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",41);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (316,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",44);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (317,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",44);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (318,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",44);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (319,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",44);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (320,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",48);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (321,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",48);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (322,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",48);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (323,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",48);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (324,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",52);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (325,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",52);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (326,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",52);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (327,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",52);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (328,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",55);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (329,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",55);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (330,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",55);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (331,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",55);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (332,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",61);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (333,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",61);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (334,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",61);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (335,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",61);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (336,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",65);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (337,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",65);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (338,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",65);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (339,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",65);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (340,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",70);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (341,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",70);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (342,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",70);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (343,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",70);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (344,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",74);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (345,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",74);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (346,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",74);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (347,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",74);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (348,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",78);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (349,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",78);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (350,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",78);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (351,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",78);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (352,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",81);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (353,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",81);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (354,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",81);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (355,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",81);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (356,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",86);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (357,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",86);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (358,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",86);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (359,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",86);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (360,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",90);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (361,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",90);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (362,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",90);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (363,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",90);

-- DRINK --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (364,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (365,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (366,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (367,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (368,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (369,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",05);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (370,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",11);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (371,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",11);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (372,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",11);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (373,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",11);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (374,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",11);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (375,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",11);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (376,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",17);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (377,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",17);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (378,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",17);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (379,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",17);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (380,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",17);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (381,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",17);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (382,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",23);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (383,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",23);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (384,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",23);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (385,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",23);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (386,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",23);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (387,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",23);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (388,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",28);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (389,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",28);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (390,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",28);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (391,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",33);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (392,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",33);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (393,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",33);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (394,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",38);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (395,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",38);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (396,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",38);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (397,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",42);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (398,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",42);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (399,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",42);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (400,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",45);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (401,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",45);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (402,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",45);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (403,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",49);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (404,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",49);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (405,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",49);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (406,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",53);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (407,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",53);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (408,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",53);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (409,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",56);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (410,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",56);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (411,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",56);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (412,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",62);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (413,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",62);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (414,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",62);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (415,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",66);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (416,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",66);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (417,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",66);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (418,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",71);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (419,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",71);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (420,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",71);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (421,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",75);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (422,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",75);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (423,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",75);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (424,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",79);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (425,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",79);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (426,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",79);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (427,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",82);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (428,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",82);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (429,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",82);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (430,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",87);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (431,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",87);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (432,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",87);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (433,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",91);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (434,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",91);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (435,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",91);

-- DESSERT --
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (436,"Arroz doce",2.5,"Arroz  com sabor adocicado.",06);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (437,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",06);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (438,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",06);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (439,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",06);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (440,"Arroz doce",2.5,"Arroz  com sabor adocicado.",12);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (441,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",12);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (442,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",12);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (443,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",12);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (444,"Arroz doce",2.5,"Arroz  com sabor adocicado.",18);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (445,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",18);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (446,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",18);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (447,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",18);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (448,"Arroz doce",2.5,"Arroz  com sabor adocicado.",24);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (449,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",24);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (450,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",24);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (451,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",24);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (452,"Arroz doce",2.5,"Arroz  com sabor adocicado.",29);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (453,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",29);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (454,"Arroz doce",2.5,"Arroz  com sabor adocicado.",57);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (455,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",57);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (456,"Arroz doce",2.5,"Arroz  com sabor adocicado.",67);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (457,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",67);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (458,"Arroz doce",2.5,"Arroz  com sabor adocicado.",72);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (459,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",72);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (460,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",72);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (461,"Arroz doce",2.5,"Arroz  com sabor adocicado.",83);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (462,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",83);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (463,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",83);

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (464,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",92);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (465,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",92);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (466,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",92);

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
insert into Users(UserId, FirstLastName, Username, Password, UserAddress, PhoneNumber, RestaurantId) values (1, 'Henrique Vicente', 'Hacker', '2d7cd852faf790678785453124f3b4f5d5d25860', 'rua teste', 936108692, 1);