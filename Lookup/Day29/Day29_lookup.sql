
-- Current Day1

SELECT `vh`.`BlockCode` AS `BlockCode`,`cd`.`PrsntVillage` AS `Village`,`vh`.`VID` AS `VID`,`cd`.`PrsntHamlet` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`PrsntAddress` AS `Addr`,`cd`.`PW_H_Name` AS `PW_H_Name`,`cd`.`Baby_numbers` AS `Baby_numbers`,`cd`.`PWID` AS `PWID`, DATE_FORMAT(`cd`.`BabyBirthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`mother_status` AS `mother_status`, DATE_FORMAT(`cd`.`Date_Created_Local`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`Unit`,2,'0') AS `Unit`,`cd`.`SubUnit` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`BabyEatMore`) > 0) OR (`cd`.`BabyFirstEat` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`Baby_clean` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`BabyBirthday` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Raw`.`CurrentDay1` `cd`
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`PWID`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`baby_status` = 2)))))

LEFT JOIN Emollient_Raw.CurrentDay7_Dispatch_download d7dp ON ((d7dp.PWID = cd.PWID) AND((d7dp.mother_status = 2) OR (d7dp.baby_status = 2)))

LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`PWID`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
LEFT JOIN `AMANHI_Raw`.`PSSVillHamWithID` `p` ON(((`p`.`Village` = `cd`.`PrsntVillage`) AND (`p`.`Hamlet` = `cd`.`PrsntHamlet`))))
LEFT JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `p`.`HID`)))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND ISNULL(d7dp.PWID) AND (`cd`.`Baby_birth_status` = 1) AND (NOW() BETWEEN (`cd`.`BabyBirthday` + INTERVAL 29 DAY) AND (`cd`.`BabyBirthday` + INTERVAL 45 DAY))) 


UNION

-- Day1 RR
SELECT `vh`.`BlockCode` AS `BlockCode`,`cd`.`PrsntVillage` AS `Village`,`vh`.`VID` AS `VID`,`cd`.`PrsntHamlet` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`PrsntAddress` AS `Addr`,`cd`.`PW_H_Name` AS `PW_H_Name`,`cd`.`Baby_numbers` AS `Baby_numbers`,`cd`.`PWID` AS `PWID`, DATE_FORMAT(`cd`.`BabyBirthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`mother_status` AS `mother_status`, DATE_FORMAT(`cd`.`Date_Created_Local`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`Unit`,2,'0') AS `Unit`,`cd`.`SubUnit` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`BabyEatMore`) > 0) OR (`cd`.`BabyFirstEat` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`Baby_clean` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`BabyBirthday` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Raw`.`EmoDay1_RR` `cd`
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`PWID`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`respon_ready` = 2) OR (`d7`.`baby_status` = 2)))))

LEFT JOIN Emollient_Raw.CurrentDay7_Dispatch_download d7dp ON ((d7dp.PWID = cd.PWID) AND((d7dp.mother_status = 2) OR (d7dp.baby_status = 2)))

LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`PWID`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
LEFT JOIN `AMANHI_Raw`.`PSSVillHamWithID` `p` ON(((`p`.`Village` = `cd`.`PrsntVillage`) AND (`p`.`Hamlet` = `cd`.`PrsntHamlet`))))
LEFT JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `p`.`HID`)))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND ISNULL(d7dp.PWID) AND (`cd`.`Baby_birth_status` = 1) AND (NOW() BETWEEN (`cd`.`BabyBirthday` + INTERVAL 29 DAY) AND (`cd`.`BabyBirthday` + INTERVAL 45 DAY))) 

UNION

-- Day 1 4.6
SELECT `vh`.`BlockCode` AS `BlockCode`,`cd`.`Prsnt_Village_1` AS `Village`,`vh`.`VID` AS `VID`,`cd`.`Prsnt_Hamlet_1` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`Prsnt_Address_1` AS `Addr`,`cd`.`PW_H_Name_1` AS `PW_H_Name`,`cd`.`Baby_numbers_1` AS `Baby_numbers`,`cd`.`PWID_1` AS `PWID`, DATE_FORMAT(`cd`.`Baby_Birthday_1`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`mother_status_1` AS `mother_status`, DATE_FORMAT(`cd`.`Form_Recorded_on_1`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`Unit_1`,2,'0') AS `Unit`,`cd`.`SubUnit_1` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`Baby_Eat_More_1_1`) > 0) OR (`cd`.`Baby_First_Eat_1_1` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`Baby_clean_1_1` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`Baby_Birthday_1` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Raw`.`Emo_day1_4_6` `cd`
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`PWID_1`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`respon_ready` = 2) OR (`d7`.`baby_status` = 2)))))

LEFT JOIN Emollient_Raw.CurrentDay7_Dispatch_download d7dp ON ((d7dp.PWID = cd.PWID_1) AND((d7dp.mother_status = 2) OR (d7dp.baby_status = 2)))


LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`PWID_1`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
LEFT JOIN `AMANHI_Raw`.`PSSVillHamWithID` `p` ON(((`p`.`Village` = `cd`.`Prsnt_Village_1`) AND (`p`.`Hamlet` = `cd`.`Prsnt_Hamlet_1`))))
LEFT JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `p`.`HID`)))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND ISNULL(d7dp.PWID) AND (`cd`.`Baby_birth_status_1_1` = 1) AND (NOW() BETWEEN (`cd`.`Baby_Birthday_1` + INTERVAL 29 DAY) AND (`cd`.`Baby_Birthday_1` + INTERVAL 45 DAY)))

 UNION
 -- Direct Day1 1.1
SELECT `vh`.`BlockCode` AS `BlockCode`,`cd`.`Village_Name_1` AS `Village`,`vh`.`VID` AS `VID`,`cd`.`Hamlet_Name_1` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`Address_1` AS `Addr`,`cd`.`PW_H_Name_1` AS `PW_H_Name`,`cd`.`Baby_numbers_1` AS `Baby_numbers`,`cd`.`temp_PWID` AS `PWID`, DATE_FORMAT(`cd`.`Baby_Birthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`Mother_Status_1` AS `mother_status`, DATE_FORMAT(`cd`.`Form_Recorded_on_1`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`Unit_1`,2,'0') AS `Unit`,`cd`.`SubUnit_1` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`Baby_Eat_More_1_1`) > 0) OR (`cd`.`Baby_First_Eat_1_1` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`Baby_clean_1_1` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`Baby_Birthday` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Raw`.`Emo_Direct_Day1_1_1` `cd`
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`temp_PWID`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`respon_ready` = 2) OR (`d7`.`baby_status` = 2)))))

LEFT JOIN Emollient_Raw.CurrentDay7_Dispatch_download d7dp ON ((d7dp.PWID = cd.temp_PWID) AND((d7dp.mother_status = 2) OR (d7dp.baby_status = 2)))

LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`temp_PWID`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
LEFT JOIN `AMANHI_Raw`.`PSSVillHamWithID` `p` ON(((`p`.`Village` = `cd`.`Village_Name_1`) AND (`p`.`Hamlet` = `cd`.`Hamlet_Name_1`))))
LEFT JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `p`.`HID`)))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND ISNULL(d7dp.PWID) AND (`cd`.`Baby_birth_status_1_1` = 1) AND (NOW() BETWEEN (`cd`.`Baby_Birthday` + INTERVAL 29 DAY) AND (`cd`.`Baby_Birthday` + INTERVAL 45 DAY))) 

UNION

-- Day1 Flat 5.1 for first baby
SELECT `vh`.`BlockCode` AS `BlockCode`,`vh`.`Village` AS `Village`,`vh`.`VID` AS `VID`,`vh`.`Hamlet` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`o_address` AS `Addr`,`cd`.`o_pw_h_name` AS `PW_H_Name`,`cd`.`o_baby_numbers` AS `Baby_numbers`,`cd`.`o_pwid` AS `PWID`, DATE_FORMAT(`cd`.`o_baby_birthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`o_mother_status` AS `mother_status`, DATE_FORMAT(`cd`.`Date_Created_Local`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`o_unit`,2,'0') AS `Unit`,`cd`.`o_subunit` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`o_baby_eat_more_1`) > 0) OR (`cd`.`o_baby_first_eat_1` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`o_baby_clean_1` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`o_baby_birthday` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Flat`.`Emo_Day1_Flat_5_1` `cd`
JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `cd`.`o_hid`)))
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`o_pwid`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay7_Dispatch_download` `dir7` ON(((`dir7`.`PWID` = `cd`.`o_pwid`) AND ((`dir7`.`mother_status` = 2) OR (`dir7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`o_pwid`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`dir7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND (`cd`.`o_baby_birth_status_1` = 1) AND (NOW() BETWEEN (`cd`.`o_baby_birthday` + INTERVAL 29 DAY) AND (`cd`.`o_baby_birthday` + INTERVAL 45 DAY)))

 UNION
 
 -- Day1 5.1 for second Baby
SELECT `vh`.`BlockCode` AS `BlockCode`,`vh`.`Village` AS `Village`,`vh`.`VID` AS `VID`,`vh`.`Hamlet` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`o_address` AS `Addr`,`cd`.`o_pw_h_name` AS `PW_H_Name`,`cd`.`o_baby_numbers` AS `Baby_numbers`,`cd`.`o_pwid` AS `PWID`, DATE_FORMAT(`cd`.`o_baby_birthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`o_mother_status` AS `mother_status`, DATE_FORMAT(`cd`.`Date_Created_Local`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`o_unit`,2,'0') AS `Unit`,`cd`.`o_subunit` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`o_baby_eat_more_2`) > 0) OR (`cd`.`o_baby_first_eat_2` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`o_baby_clean_2` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`o_baby_birthday` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Flat`.`Emo_Day1_Flat_5_1` `cd`
JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `cd`.`o_hid`)))
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`o_pwid`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay7_Dispatch_download` `dir7` ON(((`dir7`.`PWID` = `cd`.`o_pwid`) AND ((`dir7`.`mother_status` = 2) OR (`dir7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`o_pwid`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`dir7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND (`cd`.`o_baby_birth_status_2` = 1) AND (NOW() BETWEEN (`cd`.`o_baby_birthday` + INTERVAL 29 DAY) AND (`cd`.`o_baby_birthday` + INTERVAL 45 DAY))) 

UNION
--  Day1 5.1 for third Baby

SELECT `vh`.`BlockCode` AS `BlockCode`,`vh`.`Village` AS `Village`,`vh`.`VID` AS `VID`,`vh`.`Hamlet` AS `Hamlet`,`vh`.`HID` AS `HID`,`cd`.`o_address` AS `Addr`,`cd`.`o_pw_h_name` AS `PW_H_Name`,`cd`.`o_baby_numbers` AS `Baby_numbers`,`cd`.`o_pwid` AS `PWID`, DATE_FORMAT(`cd`.`o_baby_birthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`,`cd`.`o_mother_status` AS `mother_status`, DATE_FORMAT(`cd`.`Date_Created_Local`,'%m/%d/%Y %h:%m:%s') AS `CollDate`, LPAD(`cd`.`o_unit`,2,'0') AS `Unit`,`cd`.`o_subunit` AS `SubUnit`,`vh`.`SubUnitID` AS `SubUnitID`, IF(((LOCATE('1',`cd`.`o_baby_eat_more_3`) > 0) OR (`cd`.`o_baby_first_eat_3` = 1)),1, NULL) AS `Baby_milk_drank`, IF((`cd`.`o_baby_clean_3` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, DATE_FORMAT((`cd`.`o_baby_birthday` + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`
FROM ((((`Emollient_Flat`.`Emo_Day1_Flat_5_1` `cd`
JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `cd`.`o_hid`)))
LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`o_pwid`) AND ((`d7`.`mother_status` = 2) OR (`d7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay7_Dispatch_download` `dir7` ON(((`dir7`.`PWID` = `cd`.`o_pwid`) AND ((`dir7`.`mother_status` = 2) OR (`dir7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay29` `d29` ON(((`d29`.`PWID` = `cd`.`o_pwid`) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2)))))
WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`dir7`.`PWID`) AND ISNULL(`d29`.`PWID`) AND (`cd`.`o_baby_birth_status_3` = 1) AND (NOW() BETWEEN (`cd`.`o_baby_birthday` + INTERVAL 29 DAY) AND (`cd`.`o_baby_birthday` + INTERVAL 45 DAY)))