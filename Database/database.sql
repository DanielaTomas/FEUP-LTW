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

-- Dishes --

insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (001,"Azeitonas à Dom Pedro",5,"Azeitonas à Dom Pedro.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (002,"Croquetes",0.9,"Bolinho recheado com diversos tipos de carne.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (003,"Melão com presunto",5,"Melão com presunto.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (004,"Queijinho de ovelha",4,"Cubos de queijo de ovelha.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (005,"Rodelas de salpicão",3,"Rodelas de salpicão.",01);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (006,"Caldo verde",2,"Sopa constituída por couve galega, batata, cebola e duas rodelas de chouriço.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (007,"Canja de galinha",2,"Canja com massa, frango, ovo, cenoura e salpicão.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (008,"Creme de espargos",9.,"Sopa com espargos.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (009,"Sopa de agrião",1.4,"Sopa de agrião.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (010,"Sopa de legumes",1.2,"Sopa com legumes.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (011,"Sopa do mar",2,"Sopa com peixe, camarões cozidos e ameijoas.",02);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (012,"Costoletas de borrego grealhadas",8.5,"Costoletas de borrego grealhadas com arroz e batata frita.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (013,"Filé mignon",19.99,"Carne bovina fatiada com batata.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (014,"Frango assado na grelha",7.9,"Frango assado com arroz e/ou batata.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (015,"Iscas de porco à portuguesa",8.9,"Iscas de porco à portuguesa com batata cozida.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (016,"Leitão assado à moda da bairrada",9.5,"Leitão assado com batata frita de rodela, legumes e, se pretender, molho picante",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (017,"Picanha",25,"Prato de picanha com arroz e/ou batata. Molho picante se pretender.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (018,"Rosbeef beurre maître d'hôtel",13,"Bife temperado com manteiga.",03);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (019,"Ameijoas à Bulhão Pato",12.5,"Ameijoas com um gosto mais apetitoso.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (020,"Bacalhau à brás",3.5,"Bacalhau com batatas fritas, ovo, azeitonas, salsa e uma folha de louro",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (021,"Bacalhau à lagareiro",10.5,"Bacalhau com legumes, batata a murro, cebola e pimento.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (022,"Carapaus grelhados com legumes",9,"Carapaus grelhados com legumes.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (023,"Dourada grelhada com legumes",9,"Dourada grelhada com legumes.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (024,"Peixe espada grelhado",9,"Peixe espada grelhado. Pode pedir acompanhante.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (025,"Polvo à lagareiro",13,"Polvo com batata a murro, bocados de alho francês e salsa.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (026,"Salmão grelhado",15,"Salmão grelhado com batata a murro.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (027,"Sardinhas assadas com salada mista",7.9,"Sardinhas assadas com salada mista.",04);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (028,"Coca-cola 33cl",1,"Coca-cola numa lata de 33cl.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (029,"Pepsi max 33cl",1,"Pepsi max numa lata de 33cl.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (030,"Vinho branco 0.375",3.5,"Vinho branco num jarro de 0.375.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (031,"Vinho branco 0.75",7.5,"Vinho branco num jarro de 0.75.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (032,"Vinho tinto 0.375",3.5,"Vinho tinto num jarro de 0.375.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (033,"Vinho tinto 0.75",7.5,"Vinho tinto num jarro de 0.75.",05);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (034,"Arroz doce",2.5,"Arooz  com sabor adocicado.",06);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (035,"Gelado de chocolate",2.5,"Chocolate em forma de bola gelada.",06);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (036,"Leite creme",2.5,"Leite em forma de iogurte com açúcar torrado.",06);
insert into Dish(DishId,DishName,Price,DishDescription,MenuId) values (037,"Mousse de chocolate",2.5,"Chocolate em forma de papa.",06);

-- RestaurantMenu --

insert into RestaurantMenu(RestaurantId,MenuId) values (001,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (001,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (001,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (002,01);
insert into RestaurantMenu(RestaurantId,MenuId) values (002,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (002,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (002,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (003,02);
insert into RestaurantMenu(RestaurantId,MenuId) values (003,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (003,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (003,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (004,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (004,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (004,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (004,06);
insert into RestaurantMenu(RestaurantId,MenuId) values (005,01);
insert into RestaurantMenu(RestaurantId,MenuId) values (005,02);
insert into RestaurantMenu(RestaurantId,MenuId) values (005,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (005,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (005,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (006,01);
insert into RestaurantMenu(RestaurantId,MenuId) values (006,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (006,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (006,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (006,06);
insert into RestaurantMenu(RestaurantId,MenuId) values (007,02);
insert into RestaurantMenu(RestaurantId,MenuId) values (007,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (007,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (007,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (007,06);
insert into RestaurantMenu(RestaurantId,MenuId) values (008,01);
insert into RestaurantMenu(RestaurantId,MenuId) values (008,02);
insert into RestaurantMenu(RestaurantId,MenuId) values (008,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (008,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (008,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (008,06);
insert into RestaurantMenu(RestaurantId,MenuId) values (009,01);
insert into RestaurantMenu(RestaurantId,MenuId) values (009,02);
insert into RestaurantMenu(RestaurantId,MenuId) values (009,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (009,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (009,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (009,06);
insert into RestaurantMenu(RestaurantId,MenuId) values (010,01);
insert into RestaurantMenu(RestaurantId,MenuId) values (010,02);
insert into RestaurantMenu(RestaurantId,MenuId) values (010,03);
insert into RestaurantMenu(RestaurantId,MenuId) values (010,04);
insert into RestaurantMenu(RestaurantId,MenuId) values (010,05);
insert into RestaurantMenu(RestaurantId,MenuId) values (010,06);


-- Users (testes) --
insert into Users(UserId, FirstLastName, Username, Password, UserAddress, PhoneNumber, RestaurantId) values (1, 'Henrique Vicente', 'Hacker', '2d7cd852faf790678785453124f3b4f5d5d25860', 'rua teste', 936108692, 1);