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

CREATE TABLE tags
(
    tag_id SERIAL PRIMARY KEY,
    name   VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE buildings_tags
(
    building_id INT NOT NULL REFERENCES buildings,
    tag_id      INT NOT NULL REFERENCES tags,
    PRIMARY KEY (building_id, tag_id)
);

CREATE TABLE rooms_tags
(
    room_id INT NOT NULL REFERENCES rooms,
    tag_id  INT NOT NULL REFERENCES tags,
    PRIMARY KEY (room_id, tag_id)
);
