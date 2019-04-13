INSERT INTO buildings (building_id, name)
VALUES (1, 'Watson')
     , (2, 'Davis')
     , (3, 'Burton')
     , (4, 'Goodhue')
;

INSERT INTO rooms (room_id, room_number, building_id, floor)
VALUES (1, '122', 2, 1)
     , (2, '313', 1, 3)
     , (3, '306', 1, 3)
     , (4, '204', 2, 2)
     , (5, '317', 3, 3)
     , (6, '510', 1, 5)
;

INSERT INTO reviews (review_id, room_id, rating, comment)
VALUES (1, 6, 10,
        'This room is the best. The windows are huge. The room is huge. Easy to arrange the furniture. Wonderful.')
     , (2, 4, 7,
        'This is a very cozy room that has everything you need. Do not expect a lot of room, because there is not.')
     , (3, 5, 8, 'Very big, for a single, has a closet, but it has a crack in the wall so if your neighbor is ' ||
                 'stinky, or a pot-head, it might get smelly.')
     , (4, 3, 2, 'Smells like Bum Simmons.')
;

INSERT INTO buildings_tags (tag_name, building_id)
VALUES ('Thin Walls', 4)
     , ('Smells Weird', 1)
;

INSERT INTO rooms_tags (tag_name, room_id)
VALUES ('Smells Weird', 3)
     , ('Good View', 6)
;
