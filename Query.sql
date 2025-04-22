use ig_clone;

# A. Marketing Analysis
# Task 1 : Identify the five oldest users on Instagram from the provided database.

select * from users
 order by created_at
 limit 5;
 
 # Task 2 : Identify users who have never posted a single photo on Instagram.

select u.id, u.username, p.image_url
from users u
left join photos p on u.id = p.user_id
where p.id is null
order by u.username;
 
 # Task 3 : Determine the winner of the contest and provide their details to the team.
 
 select u.username, p.id, count(l.user_id) as total_likes
 from photos p
 join users u on p.user_id = u.id
 join likes l on p.id = l.photo_id
 group by u.username, p.id
 order by total_likes desc
 limit 1;
 
 # Task 4 : Identify and suggest the top five most commonly used hashtags on the platform.
 
select tags.tag_name, count(*) as total_tag
from photo_tags
join tags on photo_tags.tag_id = tags.id
group by tags.id
order by total_tag desc
limit 5;

# Task 5 : Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.
 
 select dayname(created_at) as day_of_week, count(*) as total_users
 from users
 group by day_of_week
 order by total_users desc;
 
 # B. Investor Metrics
 # Task 1 : Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.
 
select
    (select count(*)
        from photos)
        /
     (select distinct count(*) 
		from users) as average_post;

# Task 2 : Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
 
 select users.id, users.username
 from users
 join likes on users.id = likes.user_id
 group by users.id ,
         users.username
 having 
       count(distinct likes.photo_id) = 
       (select count(*)
        from photos);
        
