SELECT * FROM ig_clone.users;
-- instagram user analytics
-- Description:
-- User analysis is the process by which we can track how user engage and interact with our digital 
-- product (software or mobile application)
-- in an attempt to derive business insight for marketing ,product and development teams.
-- 1.find the 5 oldest user of the instagram from the database provied
Select username,created_at from users
order by created_at
limit 5;
-- Q2.Find the user who has never posted a single photo in Instagram.
Select * from photos,users;
Select * from users u left join photos p 
on p.user_id=u.id
where p.image_url is null 
order by u.username;
-- Q.3 Identify the winner of the contest and provide their details to the team.
Select likes.photo_id ,users.username,count(likes.user_id) as likess
from likes inner join photos on likes.photo_id=photos.id
inner join users on photos.user_id=users.id
group by likes.photo_id,users.username
order by likess desc;
-- Q4.Identify and suggest the top 5 most commonly used hashtag on the platform.
Select * from photo_tags,tags;
Select t.tag_name,count(p.photo_id) as ht from photo_tags p inner join tags t 
on t.id=p.tag_id
group by t.tag_name
order by ht
desc limit 5;
-- Q5.What day of the week do most users register on? Provide insights on when to schedule an ad campaign.
Select date_format((created_at),'%W') as dayy,count(username) from users 
group by 1
order by 2 desc;
-- Q6.Provide how many times does avgerage user post on instagram .Also provide the total number 
-- of photo on instagram/total number of users.
Select * from photos;
Select * from users;
-- total number of users are 100 
-- avg photo post per user is 257/100=2.57 
with base as (
select u.id as userid,count(p.id) as photoid from users u left join photos p on p.user_id=u.id group by u.id)
Select sum(photoid) as totalphotos,count(userid) as total_users,sum(photoid)/count(userid) as photoperuser
from base;
-- Provide data on users (bot) who have liked every single photo on the site (since any normal user 
-- would not able to do this)
Select * from users,likes;
with base as(
select u.username,count(l.photo_id) as likess from likes l inner join users u on 
u.id=l.user_id
group by u.username)
Select username,likess from base 
where likess=(Select count(*) from photos) 
order by username;
