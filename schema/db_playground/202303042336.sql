use playground;

DROP PROCEDURE IF EXISTS td_user;
DROP PROCEDURE IF EXISTS td_chat;
DROP PROCEDURE IF EXISTS td_chatroom;
DROP PROCEDURE IF EXISTS td_friend;


DELIMITER ;;
CREATE PROCEDURE IF NOT EXISTS td_user (IN insert_num INTEGER)
BEGIN
    DECLARE i INTEGER DEFAULT 1;
    DECLARE cnt INTEGER DEFAULT 0;
    SET i = (SELECT IFNULL(MAX(id),0) FROM USER);
    SET cnt = insert_num + i;
    START TRANSACTION;
    WHILE i < cnt DO
        -- user table insert
        INSERT IGNORE INTO USER
            (id, status, name, email, password)
                values
                    (i,'ACTIVATE',CONCAT('N',i),CONCAT('email',i,'@email.com'),MD5(CONCAT('PASSWORD',i)));
        -- user_profile table insert
        INSERT IGNORE INTO USER_PROFILE (id, user_id, nick, phone_num, gender, image_url, background_url)
        values (i, i, CONCAT('NICK', i), CONCAT('010-', LPAD((i/10000) % 10000,4,'0'),'-', LPAD((i % 10000),4,'0')), IF((i % 2) = 0, 'M', 'F'), CONCAT('IMAGE_URL_', i), CONCAT('BACKGROUND_URL_', i));
        SET i = i + 1;
        end while ;
    COMMIT;
end ;;
DELIMITER ;


-- create procedure
DELIMITER ;;
CREATE PROCEDURE IF NOT EXISTS td_chat(IN chat_num INTEGER)
BEGIN
    DECLARE v_i INTEGER DEFAULT 0;
    DECLARE v_chatroom_id INTEGER DEFAULT 1;
    DECLARE v_user_id INTEGER DEFAULT 1;

    DECLARE v_rand_chatroom_member CURSOR FOR
    SELECT chatroom_id,user_id FROM CHATROOM_MEMBER ORDER BY RAND() LIMIT 1;

    START TRANSACTION;
    WHILE v_i < chat_num DO
        OPEN v_rand_chatroom_member;
        FETCH v_rand_chatroom_member INTO v_chatroom_id, v_user_id;
        CLOSE v_rand_chatroom_member;

        INSERT INTO CHAT (chatroom_id, user_id, content)
        VALUES (v_chatroom_id, v_user_id, CONCAT('CONTENT',v_i));

        SET v_i = v_i + 1;
        END WHILE;
    COMMIT;
end;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE IF NOT EXISTS td_chatroom(IN chatroom_num INTEGER)
BEGIN
    DECLARE i INTEGER DEFAULT 1;
    DECLARE j INTEGER DEFAULT 0;
    DECLARE cnt INTEGER DEFAULT 0;
    DECLARE user_max_id INTEGER DEFAULT 0;
    DECLARE chatroom_user_count INTEGER DEFAULT 0;
    DECLARE random_user_id INTEGER DEFAULT 1;

    -- 
    DECLARE random_user_id_duplicate CONDITION FOR SQLSTATE '23000';
    DECLARE CONTINUE HANDLER FOR random_user_id_duplicate
        BEGIN
            SET random_user_id = (FLOOR(RAND()*user_max_id));
        end ;

    SET i = (SELECT IFNULL(MAX(id)+1,1) FROM CHATROOM);
    SET cnt = i + chatroom_num;
    SET user_max_id = (SELECT IFNULL(MAX(id),1) FROM USER);

    START TRANSACTION;
    WHILE i < cnt DO
        SET chatroom_user_count = (FLOOR(RAND()*200));
        INSERT INTO CHATROOM (id, user_count) VALUES (i,chatroom_user_count);

        WHILE j < chatroom_user_count DO
            SET random_user_id = (FLOOR(RAND()*user_max_id));
            INSERT INTO CHATROOM_MEMBER (chatroom_id, user_id) values (i,random_user_id);
            SET j = j + 1;
            end while;
        SET j = 0;

        SET i = i + 1;
        end while;
    COMMIT;
end;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE IF NOT EXISTS td_friend(IN friend_num INTEGER)
BEGIN
    DECLARE v_counter INTEGER DEFAULT 0;
    DECLARE v_user_max_id INTEGER DEFAULT 1;

    SET v_user_max_id = (SELECT IFNULL(MAX(id),1) FROM USER);

    START TRANSACTION ;
    WHILE v_counter < friend_num DO
        INSERT IGNORE INTO FRIEND (user_id, friend_id) VALUES (RAND() * v_user_max_id, RAND() * v_user_max_id);
        SET v_counter = v_counter + 1;
        end while;
    COMMIT;
end;;
DELIMITER ;