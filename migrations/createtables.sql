CREATE TABLE buildings
(
    building_id SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE rooms
(
    room_id     SERIAL PRIMARY KEY,
    room_number VARCHAR(32) NOT NULL,
    building_id INT         NOT NULL REFERENCES buildings,
    floor       INT,
    UNIQUE (room_number, building_id)
);

CREATE TABLE reviews
(
    review_id SERIAL PRIMARY KEY,
    room_id   INT NOT NULL REFERENCES rooms,
    rating    INT,
    comment   TEXT
);

CREATE TABLE pictures
(
    picture_id SERIAL PRIMARY KEY,
    room_id    INT          NOT NULL REFERENCES rooms,
    review_id  INT REFERENCES reviews,
    url        VARCHAR(255) NOT NULL
);

CREATE TABLE buildings_tags
(
    building_id INT          NOT NULL REFERENCES buildings,
    tag_name    VARCHAR(255) NOT NULL REFERENCES tags,
    agree_count INT NOT NULL DEFAULT 0,
    disagree_count INT NOT NULL DEFAULT 0,
    PRIMARY KEY (building_id, tag_name)
);

CREATE TABLE rooms_tags
(
    room_id  INT          NOT NULL REFERENCES rooms,
    tag_name VARCHAR(255) NOT NULL REFERENCES tags,
    agree_count INT NOT NULL DEFAULT 0,
    disagree_count INT NOT NULL DEFAULT 0,
    PRIMARY KEY (room_id, tag_name)
);
