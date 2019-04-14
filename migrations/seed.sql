INSERT INTO buildings (building_name)
VALUES ('Watson')
     , ('Davis')
     , ('Burton')
     , ('Goodhue')
;

INSERT INTO rooms (room_number, building_name, floor)
VALUES ('122', 'Watson', 1)
     , ('313', 'Watson', 3)
     , ('306', 'Watson', 3)
     , ('204', 'Davis', 2)
     , ('317', 'Burton', 3)
     , ('510', 'Watson', 5)
;

INSERT INTO reviews (review_id, room_number, building_name, rating, comment)
VALUES (1, '122', 'Watson', 10,
        'This room is the best. The windows are huge. The room is huge. Easy to arrange the furniture. Wonderful.')
     , (2, '313', 'Watson', 7,
        'This is a very cozy room that has everything you need. Do not expect a lot of room, because there is not.')
     , (3, '306', 'Watson', 2,
        'Very big, for a single, has a closet, but it has a crack in the wall so if your neighbor is ' ||
        'stinky, or a pot-head, it might get smelly.')
     , (4, '204', 'Davis', 1, 'Smells like Bum Simmons.')
;

INSERT INTO buildings_tags (tag_name, building_name)
VALUES ('Thin Walls', 'Watson')
     , ('Smells Weird', 'Watson')
;

INSERT INTO rooms_tags (tag_name, room_number, building_name)
VALUES ('Smells Weird', '122', 'Watson')
     , ('Good View', '313', 'Watson')
;