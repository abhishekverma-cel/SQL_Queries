======================================================================================================================
SELECT 

d1pw.o_who_cluster_id as WHO_Cluster,
d1pw.o_prsnt_vid as VID,
d1pw.o_village_name as Village,
d1pw.o_prsnt_hid as HID,
d1pw.o_hamlet_name as Hamlet,
d1pw.o_address as Address,
d1b.o_pwid as PWID,
d1b.baby_id as Baby_ID,
d1b.o_unique_baby_id as Unique_Baby_ID,
DATE_FORMAT(d1b.o_baby_birthday,'%m/%d/%Y %h:%m:%s') AS Baby_Birthday,
d1pw.o_mother_status as Mother_status,
DATE_FORMAT(d1b.Date_Created_Local,'%m/%d/%Y %h:%m:%s') AS `CollDate`,
LPAD(d1pw.o_unit,2,0) as Unit,
d1pw.o_subunit as SubUnit,
d1pw.o_subunit_id as SubUnitID,
IF(((LOCATE('1',d1b.o_baby_eat_more) > 0) OR (d1b.o_baby_first_eat = 1)),1, NULL) AS `Baby_milk_drank`,
IF((d1b.o_baby_clean BETWEEN 5 AND 7),1, NULL) AS `Baby_bath_taken`, 
DATE_FORMAT((d1b.o_baby_birthday + INTERVAL 45 DAY),'%Y-%m-%d %r') AS `PdEndsOn`



FROM `Emollient_normalized`.`Emo_Day1_Flat_5_1_Baby` d1b
join Emollient_normalized.Emo_Day1_Flat_5_1_PW d1pw on d1pw.o_pwid = d1b.o_pwid 

-- minus CurrentDay7 Dispatch

LEFT JOIN `Emollient_Raw`.`CurrentDay7_Dispatch_download` `dir7` ON(`dir7`.`PWID` = `d1b`.`o_pwid`) AND ((`dir7`.`mother_status` = 2) OR (`dir7`.`baby_status` = 2)) 

-- minus Day7 1.6
LEFT JOIN  Emollient_Flat.Emo_day7_flat_1_6 d716 ON (d716.s_PWID = d1b.o_pwid) and (d716.s_Baby_ID = d1b.baby_id)
 AND ((d716.s_Mother_Status = 2) OR (d716.s_Baby_birth_status = 2)) -- Mother PNA or Baby Dead in Day7
 
-- minus Current Day7 
LEFT JOIN Emollient_Raw.CurrentDay7 cd7 ON (cd7.PWID = d1b.o_pwid) and ((cd7.mother_status = 2) or (cd7.baby_status = 2))
 
 -- minus CurrentDay29
LEFT JOIN  Emollient_Raw.CurrentDay29 d29 ON (d29.PWID = d1b.o_pwid) AND ((`d29`.`mother_status` = 2) OR ((`d29`.`respon_ready` IN (1,2)) AND (IFNULL(`d29`.`mother_status`,2) <> 1)) OR (`d29`.`baby_status` = 2))

-- minus Day29 3.0
LEFT JOIN Emollient_Flat.Emo_Day29_flat_Dispatch_3_0 d2930 ON ( d2930.t_pwid = d1b.o_pwid) AND
((`d2930`.t_mother_status = 2) OR ((d2930.t_Respon_ready IN (1,2)) AND (IFNULL( d2930.t_mother_status ,2) <> 1)) OR (d2930.t_baby_birth_status = 2))


WHERE (ISNULL(`cd7`.`PWID`) AND ISNULL(d716.s_PWID ) AND ISNULL(`d29`.`PWID`) AND ISNULL(d2930.t_pwid) AND ISNULL(dir7.PWID)

AND d1b.o_baby_birth_status = 1 AND NOW() BETWEEN (`d1b`.o_baby_birthday + INTERVAL 29 DAY) AND (`d1b`.o_baby_birthday + INTERVAL 45 DAY))








