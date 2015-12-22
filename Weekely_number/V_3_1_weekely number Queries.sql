
================================================
Day1Done:-

SELECT t.PWID, t.PrsntVillage FROM (
SELECT distinct PWID,PrsntVillage, PrsntHamlet,PrsntAddress,PW_H_Name,DeliveryDate FROM Emollient_Raw.Day1_3_0 where DeliveryDate is not null 
UNION
SELECT distinct PWID,`PrsntVillage`,`PrsntHamlet`,`PrsntAddress`,`PW_H_Name`,`BabyBirthday`  FROM Emollient_Raw.CurrentDay1 where `BabyBirthday` is not null AND date(date_created_local) <'2015-12-19'
UNION
SELECT distinct PWID,PrsntVillage,PrsntHamlet,PrsntAddress,null as PW_H_Name,BabyBirthday FROM
Emollient_Raw.Day1_4_4  where BabyBirthday is not null
union
SELECT `PWID_1`,`Prsnt_Village_1`, `Prsnt_Hamlet_1`, `Prsnt_Address_1`, `PW_H_Name_1`,`Baby_Birthday_1` FROM `Emo_day1_4_6`
where `Baby_Birthday_1` is not null and  date(start)<'2015-12-19' 
union
SELECT distinct temp_PWID,`Village_Name_1`,`Hamlet_Name_1`,`Address_1`,`PW_H_Name_1`,`Baby_Birthday` FROM Emollient_Raw.Emo_Direct_Day1_1_1 where `Baby_Birthday` is not null AND date(date_created_local) <'2015-12-19'
union
SELECT distinct `o_pwid`,`o_village_name`,`o_hamlet_name`,`o_address`,`o_pw_h_name`,`o_baby_birthday` FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where `o_baby_birthday` is not null AND date(Date_Created_Local) <'2015-12-19')
as t
group by t.PWID
==================Day1 TNA====================================
-- Day1 4.4 TNA
SELECT `PWID`
FROM Emollient_Raw.`Day1_4_4`
where concat(Pwid,`Date_Created_Local`) in (select concat(PWid,max(`Date_Created_Local`))
FROM Emollient_Raw.`Day1_4_4` group by PWid )
and Respon_status='2'
union
-- currentday1-TNA 4.5
SELECT `PWID` FROM Emollient_Raw.`CurrentDay1`
where concat(Pwid,`Date_Created_Local`) in (select concat(PWid,max(`Date_Created_Local`))
FROM Emollient_Raw.`CurrentDay1` group by PWid )
and mother_status='1' and Date_created_Local<'2015-12-19'
union
-- Emo_day1_4_6 -TNA
SELECT `PWID_1` FROM Emollient_Raw.`Emo_day1_4_6`
where concat(Pwid_1,`start`) in (select concat(PWid_1,max(`start`))
FROM Emollient_Raw.`Emo_day1_4_6` group by PWid_1 )
and mother_status_1='1' and start<'2015-12-19' and Baby_Birthday_1 is null
union
-- Emo_Direct_Day1_1_1 -TNA
SELECT distinct temp_PWID
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where concat(temp_PWID,`start`) in (select concat(temp_PWID,max(`start`))
FROM Emollient_Raw.Emo_Direct_Day1_1_1  group by temp_PWID )
and Mother_Status_1='1' and start<'2015-12-19' and Baby_Birthday is null
union
-- Emo_Day1_Flat_5_1  -TNA
SELECT distinct `o_pwid`
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where concat(`o_pwid`,`start`) in (select concat(`o_pwid`,max(`start`))
FROM Emollient_Flat.Emo_Day1_Flat_5_1  group by `o_pwid` )
and o_mother_status='1' and start<'2015-12-19' and o_baby_birthday is null



=====================PNA DAy1===============================

-- PNA DAY1
-- Day1 4.4 pna
SELECT t.PWID FROM  (
SELECT `PWID`
 FROM Emollient_Raw.`Day1_4_4`
where concat(Pwid,`Date_Created_Local`) in (select concat(PWid,max(`Date_Created_Local`))
FROM Emollient_Raw.`Day1_4_4` group by PWid )
and Respon_status='3'
union
-- currentday1-pna
SELECT `PWID` FROM Emollient_Raw.`CurrentDay1`
where concat(Pwid,`Date_Created_Local`) in (select concat(PWid,max(`Date_Created_Local`))
FROM Emollient_Raw.`CurrentDay1` group by PWid )
and mother_status='2' and Date_created_Local < '2015-12-19'
union
-- Emo_day1_4_6 -pna
SELECT `PWID_1` FROM Emollient_Raw.`Emo_day1_4_6`
where concat(Pwid_1,`start`) in (select concat(PWid_1,max(`start`))
FROM Emollient_Raw.`Emo_day1_4_6` group by PWid_1 )
and mother_status_1='2' and Baby_Birthday_1 is null and start < '2015-12-19' 
union
-- Emo_Direct_Day1_1_1
SELECT distinct temp_PWID
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where concat(temp_PWID,`start`) in (select concat(temp_PWID,max(`start`))
FROM Emollient_Raw.Emo_Direct_Day1_1_1  group by temp_PWID )
and Mother_Status_1='2' and Baby_Birthday is null and start < '2015-12-19' 
union
-- Emo_Day1_Flat_5_1
SELECT distinct `o_pwid`
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where concat(`o_pwid`,`start`) in (select concat(`o_pwid`,max(`start`))
FROM Emollient_Flat.Emo_Day1_Flat_5_1  group by `o_pwid` )
and o_mother_status='2' and o_baby_birthday is null and start < '2015-12-19'  ) 
as t
group by t.pwid

=================Day1 NND=================================
-- Day1-NND
SELECT distinct `PWID`,`Baby_birth_status` FROM `CurrentDay1`
where `Baby_birth_status` =2  and date_created_Local<'2015-12-19'
union
SELECT distinct `PWID`,`Baby_birth_status` FROM `Day1_4_4`
where `Baby_birth_status` =2
union
SELECT distinct `PWID_1`,`Baby_birth_status_1_1` FROM `Emo_day1_4_6`
where `Baby_birth_status_1_1` =2 and start<'2015-12-19'
union all
SELECT distinct `PWID_1`,`Baby_birth_status_1_2` FROM `Emo_day1_4_6`
where `Baby_birth_status_1_2` =2 and start<'2015-12-19'
union all
SELECT distinct `PWID_1`,`Baby_birth_status_1_3` FROM `Emo_day1_4_6`
where `Baby_birth_status_1_3`=2 and start<'2015-12-19'
union 
SELECT distinct `o_pwid`,o_baby_birth_status_1 FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_1=2 and start<'2015-12-19'
union all
SELECT distinct `o_pwid`,o_baby_birth_status_2 FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_2=2 and start<'2015-12-19'
union all
SELECT distinct `o_pwid`,o_baby_birth_status_3 FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_3=2 and start<'2015-12-19'
union
SELECT distinct `temp_PWID`,Baby_birth_status_1_1 FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_1=2 and start<'2015-12-19'
union all
SELECT distinct `temp_PWID`,Baby_birth_status_1_2 FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_2=2 and start<'2015-12-19'
union all
SELECT distinct `temp_PWID`,Baby_birth_status_1_3 FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_3=2 and start<'2015-12-19'

=========================Day1 SB==============================
-- Day1-SB

SELECT distinct `PWID`,`Baby_birth_status` FROM `CurrentDay1`
where `Baby_birth_status` =3  and date_created_Local < '2015-12-19'
union
SELECT distinct `PWID`,`Baby_birth_status` FROM `Day1_4_4`
where `Baby_birth_status` =3
union
SELECT distinct `PWID_1`,`Baby_birth_status_1_1` FROM `Emo_day1_4_6`
where `Baby_birth_status_1_1` =3 and start < '2015-12-19'
union
SELECT distinct `PWID_1`,`Baby_birth_status_1_2` FROM `Emo_day1_4_6`
where `Baby_birth_status_1_2` =3 and start < '2015-12-19'
union
SELECT distinct `PWID_1`,`Baby_birth_status_1_3` FROM `Emo_day1_4_6`
where `Baby_birth_status_1_3`=3 and start < '2015-12-19'
union
SELECT distinct `o_pwid`,o_baby_birth_status_1 FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_1=3 and start < '2015-12-19'
union
SELECT distinct `o_pwid`,o_baby_birth_status_2 FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_2=3 and start < '2015-12-19'
union
SELECT distinct `o_pwid`,o_baby_birth_status_3 FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_3=3 and start < '2015-12-19'
union
SELECT distinct `temp_PWID`,Baby_birth_status_1_1 FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_1=3 and start < '2015-12-19'
union
SELECT distinct `temp_PWID`,Baby_birth_status_1_2 FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_2=3 and start < '2015-12-19'
union
SELECT distinct `temp_PWID`,Baby_birth_status_1_3 FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_3=3 and start < '2015-12-19'


============Intervention SB=======================
-- InterVention-SB
SELECT distinct a.PWID FROM `Day1SB`a join AMANHI_Raw.MiniPSS b on a.PWID=b.PWID Left join V_UnitAllotments V on b.VillageName=V.village
where V.`Allocation`='intervention'

=============Intervention Day1 Due==============
-- Intervention-Day1Due
SELECT distinct a.PWID FROM `Day1Due`a join V_UnitAllotments v on v.village=a.PrsntVillage
where v.Allocation='intervention'

====================day1 Due============================
-- Day1Due:-
select t.pwid from (
-- Day1 3.0
SELECT distinct PWID,PrsntVillage FROM Emollient_Raw.Day1_3_0 where DeliveryDate is not null
UNION
-- Current day1
SELECT distinct PWID,`PrsntVillage`  FROM Emollient_Raw.CurrentDay1 where `BabyBirthday` is not null AND date(date_created_local) <'2015-12-19'
UNION
-- Day1 4.4
SELECT distinct PWID,PrsntVillage FROM
Emollient_Raw.Day1_4_4  where BabyBirthday is not null
union
-- Day1 4.6
SELECT `PWID_1`,`Prsnt_Village_1` FROM Emollient_Raw.`Emo_day1_4_6`
where `Baby_Birthday_1` is not null and  date(start)<'2015-12-19'
union
-- Combined deliveries
SELECT WomanID,VillageName FROM Emollient_Views.`V_CombinedDeliveries`
where  Datediff(DelRecrdedOn,OutcomeDate)<8 and DelRecrdedOn<'2015-12-19' and evalstartedon<outcomedate 
union
-- Day1 5.1
SELECT distinct `o_pwid`,o_village_name
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where `o_baby_birthday` is not null and  date(start)<'2015-12-19'
union
-- Day1 Direct
SELECT distinct temp_PWID,Village_Name_1
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where `Baby_Birthday` is not null and  date(start)<'2015-12-19')
as t
group by t.pwid

=================Day7 Done===================================
-- Day 7 done

select t.pwid from (
-- Day 7 1.3
SELECT distinct pwid FROM Emollient_Raw.`Day7_1_3` WHERE resp_status = 1 
union 
-- Current Day 7 
SELECT distinct pwid FROM Emollient_Raw.`CurrentDay7` WHERE respon_ready = 1 and date_created_local < '2015-12-19' 
union 
-- Current Day 7 Dispatch
SELECT distinct pwid FROM Emollient_Raw.`CurrentDay7_Dispatch_download` WHERE respon_ready= 1 and date_created_local < '2015-12-19' ) as t
group by t.pwid

===================day7 deaths=============================
-- Day 7 death
select t.pwid from (
-- Day 7 1.3
SELECT distinct pwid FROM `Day7_1_3` WHERE baby_status = 2 
union 
-- Current Day 7
SELECT distinct pwid FROM `CurrentDay7` WHERE baby_status = 2 and date_created_local < '2015-12-19' 
union 
-- Current day 7 Dispatch
SELECT distinct pwid FROM `CurrentDay7_Dispatch_download` WHERE baby_status= 2 and date_created_local < '2015-12-19' ) as t
group by t.pwid

==================Day7 TNA=======================
-- Day 7 TNA

-- Day 7 1.3
SELECT distinct pwid, mother_status, resp_status, "Day7_1_3" as Tbl FROM `Day7_1_3`
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `Day7_1_3` group by pwid) 
and resp_status = 2
union 
-- Current Day 7 
SELECT distinct pwid, mother_status, respon_ready,  "CurrentDay7" as Tbl
FROM `CurrentDay7` 
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `CurrentDay7` group by pwid)
and  mother_status = 1 and date_created_local < '2015-12-19' 
union 
-- Current Day 7 Dispatch
SELECT distinct pwid, mother_status, respon_ready, "CurrentDay7_Dispatch_download" as Tbl
FROM `CurrentDay7_Dispatch_download` 
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `CurrentDay7_Dispatch_download` group by pwid)
and mother_status = 1 and date_created_local < '2015-12-19'

====================day7 PNA============================
-- Day 7 PNA

-- Day 7 1.3
SELECT distinct pwid, mother_status, resp_status, "Day7_1_3" as Tbl FROM `Day7_1_3`
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `Day7_1_3` group by pwid) 
and resp_status = 3
union 
-- Current Day 7
SELECT distinct pwid, mother_status, respon_ready,  "CurrentDay7" as Tbl
FROM `CurrentDay7` 
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `CurrentDay7` group by pwid)
and  mother_status = 2 and date_created_local < '2015-12-19' 
union 
-- Current Day 7 Dispatch
SELECT distinct pwid, mother_status, respon_ready, "CurrentDay7_Dispatch_download" as Tbl
FROM `CurrentDay7_Dispatch_download` 
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `CurrentDay7_Dispatch_download` group by pwid)
and mother_status = 2 and date_created_local < '2015-12-19'

=================Day7 Due===============================
-- Day7 Due, replace difference date and date_created
-- Day 1 3.0
SELECT t.PWID, t.PrsntVillage FROM (
SELECT distinct PWID,PrsntVillage FROM Emollient_Raw.Day1_3_0 where DeliveryDate is not null and datediff('2015-12-18',DATE(DeliveryDate)) >7

UNION
-- CurrentDay1
SELECT distinct PWID,`PrsntVillage` FROM Emollient_Raw.CurrentDay1 where `BabyBirthday` is not null AND date(date_created_local) <'2015-12-19' and datediff('2015-12-18',date(BabyBirthday)) >7

UNION
-- Day 1 4.4
SELECT distinct PWID,PrsntVillage FROM
Emollient_Raw.Day1_4_4  where BabyBirthday is not null and datediff('2015-12-18',date(BabyBirthday)) >7

union
-- Day 1 4.6
SELECT `PWID_1`,`Prsnt_Village_1` FROM `Emo_day1_4_6`
where `Baby_Birthday_1` is not null and  date(start)<'2015-12-19' and datediff('2015-12-18',date(Baby_Birthday_1)) >7
union
-- Day 1 5.1
SELECT distinct `o_pwid`,o_village_name
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where `o_baby_birthday` is not null and  date(start)<'2015-12-19'and datediff('2015-12-18',date(o_baby_birthday)) >7
union
-- Day 1 direct 1.1
SELECT distinct temp_PWID,Village_Name_1
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where `Baby_Birthday` is not null and  date(start)<'2015-12-19'and datediff('2015-12-18',date(Baby_Birthday)) >7

) as t

group by t.PWID

======================Day29 Done=================================
-- Day 29 done
select t.pwid from (
SELECT distinct pwid FROM `Day29_2_2` WHERE respondent_status =1 
union 
SELECT distinct pwid FROM `CurrentDay29` 
	WHERE respon_ready = 1 and date(date_created_local) < '2015-12-19' ) as t
group by t.pwid

=================Day29 TNA===========================
-- Day 29 TNA
SELECT distinct pwid FROM `Day29_2_2` 
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `Day29_2_2` group by pwid)
and respondent_status = 2
union 
SELECT distinct pwid FROM `CurrentDay29` 
	where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `CurrentDay29` group by pwid)
and mother_status = 1 and date_created_local < '2015-12-19' 

==============Day29 PNA==============================
-- Day 29 PNA
SELECT distinct pwid FROM `Day29_2_2` 
where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
from `Day29_2_2` group by pwid)
and respondent_status = 3
union 
SELECT distinct pwid FROM `CurrentDay29` 
	where concat(pwid, date_created_local) in (select concat(pwid, max(date_created_local))
		from `CurrentDay29` group by pwid)
and mother_status = 2 and date_created_local < '2015-12-19' 

======================day29 Deaths==========================
-- Day29 Death
select t.pwid from (
SELECT distinct pwid FROM `Day29_2_2` WHERE baby_status = 2
union 
SELECT distinct pwid FROM `CurrentDay29` 
	WHERE baby_status = 2 and date(date_created_local) < '2015-12-19' ) as t
group by t.pwid

==============day29 Due=======================
-- Day29 Due, change date in difference and date_created

SELECT t.PWID, t.PrsntVillage FROM (
SELECT distinct PWID,PrsntVillage FROM Emollient_Raw.Day1_3_0 where DeliveryDate is not null and datediff('2015-12-18',DATE(DeliveryDate)) >28

UNION

SELECT distinct PWID,`PrsntVillage` FROM Emollient_Raw.CurrentDay1 where `BabyBirthday` is not null AND date(date_created_local) <'2015-12-19' and datediff('2015-12-18',date(BabyBirthday)) >28

UNION

SELECT distinct PWID,PrsntVillage FROM
Emollient_Raw.Day1_4_4  where BabyBirthday is not null and datediff('2015-12-18',date(BabyBirthday)) >28

union

SELECT `PWID_1`,`Prsnt_Village_1` FROM `Emo_day1_4_6`
where `Baby_Birthday_1` is not null and  date(start)<'2015-12-19' and datediff('2015-12-18',date(Baby_Birthday_1)) >28
union

SELECT `PWID_1`,`Prsnt_Village_1` FROM `Emo_day1_4_6`
where `Baby_Birthday_1` is not null and  date(start)<'2015-12-19' and datediff('2015-12-18',date(Baby_Birthday_1)) >28
union
SELECT distinct `o_pwid`,o_village_name
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where `o_baby_birthday` is not null and  date(start)<'2015-12-19'and datediff('2015-12-18',date(o_baby_birthday)) >28
union
SELECT distinct temp_PWID,Village_Name_1
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where `Baby_Birthday` is not null and  date(start)<'2015-12-19'and datediff('2015-12-18',date(Baby_Birthday)) >28



) as t

group by t.PWID

======================Baseline Completion========================
select sum(t.cnt) as TotRec
from
(
select "Base 2,0" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_2_0` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_2_0`
group by pwid) 
union
select "Base 3.1" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_3_1` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_3_1`
group by pwid)  
union
select "Base 3.2" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_3_2` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_3_2` 
group by pwid) 
union
select "Base 4.2" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_4_2` 
where `Status_respo` = 1
and concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_2` 
group by pwid)
union
select "Base 4.3" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_4_3` 
where `Status_respo` = 1
and concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_3` 
group by pwid)
union
select "Base 4.4" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_4_4` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_4_4` 
group by pwid)
union
select "Base 4.7" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_4_7` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_4_7` 
group by pwid)
union
select "Base 4.8" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`Baseline_4_8` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_4_8` 
group by pwid)
union
select "Base Curr" as tbl, count(distinct pwid) as cnt
from Emollient_Raw.`CurrentBaseline` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`CurrentBaseline` 
group by pwid)
and date_created_local < '2015-12-19') as t

=================================================================
-- Total and PNA of Baseline
select "Base 2,0" as tbl, count(distinct pwid) as Completed, 0 as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_2_0` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_2_0`
group by pwid) 
union
select "Base 3.1" as tbl, count(distinct pwid) as Completed, 0 as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_3_1` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_3_1`
group by pwid)  
union
select "Base 3.2" as tbl, count(distinct pwid) as Completed, 0 as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_3_2` 
where concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) 
from Emollient_Raw.`Baseline_3_2` 
group by pwid) 
union
select "Base 4.2" as tbl, count(distinct (if (Status_respo = 1, pwid, NULL))) as  Completed, 
count(distinct (if (Status_respo = 3, pwid, NULL))) as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw
.`Baseline_4_2` 
where 
-- `Status_respo` = 1
-- and 
concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_2` 
group by pwid)
union
select "Base 4.3" as tbl, count(distinct (if (Status_respo = 1, pwid, NULL))) as  Completed, 
count(distinct (if (Status_respo = 3, pwid, NULL))) as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_4_3` 
where 
-- `Status_respo` = 1
-- and 
concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_3` 
group by pwid)
union
select "Base 4.4" as tbl, count(distinct (if (Status_respo = 1, pwid, NULL))) as  Completed, 
count(distinct (if (Status_respo = 3, pwid, NULL))) as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_4_4` 
where 
-- `Status_respo` = 1
-- and 
concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_4` 
group by pwid)
union
select "Base 4.7" as tbl, count(distinct (if (Status_respo = 1, pwid, NULL))) as  Completed, 
count(distinct (if (mother_status = 2, pwid, NULL))) as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_4_7` 
where 
-- `Status_respo` = 1
-- and 
concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_7` 
group by pwid)
union
select "Base 4.8" as tbl, count(distinct (if (Status_respo = 1, pwid, NULL))) as  Completed, 
count(distinct (if (mother_status = 2, pwid, NULL))) as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`Baseline_4_8` 
where 
-- `Status_respo` = 1
-- and 
concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`Baseline_4_8` 
group by pwid)
union
select "Curr Base" as tbl, count(distinct (if (Status_respo = 1, pwid, NULL))) as  Completed, 
count(distinct (if (mother_status = 2, pwid, NULL))) as PNA, 0 as TNA, count(distinct pwid) as Totcnt
from Emollient_Raw.`CurrentBaseline` 
where 
-- `Status_respo` = 1
-- and 
concat(pwid, date_created_local) in
(select concat(pwid, max(date_created_local)) from 
Emollient_Raw.`CurrentBaseline` 
group by pwid)
and date_created_local < '2015-12-19'

====================================================================================
-- Baseline due calcualtion
SELECT Allocation , count(distinct m.PWID)
FROM AMANHI_Raw.`MiniPSS` m
left join AMANHI_Raw.PSSVillHamWithID p
on m.Cluster = p.ClusterID
and m.VillageName = p.Village
and m.Hamlet = p.Hamlet
join Emollient_Views.V_UnitAllotments v
on v.HID = p.HID
left join Emollient_temp.Deliv_ALL d
on d.WomanID = m.PWID
and d.OutComeDate < d.EvalStartedOn
where m.date_created between '2015-12-12' and '2015-12-18'
and d.WomanID is null
and timestampdiff(WEEK, str_to_date(m.LMP, "%d-%b-%y"), '2015-12-18') >= 24
group by  Allocation with rollup
	
	==================day1 PNA Intervention=============
	
-- day1 4.4	
SELECT t.PWID, t.PrsntVillage, t.VID, alt.Allocation FROM  (
SELECT `PWID`,PrsntVillage, PrsntVID as VID
FROM Emollient_Raw.`Day1_4_4`
where concat(Pwid,`Date_Created_Local`) in (select concat(PWid,max(`Date_Created_Local`))
FROM Emollient_Raw.`Day1_4_4` group by PWid )
and Respon_status='3'
union
-- currentday1-pna
SELECT `PWID`,PrsntVillage, PrsntVID as VID
FROM Emollient_Raw.`CurrentDay1`
where concat(Pwid,`Date_Created_Local`) in (select concat(PWid,max(`Date_Created_Local`))
FROM Emollient_Raw.`CurrentDay1` group by PWid )
and mother_status='2' and Date_created_Local < '2015-12-19'
union
-- Emo_day1_4_6 -pna
SELECT `PWID_1`,Prsnt_Village_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.`Emo_day1_4_6`
where concat(Pwid_1,`start`) in (select concat(PWid_1,max(`start`))
FROM Emollient_Raw.`Emo_day1_4_6` group by PWid_1 )
and mother_status_1='2' and start<'2015-12-19' and Baby_Birthday_1 is null
union
-- Emo_Direct_Day1_1_1
SELECT distinct temp_PWID, Village_Name_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where concat(temp_PWID,`start`) in (select concat(temp_PWID,max(`start`))
FROM Emollient_Raw.Emo_Direct_Day1_1_1  group by temp_PWID )
and Mother_Status_1='2' and start<'2015-12-19' and Baby_Birthday is null
union
-- Emo_Day1_Flat_5_1
SELECT distinct `o_pwid`,o_village_name as PrsntVillage,o_VID as VID
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where concat(`o_pwid`,`start`) in (select concat(`o_pwid`,max(`start`))
FROM Emollient_Flat.Emo_Day1_Flat_5_1  group by `o_pwid` )
and o_mother_status='2' and start<'2015-12-19' and o_baby_birthday is null
) as t
Left join Emollient_Views.V_UnitAllotments as alt on t.VID= alt.VID 
 where alt.Allocation like 'Intervention'
group by t.pwid

=======================day1 SB Intervention=================

Select t.PWID, t.PrsntVillage, t.VID from(
SELECT distinct `PWID`,PrsntVillage , PrsntVID as VID
FROM Emollient_Raw.`CurrentDay1`
where `Baby_birth_status` =3  and date_created_Local<'2015-12-19'
union
SELECT distinct `PWID`,PrsntVillage , PrsntVID as VID
FROM Emollient_Raw.`Day1_4_4` 
where `Baby_birth_status` =3 
union
SELECT distinct `PWID_1` as PWID,Prsnt_Village_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.`Emo_day1_4_6`
where `Baby_birth_status_1_1` =3 and start<'2015-12-19'
union
SELECT distinct `PWID_1` as PWID ,Prsnt_Village_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.`Emo_day1_4_6`
where `Baby_birth_status_1_2` =3 and start<'2015-12-19'
union
SELECT distinct `PWID_1` as PWID ,Prsnt_Village_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.`Emo_day1_4_6`
where `Baby_birth_status_1_3`=3 and start<'2015-12-19'
union
SELECT distinct `o_pwid` as PWID ,o_village_name as PrsntVillage,o_VID as VID
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_1=3 and start<'2015-12-19'
union
SELECT distinct `o_pwid` as PWID ,o_village_name as PrsntVillage,o_VID as VID
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_2=3 and start<'2015-12-19'
union
SELECT distinct `o_pwid` as PWID ,o_village_name as PrsntVillage,o_VID as VID
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where o_baby_birth_status_3=3 and start<'2015-12-19'
union
SELECT distinct `temp_PWID` as PWID , Village_Name_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_1=3 and start<'2015-12-19'
union
SELECT distinct `temp_PWID` as PWID , Village_Name_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_2=3 and start<'2015-12-19'
union
SELECT distinct `temp_PWID` as PWID , Village_Name_1 as PrsntVillage, Prsnt_VID_1 as VID
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where Baby_birth_status_1_3=3 and start<'2015-12-19')
as t
Left join Emollient_Views.V_UnitAllotments as alt on t.VID= alt.VID 
where alt.Allocation = 'Intervention'
group by t.pwid

===============Intervention day1 Due====================

select t.pwid,t.VID from (
SELECT distinct PWID,PrsntVID as VID FROM Emollient_Raw.Day1_3_0 where DeliveryDate is not null
UNION
SELECT distinct PWID,`PrsntVID` as VID  FROM Emollient_Raw.CurrentDay1 where `BabyBirthday` is not null AND date(date_created_local) <'2015-12-19'
UNION
SELECT distinct PWID,PrsntVID as VID  FROM
Emollient_Raw.Day1_4_4  where BabyBirthday is not null
union
SELECT `PWID_1`,`Prsnt_VID_1` as VID  FROM Emollient_Raw.`Emo_day1_4_6`
where `Baby_Birthday_1` is not null and  date(start)<'2015-12-19'
union
SELECT WomanID,VID as VID FROM Emollient_Views.`V_CombinedDeliveries`
where  Datediff(DelRecrdedOn,OutcomeDate)<8 and DelRecrdedOn<'2015-12-19' and evalstartedon<outcomedate 
union
SELECT distinct `o_pwid`,o_vid as VID 
FROM Emollient_Flat.Emo_Day1_Flat_5_1 
where `o_baby_birthday` is not null and  date(start)<'2015-12-19'
union
SELECT distinct temp_PWID,Prsnt_VID_1 as VID 
FROM Emollient_Raw.Emo_Direct_Day1_1_1
where `Baby_Birthday` is not null and  date(start)<'2015-12-19')

as t
Left join Emollient_Views.V_UnitAllotments as alt on t.VID = alt.VID
where alt.Allocation = 'Intervention'
group by t.pwid



=================================Baseline Done week============================================
SELECT distinct pwid FROM `CurrentBaseline` where DATE(Date_Created_Local) between '2015-12-12' and '2015-12-18' and Status_respo = 1

=================================Baseline TNA==================================================
 SELECT distinct pwid FROM `CurrentBaseline` where DATE(Date_Created_Local) between '2015-12-12' and '2015-12-18' and mother_status = 1

