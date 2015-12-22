-- Emo_Day1_Flat_5_1 baby 1
 
SELECT `vh`.`BlockCode` AS `BlockCode`
,`vh`.`Village` AS `Village`
,`vh`.`VID` AS `VID`
,`vh`.`Hamlet` AS `Hamlet`
,`vh`.`HID` AS `HID`
,`cd`.`o_address` AS `Addr`
,`cd`.`o_pw_h_name` AS `PW_H_Name`
,`cd`.`o_baby_numbers` AS `Baby_numbers`
,`cd`.`o_pwid` AS `PWID`
, DATE_FORMAT(`cd`.`o_baby_birthday`,'%m/%d/%Y %h:%m:%s') AS `DelDate`
,`cd`.`o_mother_status` AS `mother_status`
, DATE_FORMAT(`cd`.`o_form_recorded_on`,'%m/%d/%Y %h:%m:%s') AS `CollDate`
, LPAD(`cd`.`o_unit`,2,'0') AS `Unit`
,`cd`.`o_subunit` AS `SubUnit`
,`vh`.`SubUnitID` AS `SubUnitID`
, IF((`cd`.`o_baby_clean_1` BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`
,`cd`.`o_baby_eat_more_1` AS `o_Baby_Eat_More_1`
,`cd`.`o_baby_first_eat_1` AS `o_Baby_First_Eat_1`
, IF(((LOCATE('1',`cd`.`o_baby_eat_more_1`) > 0) OR (`cd`.`o_baby_first_eat_1` = 1)),1, NULL) AS `Baby_milk_drank`, DATE_FORMAT((`cd`.`o_baby_birthday` + INTERVAL 28 DAY),'%Y-%m-%d %r') AS `PdEndsOn`

FROM (((`Emollient_Flat`.`Emo_Day1_Flat_5_1` `cd`

LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `cd`.`o_pwid`) AND ((`d7`.`mother_status` = 2) OR ((`d7`.`respon_ready` IN (1,2)) AND (IFNULL(`d7`.`mother_status`,2) <> 1)) OR (`d7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Raw`.`CurrentDay7_Dispatch_download` `dir7` ON(((`dir7`.`PWID` = `cd`.`o_pwid`) AND ((`dir7`.`mother_status` = 2) OR ((`dir7`.`respon_ready` IN (1,2)) AND (IFNULL(`dir7`.`mother_status`,2) <> 1)) OR (`dir7`.`baby_status` = 2)))))
LEFT JOIN `Emollient_Views`.`V_UnitAllotments` `vh` ON((`vh`.`HID` = `cd`.`o_hid`)))

WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`dir7`.`PWID`) AND (`cd`.`o_baby_birth_status_1` = 1) AND (NOW() BETWEEN (`cd`.`o_baby_birthday` + INTERVAL 7 DAY) AND (`cd`.`o_baby_birthday` + INTERVAL 28 DAY))) 

========================================================================================================
BABY

SELECT 
d1pw.o_who_cluster_id as WHO_Cluster_ID,
LPAD(`d1pw`.`o_unit`,2,'0') AS `Unit`,
d1pw.o_subunit as Subunit,
d1pw.o_subunit_id as SubUnitID,
d1pw.o_cri as Interviewer,
d1pw.o_dsid as DSID,
d1pw.o_village_name as VillageName,
d1pw.o_prsnt_vid as VID,
d1pw.o_hamlet_name as HamletName,
d1pw.o_prsnt_hid as HID,
d1pw.o_address as  Address,
d1pw.o_pw_h_name as PW_H_Name,
d1pw.o_pwid as PWID,
d1pw.o_mother_status as Mother_Status,

d1b.baby_id as Baby_ID,
d1b.o_unique_baby_id as Unique_Baby_ID,
DATE_FORMAT(`d1b`.`o_baby_birthday`,'%m/%d/%Y %h:%m:%s') AS `Baby_birth_date`,
d1b.o_baby_numbers as Baby_Number,
d1b.o_baby_birth_status as Baby_Birth_Status,
IF((d1b.o_baby_clean BETWEEN 5 AND 7),1, NULL)AS `Baby_bath_taken`,
d1b.o_baby_eat_more as Baby_Eat_More,
d1b.o_baby_first_eat as Baby_First_Eat,
IF(((LOCATE('1',`d1b`.`o_baby_eat_more`) > 0) OR (`d1b`.`o_baby_first_eat` = 1)),1, NULL) AS `Baby_milk_drank`,

DATE_FORMAT(`d1pw`.`o_form_recorded_on`,'%m/%d/%Y %h:%m:%s') AS `CollDate`,
DATE_FORMAT((`d1b`.`o_baby_birthday` + INTERVAL 28 DAY),'%Y-%m-%d %r') AS `PdEndsOn`


FROM Emollient_normalized.Emo_Day1_Flat_5_1_Baby d1b left join  Emollient_normalized.Emo_Day1_Flat_5_1_PW d1pw
ON d1pw.o_pwid = d1b.o_pwid

-- LEFT JOIN Emollient_Flat.Emo_day7_flat_1_6 d716 on d716.pwid = d1pw.pwid and 

LEFT JOIN `Emollient_Raw`.`CurrentDay7` `d7` ON(((`d7`.`PWID` = `d1pw`.`o_pwid`) AND ((`d7`.`mother_status` = 2) OR ((`d7`.`respon_ready` IN (1,2)) AND (IFNULL(`d7`.`mother_status`,2) <> 1)) OR (`d7`.`baby_status` = 2))))

LEFT JOIN `Emollient_Raw`.`CurrentDay7_Dispatch_download` `dir7` ON(((`dir7`.`PWID` = `d1pw`.`o_pwid`) AND ((`dir7`.`mother_status` = 2) OR ((`dir7`.`respon_ready` IN (1,2)) AND (IFNULL(`dir7`.`mother_status`,2) <> 1)) OR (`dir7`.`baby_status` = 2))))

WHERE (ISNULL(`d7`.`PWID`) AND ISNULL(`dir7`.`PWID`) AND (d1b.o_baby_birth_status = 1) AND (NOW() BETWEEN (`d1b`.`o_baby_birthday` + INTERVAL 7 DAY) AND (`d1b`.`o_baby_birthday` + INTERVAL 28 DAY))) 