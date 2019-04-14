CREATE TABLE buildings
(
    building_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (building_name)
);

CREATE TABLE rooms
(
    room_number   VARCHAR(32)  NOT NULL,
    building_name VARCHAR(255) NOT NULL,
    floor         INT,
    PRIMARY KEY (room_number, building_name),
    FOREIGN KEY (building_name) REFERENCES buildings
);

CREATE TABLE reviews
(
    review_id     SERIAL PRIMARY KEY,
    room_number   VARCHAR(32)  NOT NULL,
    building_name VARCHAR(255) NOT NULL,
    rating        INT,
    comment       TEXT,
    FOREIGN KEY (building_name) REFERENCES buildings,
    FOREIGN KEY (room_number, building_name) REFERENCES rooms
);

CREATE TABLE pictures
(
    picture_id    SERIAL PRIMARY KEY,
    room_number   VARCHAR(32)  NOT NULL,
    building_name VARCHAR(255) NOT NULL,
    review_id     INT REFERENCES reviews,
    url           VARCHAR(255) NOT NULL,
    FOREIGN KEY (building_name) REFERENCES buildings,
    FOREIGN KEY (room_number, building_name) REFERENCES rooms,
    FOREIGN KEY (review_id) REFERENCES reviews
);

CREATE TABLE buildings_tags
(
    building_name  VARCHAR(255) NOT NULL,
    tag_name       VARCHAR(255) NOT NULL,
    agree_count    INT          NOT NULL DEFAULT 0,
    disagree_count INT          NOT NULL DEFAULT 0,
    PRIMARY KEY (building_name, tag_name),
    FOREIGN KEY (building_name) REFERENCES buildings
);

CREATE TABLE rooms_tags
(
    room_number    VARCHAR(32)  NOT NULL,
    building_name  VARCHAR(255) NOT NULL,
    tag_name       VARCHAR(255) NOT NULL,
    agree_count    INT          NOT NULL DEFAULT 0,
    disagree_count INT          NOT NULL DEFAULT 0,
    PRIMARY KEY (room_number, building_name, tag_name),
    FOREIGN KEY (building_name) REFERENCES buildings,
    FOREIGN KEY (room_number, building_name) REFERENCES rooms
);
