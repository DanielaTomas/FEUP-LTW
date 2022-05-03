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
drop table if exists User;
drop table if exists Restaurant;

-- Create Tables --

create table Restaurant(
    RestaurantId int PRIMARY KEY,
    RestaurantName varchar(80) constraint restaurantname_nn NOT NULL,
    RestaurantAddress varchar(70),
    Category varchar(30),
    UserId int constraint userid_nn NOT NULL references Administrator ON DELETE CASCADE
                                                                      ON UPDATE CASCADE   
);

create table User(
    UserId int PRIMARY KEY,
    FirstLastName varchar(60) constraint firstlastname_nn NOT NULL,
    Username varchar(50) constraint username_nn NOT NULL
                         constraint username_u UNIQUE,
    Password varchar(40) NOT NULL constraint password_nn NOT NULL,
    UserAddress varchar(70),
    PhoneNumber varchar(24),
    RestaurantId int constraint restaurantid_nn NOT NULL references Restaurant ON DELETE CASCADE
                                                                               ON UPDATE CASCADE 
);

create table Administrator(
    UserId int PRIMARY KEY references User ON DELETE CASCADE                                                                                
                                           ON UPDATE CASCADE
);

create table Orders(
    OrderId int PRIMARY KEY,
    Status varchar(60) constraint status_nn NOT NULL,
    RestaurantId int constraint restaurantid_nn NOT NULL references Restaurant ON DELETE CASCADE
                                                                               ON UPDATE CASCADE,  
    UserId int constraint userid_nn NOT NULL references User ON DELETE CASCADE
                                                             ON UPDATE CASCADE                                                                                
);

create table Review(
    ReviewId int PRIMARY KEY,
    Score float constraint score_c CHECK(Score >= 0 and Score <= 5),
    ReviewText varchar(250),
    RestaurantId int constraint restaurantid_nn NOT NULL references Restaurant ON DELETE CASCADE
                                                                               ON UPDATE CASCADE          
);

create table Comment(
    CommentId int PRIMARY KEY,
    AdminComment varchar(250),
    UserId int constraint userid_nn NOT NULL references Administrator ON DELETE CASCADE                                                                                
                                                                      ON UPDATE CASCADE
);

create table Menu(
    MenuId int PRIMARY KEY,
    MenuType text constraint menutype_c CHECK((MenuType = "APPETIZER" OR
                                               MenuType = "SOUP" OR
                                               MenuType = "MEAT" OR
                                               MenuType = "FISH" OR
                                               MenuType = "DRINK" OR
                                               MenuType = "DESSERT"))
);

create table Promotion(
    PromotionId int PRIMARY KEY,
    Value float constraint value_nn NOT NULL
                constraint value_c CHECK(Value >= 0)
);

create table Dish(
    DishId int PRIMARY KEY,
    DishName varchar(80) constraint dishname_nn NOT NULL,
    Price float constraint price_nn NOT NULL
                constraint price_c CHECK(price >= 0),          
    DishDescription varchar(150) constraint dishdescription_nn NOT NULL,
    Photo varchar(2083),
    PromotionId int constraint promotionid_nn NOT NULL references Promotion ON DELETE CASCADE
                                                                               ON UPDATE CASCADE,  
    MenuId int constraint menuid_nn NOT NULL references Menu ON DELETE CASCADE
                                                             ON UPDATE CASCADE
);

-- ** --

create table RestaurantMenu(
    RestaurantId int constraint restaurantid_nn NOT NULL references Restaurant ON DELETE CASCADE
                                                                               ON UPDATE CASCADE,  
    MenuId int constraint menuid_nn NOT NULL references Menu ON DELETE CASCADE
                                                             ON UPDATE CASCADE,  
    PRIMARY KEY (RestaurantId, MenuId)
);

create table DishOrder(
    DishId int constraint dishid_nn NOT NULL references Dish ON DELETE CASCADE
                                                             ON UPDATE CASCADE,  
    OrderId int constraint orderid_nn NOT NULL references Orders ON DELETE CASCADE
                                                                 ON UPDATE CASCADE,  
    PRIMARY KEY (DishId, OrderId)
);

create table PromotionAdmin(
    PromotionId int constraint promotionid_nn NOT NULL references Promotion ON DELETE CASCADE
                                                                            ON UPDATE CASCADE,  
    UserId int constraint userid_nn NOT NULL references Administrator ON DELETE CASCADE
                                                                      ON UPDATE CASCADE,  
    PRIMARY KEY (PromotionId, UserId)
);

-- Populate Tables --
/*
insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    001,
    "The Vintage Dinner"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    002,
    "O Monarca"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    003,
    "Little Persia"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    004,
    "Le Chapeau"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    005,
    "Quinta do Sabor"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    006,
    "Brasa & Cia"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    007,
    "Casa da Sogra"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    008,
    "Arigato"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    009,
    "Station"
);

insert into Restaurant(
    RestaurantId,
    RestaurantName
)
values(
    010,
    "The Flavor"
);
*/